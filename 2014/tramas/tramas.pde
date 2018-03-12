PFont helve; //<>//
PGraphics texture1;
PImage mask1;

void setup() {
  size(600, 800);
  helve = createFont("Helvetica Bold", 120, true);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame("######");
  else generar2();
}
void generar2() {
  float lar = 14;
  PImage text1 = (tramaRect(width, height, lar, lar*0.0004, 1.0, 0.00)).get();
  image(text1, 0, 0);
  lar = 8;
  text1 = (tramaRect(width, height, lar, lar*0.15, 1.0, 0.00)).get();
  PGraphics mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(color(0));
  mask.textFont(helve);
  mask.fill(255);
  mask.textAlign(LEFT, TOP);
  mask.text("texturillas", 20, 20);
  mask.endDraw();
  text1.mask(mask.get());
  image(text1, 0, 0);
}
void generar() {
  background(250);
  int seed = int(random(9999999));
  float det = random(0.0001, 0.05);
  int cant = int(random(2, 8));
  
  for(int c = 0; c < cant; c++){ 
   float lar = random(4, 16);
   texture1 = tramaRect(width, height, lar, random(lar*0.1, lar*0.3), random(0.5, 1.5), random(TWO_PI));
   float cm = 1./cant;
   mask1 = createMask(width, height, seed, det, c*cm, (c+1)*cm);
   PImage text1 = texture1.get();
   text1.mask(mask1);
   image(text1, 0 , 0);
  /*
   for (int j = 0; j < height; j++) {
   for (int i = 0; i < width; i++) {
   if(brightness(mask1.get(i,j)) > 10){
   set(i,j,text1.get(i,j));
   }
   }
   } 
   */
  }

  float lar = random(14, 20);
  PImage text1 = (tramaRect(width, height, lar, random(lar*0.2, lar*0.4), random(0.5, 1.5), random(TWO_PI))).get();
  image(text1, 0, 0);
  lar = random(4, 10);
  text1 = (tramaRect(width, height, lar, random(lar*0.1, lar*0.15), random(0.5, 1.5), random(TWO_PI))).get();
  PGraphics mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(color(0));
  mask.textFont(helve);
  mask.fill(255);
  mask.textAlign(LEFT, TOP);
  mask.text("texturillas", 20, 20);
  mask.endDraw();
  text1.mask(mask.get());
  image(text1, 0, 0);
}

PGraphics tramaRect(int w, int h, float lar, float esp, float noise, float ang) {
  PGraphics pp = createGraphics(w, h); 
  pp.beginDraw();
  float x = w/2; 
  float y = h/2;
  float diag = int(dist(0, 0, w, h));
  float nd = diag/2;
  float nl = lar/2;
  pp.translate(x, y);
  pp.rotate(ang);
  pp.background(250);
  for (float j = -nd; j < nd; j += lar+esp) {
    for (float i = -nd; i < nd; i += esp) {
      float x1 = i  + random(-noise, noise);
      float y1 = j - nl + random(-noise, noise);
      float x2 = i + random(-noise, noise);
      float y2 = j + nl + random(-noise, noise);
      pp.line(x1, y1, x2, y2);
    }
  }
  pp.endDraw();
  return pp;
}

PImage createMask(int w, int h, int seed, float det, float min, float max) {
  PImage aux = createImage(w, h, RGB);
  noiseSeed(seed);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      float val = noise(i*det, j*det);
      if (val >= min && val < max) aux.set(i, j, color(255));
      else aux.set(i, j, color(0));
    }
  }
  aux.updatePixels();
  return aux;
}

