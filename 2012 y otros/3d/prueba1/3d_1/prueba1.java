import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class prueba1 extends PApplet {

float ang = 0;
public void setup() {
  size(600, 600, P3D);
  noStroke();
  fill(255, 60, 58);
}

public void draw() {
  background(255);
  directionalLight (126, 126, 126, 0, 0, -1);
  ang+= 0.01f;
  rotateX(ang);
  rotateY(ang);
  cubo();
  
}

public void cubo() {
  for (int z = 0; z < 10; z++) {
    for (int y = 0; y < 10; y++) {
      for (int x = 0; x < 10; x++) {
        pushMatrix();
        translate(30 + x * 60, 30 + y * 60, 300 +z * -60);
        box(30, 30, 30);
        popMatrix();
      }
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ECE9D8", "prueba1" });
  }
}
