import java.awt.Rectangle;
import java.awt.AWTEvent;
import java.awt.event.AWTEventListener;
import java.awt.AWTException;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.InputEvent;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Robot;

boolean rec, play, click;
Robot robby;
PGraphics imagen;
PImage aux;
Point mouse, amouse;

void setup() {
  size(400, 300);
  try {
    robby = new Robot();
    //robby.setAutoDelay(int(1000/60.));
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
  imagen = createGraphics(displayWidth, displayHeight);
  imagen.beginDraw();
  imagen.background(255);
  imagen.endDraw();
  amouse = MouseInfo.getPointerInfo().getLocation();
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
  mouse = MouseInfo.getPointerInfo().getLocation();
  color c = robby.getPixelColor(mouse.x, mouse.y).getRGB();
  int cant = 40;
  int mit = cant/2;
  imagen.beginDraw();
  imagen.noStroke();
  aux = new PImage(robby.createScreenCapture(new Rectangle(mouse.x-mit,mouse.y-mit,cant,cant)));
  imagen.image(aux, mouse.x-mit, mouse.y-mit);
  /*
  imagen.fill(c);
  for (int j = -cant/2; j < cant/2; j++) {
    for (int i = -cant/2; i < cant/2; i++) {
      c = robby.getPixelColor(mouse.x+i, mouse.y+j).getRGB();
      imagen.set(mouse.x+i, mouse.y+j, c);
    }
  }
  */
  imagen.endDraw(); 
  image(imagen, 0, 0);
  amouse = mouse;
  /*
  for (int j = 0; j < height; j++) {
   for (int i = 0; i < width; i++) {
   set(i,j, robby.getPixelColor(i+mouse.x,j+mouse.y).getRGB());
   }
   }*/
}

void dispose() {
  imagen.save("prueba 2");
}
