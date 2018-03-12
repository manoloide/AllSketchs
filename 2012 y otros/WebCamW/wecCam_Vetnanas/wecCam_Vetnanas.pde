import processing.video.*;

Capture video;
PImage captura;
boolean espejar = true;  

ArrayList ventanas;

int umbral = 60;

void setup() {
  size(640, 480);
  frameRate(30);
  noStroke();
  //video
  video = new Capture(this, width, height);
  captura = createImage(video.width, video.height, RGB); 
  video.start();
  //ventanas
  ventanas = new ArrayList();
}

void draw() {
  if (video.available()) {
    video.read();
    if (espejar) {
      captura = invertirImagen(video);
    }
    else {
      captura = video;
    }
  }
  image(captura, 0, 0);
  //actaulizar vetnanas;
  for (int i = 0; i < ventanas.size();i++) {
    Ventana aux = (Ventana) ventanas.get(i);
    aux.act(captura);
  }
}

void stop() {
  video.stop();
  super.stop();
}

PImage invertirImagen (PImage original) {
  PImage invertida = createImage(original.width, original.height, RGB);
  original.loadPixels();
  invertida.loadPixels();
  for (int x=0; x<original.width; x++) {
    for (int y=0; y<original.height; y++) {
      int loc = (original.width - x - 1) + y * original.width;
      color c = original.pixels[loc];
      invertida.pixels[x + y * original.width] = c;
    }
  }
  return invertida;
}

int cx, cy;

void mousePressed() {
  cx = mouseX;
  cy = mouseY;
}

void mouseReleased() {
  if (dist(mouseX, mouseY, cx, cy)>10) {
    ventanas.add(new Ventana(cx, cy, mouseX-cx, mouseY-cy));
  }else{
    saveFrame(); 
  }
}
