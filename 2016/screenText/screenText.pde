import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Rectangle;
import java.awt.MouseInfo;
import java.awt.Point;


PImage screen; 
PFont chivo;
PShader post; 

void setup() {
  size(720, 480, P2D);
  chivo = createFont("Chivo", 6, true);
  textFont(chivo);
  textAlign(LEFT, TOP);

  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
}


void draw() {
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
  post.set("time", millis()/1000.);
  
  screenshot();
  //image(screen, 0, 0, width, height);


  background(#33343B);
  for (int j = 0; j < screen.height; j++) {
    for (int i = 0; i < screen.width; i++) {
      color col = screen.get(i, j);
      fill(col);
      text("#"+hex(col).substring(2, 8), i*25, j*6);
    }
  }

  filter(post);
}

void screenshot() {
  try {
    Robot robot = new Robot();
    Point mouse;
    mouse = MouseInfo.getPointerInfo().getLocation();
    int w = 40*5;
    int h = 80;
    int x = mouse.x;
    int y = mouse.y;
    screen = new PImage(robot.createScreenCapture(new Rectangle(x, y, w, h)));
  }
  catch (AWTException e) {
  }
}