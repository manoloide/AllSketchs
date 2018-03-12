import oscP5.*;
import processing.video.*;

ArrayList<Punto> puntos;
ArrayList<Estrella> estrellas;
Capture video;
OscP5 oscP5;

void setup() {
  size(displayWidth, displayHeight, P3D);
  frameRate(30);
  colorMode(HSB, 256);
  noCursor();
  puntos = new ArrayList<Punto>();
  estrellas = new ArrayList<Estrella>();
  video = new Capture(this, 320, 240);
  video.start();
  oscP5 = new OscP5(this, 12001);
}

void draw() {
  if (video.available()) {
    video.read();
  }
  pushMatrix();
  background((frameCount%512)*0.5, 40, 255);
  translate(width/2, height/2, -800);
  rotateX(((frameCount%567)/567.) * TWO_PI);
  rotateY(((frameCount%467)/467.) * TWO_PI);
  rotateZ(((frameCount%667)/667.) * TWO_PI);
  /*
  if (frameCount%3 == 0 && puntos.size() > 0) {
   Punto aux = puntos.get(puntos.size()-1); 
   estrellas.add(new Estrella(aux.x,aux.y,aux.z,aux.tam));
   }*/
  for (int i = 0; i < puntos.size(); i++) {
    Punto aux = puntos.get(i); 
    if (aux.eliminar) {
      for (int j = 0; j < 8; j++) {
        estrellas.add(new Estrella(aux.x, aux.y, aux.z, aux.tam*random(8, 100)));
      }
      puntos.remove(i--);
      continue;
    }
    noStroke();
    aux.act();
    stroke(255); 
    for (int j = i+1; j < puntos.size(); j++) {
      Punto aux2 = puntos.get(j);
      float dis = dist(aux, aux2);
      if (dis < (aux.tam+aux2.tam)*20) {
        float tam = dis/200;
        tam = (tam > min(aux.tam, aux2.tam))? min(aux.tam, aux2.tam) : tam;
        strokeWeight(tam);
        line(aux.x, aux.y, aux.z, aux2.x, aux2.y, aux2.z);
      }
    }
  }
  for (int i = 0; i < estrellas.size(); i++) {
    Estrella aux = estrellas.get(i); 
    if (aux.eliminar) {
      estrellas.remove(i--);
      continue;
    }
    stroke(255);
    strokeWeight(aux.tam/10);
    aux.act();
  }
  popMatrix();
  image(video, width-360, height-280);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/1")==true) {
    int val = theOscMessage.get(0).intValue();
    if (val > 0) {
      puntos.add(new Punto(val*2));
    }
  }
  if (theOscMessage.checkAddrPattern("/2")==true) { 
    int firstValue = theOscMessage.get(0).intValue();
  }
}

class Punto {
  boolean eliminar;
  float x, y, z, tam;
  Punto(float tam) {
    eliminar = false;
    x = random(-width, width);
    y = random(-height, height);
    z = random(-width, width);
    this.tam = tam;
  }
  void act() {
    tam -= 1; 
    if (tam <= 1) {
      eliminar = true;
    }
    dibujar();
  }
  void dibujar() {
    pushMatrix();
    translate(x, y, z);
    sphere(tam);
    popMatrix();
  }
}

class Estrella {
  boolean eliminar;
  float x, y, z, tam, ang, ang2;
  Estrella(float x, float y, float z, float tam) {
    eliminar = false;
    this.x = x;
    this.y = y;
    this.z = z;
    this.tam = tam/2;
    ang = random(TWO_PI);
    ang2 = random(TWO_PI);
  }
  void act() {
    tam -= 0.2; 
    float vel = tam/5;
    ang += random(-0.1, 0.1);
    ang2 += random(-0.1, 0.1);
    x += cos(ang) *vel;
    y += sin((ang+ang2)/2) *vel;
    z += cos(ang2) *vel;
    if (tam <= 0) {
      eliminar = true;
    }
    dibujar();
  }
  void dibujar() {
    line(x-tam, y, z, x+tam, y, z);
    line(x, y-tam, z, x, y+tam, z);
    line(x, y, z-tam, x, y, z+tam);
  }
}

float dist(Punto p1, Punto p2) {
  return dist(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
}

