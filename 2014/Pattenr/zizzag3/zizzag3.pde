boolean alfa;
int w, h, cant;
float angulos[];
float x[];
float y[];
PImage mosaico;

void setup() {
  size(800, 400); 
  nuevo();
}
void draw() {
  for (int i = 0; i < cant; i++) {
    //angulos[i] += random(0.01);
    //x[i] += random(-0.1, 0.1);
    //y[i] += random(-0.1, 0.1);
  }
  mosaico = crearMosaico(w, h);
  colorMode(HSB);
  background((frameCount/20.)%256, saturation(#F2E225), brightness(#F2E225));
  colorMode(RGB); 
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
  alfa = (random(1) < 0.5)? true : false;
  w = int(random(12, 100)); 
  h = int(random(12, 100));
  cant = int(random(1, (w+h)/10));
  angulos = new float[cant];
  x = new float[cant];
  y = new float[cant];
  for (int i = 0; i < cant; i++) {
    angulos[i] = random(TWO_PI);
    x[i] = random(w);
    y[i] = random(h);
  }
}

PImage crearMosaico(int w, int h) {
  PGraphics mosaico = createGraphics(w, h);
  mosaico.beginDraw();
  mosaico.strokeWeight(3);
  float dis = w + h;
  float v1, v2, v3;
  int per = 80;
  int tra = 60;
  int t = frameCount%(per*3);
  v1 = v2 = v3 = 0;
  if (t < per) v1 = 1;
  else if (t >= per && t < per*2) v2 = 1;
  else if (t >= per*2) v3 = 1;
  if (t >= per-tra/2 && t < per+tra/2) {
    v1 = (t-per-tra/2.)/-tra;
    v2 = 1-(t-per-tra/2.)/-tra;
  } 
  else if (t >= per*2-tra/2 && t < per*2+tra/2) {
    v2 = (t-per*2-tra/2.)/-tra;
    v3 = 1-(t-per*2-tra/2.)/-tra;
  }
  else if (t >= per*3-tra/2) {
    v3 = (t-per*3-tra/2.)/-tra;
    v1 = 1-(t-per*3-tra/2.)/-tra;
  }
  if (t < tra/2) {
    v3 = 1-(t*1.)/tra*2;
    v1 = (t*1.)/tra*2;
  } 
  for (int i = 0; i < cant; i++) {
    float ang = angulos[i];//random(TWO_PI);
    float xx = x[i];
    float yy = y[i];
    float dx = sin(ang)*dis*v1+tan(ang)*dis*v2+cos(ang)*dis*v3;
    float dy = tan(ang)*dis*v1+sin(ang)*dis*v2+cos(ang)*dis*v3;
    if (alfa) {
      mosaico.stroke(250, 200);
      mosaico.line(xx-dx+2, yy-dy+2, xx+dx+2, yy+dy+2);

      mosaico.stroke(10, 200);
      mosaico.line(xx-dx, yy-dy, xx+dx, yy+dy);
    }
    else {
      mosaico.stroke(10); 
      mosaico.line(xx-dx, yy-dy, xx+dx, yy+dy);
    }
    if (random(100) < 1) {
      //mosaico.ellipse(random(width), random(height), 10, 10);
    }
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
