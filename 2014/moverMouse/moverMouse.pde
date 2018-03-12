import java.awt.AWTEvent; //<>//
import java.awt.event.AWTEventListener;
import java.awt.AWTException;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.InputEvent;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Robot;

Robot robby;
boolean rec, play, click;
Lector posmouse;
Point mouse;

void setup() {
  int height = 200;
  size(height, height);
  posmouse = new Lector();
  try {
    robby = new Robot();
    //robby.setAutoDelay(int(1000/60.));
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
  background(60);
  mouse = MouseInfo.getPointerInfo().getLocation();
  /*
  for (int j = 0; j < height; j++) {
   for (int i = 0; i < width; i++) {
   set(i,j, robby.getPixelColor(i+mouse.x,j+mouse.y).getRGB());
   }
   }*/
  posmouse.act();
  if (rec) {
    if (frameCount%60 < 30) {
      noStroke();
      fill(255, 0, 0);
      ellipse(width/2, height/2, width*0.6, width*0.6);
    }
    if (click) {
      println("click");
      posmouse.add(new Punto(mouse.x, mouse.y, true));
    }
    else {
      posmouse.add(new Punto(mouse.x, mouse.y));
    }
  }
  if (play) {
    noStroke();
    fill(0, 255, 0);
    triangle(width/2-width*0.3, height/2-height*0.3, width/2-width*0.3, height/2+height*0.3, width/2+width*0.3, height/2);
    Punto pos =  posmouse.frame();
    robby.mouseMove(pos.x, pos.y);
    if (pos.click) {
      robby.mousePress(InputEvent.BUTTON1_MASK);
      robby.mouseRelease(InputEvent.BUTTON1_MASK);
    }
  }
}
void keyPressed() {
  if (key == 'r') {
    play = false;
    if (rec) {
      posmouse.stop();
    }
    else {
      posmouse = new Lector();
    }
    rec = !rec;
  }
  if (key == 'p') {
    if (rec) { 
      rec = false;
    }
    play = !play;
    if (play) {
      posmouse.play();
    }
    else {
      posmouse.pause();
    }
  }
}

class Punto {
  boolean click;
  int x, y;
  Punto(int x, int y) {
    this.x = x;
    this.y = y;
    click = false;
  }
  Punto(int x, int y, boolean click) {
    this.x = x;
    this.y = y;
    this.click = click;
  }
}

class Lector {
  ArrayList<Punto> puntos;
  boolean rep;
  int frame;
  Lector() {
    puntos = new ArrayList<Punto>();
    rep = false;
    frame = 0;
  }  
  void act() {
    if (rep) {
      frame++;
      frame %= puntos.size();
    }
  }
  void play() {
    rep = true;
  }
  void pause() {
    rep = false;
  }
  void stop() {
    rep = false;
    frame = 0;
  }
  void add(Punto p) {
    puntos.add(p);
  }
  Punto get(int i) {
    return puntos.get(i);
  }
  Punto frame() {
    return puntos.get(frame);
  }
}
