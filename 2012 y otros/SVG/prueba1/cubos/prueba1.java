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

ArrayList cubos;
PShape s;

float p1, p2;
public void setup() {
  size(600, 600);
  frameRate(30);
  smooth();
  noStroke();

  cubos = new ArrayList();
  for (int i = 0; i < 20; i++) {
    cubos.add(new Cubo(random(width), random(height)));
  }
  s = loadShape("c.svg");
  p1 = PApplet.parseInt(random(height));
  p2 = PApplet.parseInt(random(height));
}
public void draw() {
  p1 += random(41) - 20;
  p2 += random(41) - 20;
  pushMatrix();
  translate(random(2)-1, random(2)-1);
  shape(s, 0, 0, width, height);
  for (int i = 0; i < cubos.size(); i++) {
    Cubo aux = (Cubo) cubos.get(i);
    aux.act();
  }
  cuadricula();
  ruido();
  lineas(p1);
  lineas(p1);
  lineas(p1);
  lineas(p2);
  lineas(p2);
  lineas(p2);
  lineas(p2);
  popMatrix();
}
public void cuadricula() {
  noStroke();
  int vx = width/10;
  int vy = height/10;
  for (int j = 0; j < vy; j++) {
    for (int i = 0; i < vx; i++) {
      fill(random(256), random(30));
      rect(i*10, j*10, 10, 10);
    }
  }
}

public void ruido() {
  for (int i = 0; i < 1000; i++) {
    int x = PApplet.parseInt(random(width));
    int y = PApplet.parseInt(random(height));
    int c = color(random(256));
    set(x, y, c);
  }
}
public void lineas(float p) {
  if (random(6) > 5) {
    int c = color(50 + random(156));
    stroke(c);
    p += random(41) - 20;
    line(0, p, width, p);
  }
}

class Cubo {
  float x, y, ang;
  Cubo(float nx, float ny) {
    x = nx;
    y = ny;
  }
  public void act() {
    mover();
    draw();
  }
  public void mover() {
    if (dist(mouseX, mouseY, x, y) < 10) {
      float a = random(PI*2);
      float d = width * 2 / 3;
      x = width/2 + cos(a) * d ;
      y = height/2 + sin(a) * d;
    }
    ang = atan2(mouseY-y, mouseX-x);
    x += cos(ang);
    y += sin(ang);
  }
  public void draw() {
    stroke(0);
    fill(255,30);
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(ang);
    rect(0, 0, 20, 20);
    line(0, 0, 10, 0);
    popMatrix();
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ECE9D8", "prueba1" });
  }
}
