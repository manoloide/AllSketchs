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

public class Ignacio extends PApplet {

PImage imgs[];
int cant = 3;
int act = PApplet.parseInt(random(cant));
int alto, ancho;
PImage aux;
boolean lluvia = false;

public void setup() {
  size(720, 366);
  
  imgs = new PImage[cant];
  for (int i = 0; i < cant; i++) {
    imgs[i] = loadImage(i+".jpg");
  }
  alto = imgs[0].height;
  ancho = imgs[0].width;

  aux = createImage(ancho, alto, RGB);
}

public void draw() {
  aux.copy(imgs[act], 0, 0, ancho, alto, 0, 0, ancho, alto);
  if (PApplet.parseInt(frameCount/100)%2 == 1) {
    aux.filter(INVERT);
    println(frameCount);
  }
  image(aux, 0, 0); 
  procesar();
  if ( random(100) > 90) {
    act = PApplet.parseInt(random(cant));
  }
}

public void keyPressed() {
  if (key == 'r') {
    for (int i = 0; i < cant; i++) {
      imgs[i] = loadImage(i+".jpg");
    }
  }
  if(key == 'l'){
     lluvia = !lluvia; 
  }
}

public void procesar() {
  if (lluvia) {
    for (int i = -20; i < dist(mouseX,mouseY,pmouseX,pmouseY);i++) {
      pixeles();
    }
  }
  if ( random(100) > 80) {
    rectangulo();
  }
}

public void pixeles() {
  int x = PApplet.parseInt(random(ancho));
  int y = PApplet.parseInt(random(alto));
  int aux = calcular(imgs[act], x, y);
  int seg = PApplet.parseInt(random(cant));
  imgs[act].set(x, y, calcular(imgs[seg], x, y));
  imgs[seg].set(x, y, aux);
}

public void rectangulo() {
  int an = PApplet.parseInt(random(20, 80));
  int al = PApplet.parseInt(random(20, 80));
  int x = PApplet.parseInt(random(ancho-an));
  int y = PApplet.parseInt(random(alto-al));
  PImage aux = createImage(an, al, RGB);
  int seg = PApplet.parseInt(random(cant));
  for (int j = y; j < y+al;j++) {
    for (int i = x; i < x+an;i++) {
      aux.set(i-x, j-y, calcular(imgs[act], i, j));
      imgs[act].set(i, j, calcular(imgs[seg], i, j));
    }
  }
  for (int j = y; j < y+al;j++) {
    for (int i = x; i < x+an;i++) {
      imgs[seg].set(i, j, calcular(aux, i-x, j-y));
    }
  }
}

public int calcular(PImage img, int cx, int cy) {
  int col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ECE9D8", "Ignacio" });
  }
}
