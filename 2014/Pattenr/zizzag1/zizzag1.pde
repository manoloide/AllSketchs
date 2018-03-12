int w, h, cant;
PImage mosaico;

void setup() {
  size(800, 400); 
  w = 50; 
  h = 50;
  cant = 20;
  nuevo();
}
void draw() {
  background(#F2E225);
  int dx = (frameCount/2)%(w*2)-w*2;
  int dy = (frameCount/2)%(h*2)-h*2;
  for (int j = dy; j < height; j+=h) {
    for (int i = dx; i < width; i+=w) {
      if ((i-dx)%(w*2) == 0 && (j-dy)%(h*2) == 0) image(mosaico, i, j);
      if ((i-dx)%(w*2) == 0 && (j-dy)%(h*2) != 0) image(invertir(mosaico), i, j);
      if ((i-dx)%(w*2) != 0 && (j-dy)%(h*2) == 0) image(espejar(mosaico), i, j);
      if ((i-dx)%(w*2) != 0 && (j-dy)%(h*2) != 0) image(invertir(espejar(mosaico)), i, j);
    }
  }
}

void keyPressed() {
  if (key == 's') saveFrame("#####.png");
  else nuevo();
}

void nuevo() {
  mosaico = crearMosaico(w, h);
}

PImage crearMosaico(int w, int h) {
  PGraphics mosaico = createGraphics(w, h);
  mosaico.beginDraw();
  mosaico.strokeWeight(3);
  float dis = w + h;
  for (int i = 0; i < cant; i++) {
    float ang = random(TWO_PI);
    float xx = random(w);
    float yy = random(h);
    mosaico.stroke(10); 
    mosaico.line(xx-cos(ang)*dis, yy-cos(ang)*dis, xx+cos(ang)*dis, yy+cos(ang)*dis);
  }
  mosaico.endDraw();
  PImage aux = createImage(w, h, ARGB);
  aux.loadPixels();
  for (int i = 0; i < mosaico.pixels.length; i++) {
    aux.pixels[i] = mosaico.pixels[i];
  }
  aux.updatePixels();
  return aux;
}

PImage invertir(PImage ori) {
  int w = ori.width;
  int h = ori.height;
  PImage aux = createImage(w, h, ARGB);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      aux.set(i, h-j-1, ori.get(i, j));
    }
  }
  aux.updatePixels();
  return aux;
}

PImage espejar(PImage ori) {
  int w = ori.width;
  int h = ori.height;
  PImage aux = createImage(w, h, ARGB);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      aux.set(w-i-1, j, ori.get(i, j));
    }
  }
  aux.updatePixels();
  return aux;
}
