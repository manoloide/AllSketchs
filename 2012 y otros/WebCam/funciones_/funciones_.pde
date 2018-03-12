PImage img;
ArrayList puntos;

final int dis = 5;
final int dis2 = 30;
final int rango = 5;
//para la camara
import codeanticode.gsvideo.*;
GSCapture cam;

void setup() {
  size(640, 480);
  frameRate(30);
  background(0);

  //arrancar camara
  cam = new GSCapture(this, 640, 480);
  cam.start(); 

  puntos = new ArrayList();

  //println(width*height);
  //exit();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //image(cam, 0, 0);
    img = cam;
  }

  coloresMedio();
  /*
  float x, y;
   color col;
   puntos = new ArrayList();
   for (int v = 0; v < 500;v++) {
   x = random(width);
   y = random(height-1);
   col = calcular(img,x, y);
   
   Punto aux1 = new Punto(x, y, col);
   puntos.add(aux1);
   
   for (int i = 0; i < puntos.size()-1;i++) {
   Punto aux2 = (Punto) puntos.get(i);
   if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<=dis2) {
   stroke(aux2.col);
   line(aux1.x, aux1.y, aux2.x, aux2.y);
   }
   }
   }
   */
}

//te devulve el color de una imagen es un puntos.
color calcular(PImage img, float cx, float cy) {
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col), green(col), blue(col), 100);
  return col;
}

class Punto {
  float x, y;
  color col;

  Punto(float nx, float ny, color nc) {
    x = nx;
    y = ny;
    col = nc;
  }
}

void byn(float cx, float cy) {
  stroke(calcular(img, cx, cy));
  point(cx, cy);
}

//dibujar pantallla
void dibujar() {
  for (int y = 0; y < img.height;y++) {
    for (int x = 0; x < img.width;x++) {
      set(x, y, calcular(img, x, y));
    }
  }
}

void byn2() {
  for (int y = 0; y < img.height;y++) {
    for (int x = 0; x < img.width;x++) {
      color prob = calcular(img, x, y);
      prob = color((red(prob)+green(prob)+blue(prob))/3);
      set(x, y, prob);
    }
  }
}

void coloresMedio() {
  for (int y = 0; y < img.height;y++) {
    for (int x = 0; x < img.width;x++) {
      color prob = calcular(img, x, y);
      float valor = (red(prob)+green(prob)+blue(prob))/3;
      if ( valor > 99 && valor < 200) {
      }
      else {
        prob = color(valor);
      }
      set(x, y, prob);
    }
  }
}  

