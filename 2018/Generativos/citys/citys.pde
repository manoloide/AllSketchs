int seed = int(random(999999));
void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);

  randomSeed(seed);

  /*
  ambientLight(180, 180, 180);
   directionalLight(120, 120, 120, 0, 1, 0);
   directionalLight(110, 110, 120, -1, 0, 0);
   */

  float fov = PI/random(1.01, 1.8);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*1000.0);


  translate(width/2, height/2, random(300, 800));
  rotateX(random(-HALF_PI*0.4, HALF_PI*0.4));
  rotateY(random(-HALF_PI*0.4, HALF_PI*0.4));
  //rotateZ(random(TWO_PI));

  //ortho();

  float size = 2000;
  noFill();
  stroke(130);
  fill(80);

  //translate(0, 0, -200);
  box(size, size, 5);

  int sub = 8;
  float ss = size/sub;

  float dx = size*0.5-ss*0.5;
  float dy = size*0.5-ss*0.5;
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      pushMatrix();
      translate(i*ss-dx, j*ss-dy, 3);
      box(ss*0.95, ss*0.95, 1);

      manzana(ss*0.9);
      popMatrix();
    }
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void manzana(float s) {
  int pp = int(random(1, random(1, random(10, 50))));

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, s, s));

  int sub = int(random(1, 8));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float mw = random(0.3, 0.7);
    float mh = random(0.3, 0.7);
    float w = r.w*0.5;
    float h = r.h*0.5;
    float w1 = r.w*mw;
    float h1 = r.h*mh;
    float w2 = r.w*(1-mw);
    float h2 = r.h*(1-mh);
    rects.add(new Rect(r.x-w+w1*0.5, r.y-h+h1*0.5, w1, h1));
    rects.add(new Rect(r.x+w-w2*0.5, r.y-h+h1*0.5, w2, h1));
    rects.add(new Rect(r.x+w-w2*0.5, r.y+h-h2*0.5, w2, h2));
    rects.add(new Rect(r.x-w+w1*0.5, r.y+h-h2*0.5, w1, h2));

    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    pushMatrix();
    translate(r.x, r.y);
    edi(r.w, r.h, s*random(pp*0.1, pp*0.12), pp);
    popMatrix();
  }
}

void edi(float w, float h, float d, int pis) {
  float dd = d/pis;

  fill(0);
  for (int i = 0; i < pis; i++) {
    //fill(rcol());
    translate(0, 0, dd);
    box(w, h, dd*0.12);
  }
  //fill(rcol());

  translate(0, 0, -d*0.5);
  box(w*random(0.94, 1), h*random(0.94, 1), d);

  int cw = int(random(2, 10));
  float ww = w*1./cw;
  for (int i = 0; i < cw; i++) {
    pushMatrix();
    translate((i-cw*0.5+0.5)*ww, 0, 0);
    box(ww*0.1, h*0.99, d-4);
    popMatrix();
  }

  int ch = int(random(2, 10));
  float hh = h*1./ch;
  for (int i = 0; i < ch; i++) {
    pushMatrix();
    translate(0, (i-ch*0.5+0.5)*hh, 0);
    box(w*0.99, hh*0.1, d-4);
    popMatrix();
  }
  //box(w, h, d);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}