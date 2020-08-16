int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  newPallet();
  background(rcol());

  float p1 = randPow(random(4));
  float p2 = randPow(random(4));
  float p3 = randPow(random(4));
  float p4 = randPow(random(4));

  PVector p;
  for (int i = 0; i < 200; i++) {
    float xx = random(width);
    float yy = random(height);
    float ww = width*random(0.3, 0.5);
    float hh = ww*random(0.1, 0.25);
    float ang = random(TWO_PI);
    PVector cen = new PVector(xx, yy);

    int sub = int(random(5, 200));
    float ss = ww/sub;

    noStroke();
    /*
    beginShape();
     fill(getColor(random(colors.length)));
     p = new PVector(xx-ww*0.5, yy-hh*0.5);
     p = rotateCenter(p, cen, ang);
     p = pointTrans(p.x, p.y, p1, p2, p3, p4);
     vertex(p.x, p.y);
     fill(getColor(random(colors.length)));
     p = new PVector(xx+ww*0.5, yy-hh*0.5);
     p = rotateCenter(p, cen, ang);
     p = pointTrans(p.x, p.y, p1, p2, p3, p4);
     vertex(p.x, p.y);
     fill(getColor(random(colors.length)));
     p = new PVector(xx+ww*0.5, yy+hh*0.5);
     p = rotateCenter(p, cen, ang);
     p = pointTrans(p.x, p.y, p1, p2, p3, p4);
     vertex(p.x, p.y);
     fill(getColor(random(colors.length)));
     p = new PVector(xx-ww*0.5, yy+hh*0.5);
     p = rotateCenter(p, cen, ang);
     p = pointTrans(p.x, p.y, p1, p2, p3, p4);
     vertex(p.x, p.y);
     endShape(CLOSE);
     */
    float det = random(0.01);
    for (int j = 0; j < sub; j++) {
      beginShape();
      p = new PVector(xx-ww*0.5+ss*(j+1), yy-hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1, p2, p3, p4);
      fill(noiseColor(p.x, p.y, det));
      vertex(p.x, p.y);
      p = new PVector(xx-ww*0.5+ss*(j+0), yy-hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1, p2, p3, p4);
      fill(noiseColor(p.x, p.y, det));
      vertex(p.x, p.y);
      p = new PVector(xx-ww*0.5+ss*(j+0), yy+hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1, p2, p3, p4);
      fill(noiseColor(p.x, p.y, det));
      vertex(p.x, p.y);
      p = new PVector(xx-ww*0.5+ss*(j+1), yy+hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1, p2, p3, p4);
      fill(noiseColor(p.x, p.y, det));
      vertex(p.x, p.y);
      endShape(CLOSE);
    }

    float dd = random(-0.01, 0.01);
    float dc1 = random(1);
    float dc2 = random(1);
    for (int j = 0; j < sub; j++) {
      float c1 = 140+j*dc1;
      float c2 = 0;
      if (j%2== 0) {
        c1 = 0;
        c2 = 220-j*dc2;
      }
      beginShape();
      fill(0, c1);
      p = new PVector(xx-ww*0.5+ss*(j+1), yy-hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1+dd, p2+dd, p3+dd, p4+dd);
      vertex(p.x, p.y);
      p = new PVector(xx-ww*0.5+ss*(j+0), yy-hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1+dd, p2+dd, p3+dd, p4+dd);
      vertex(p.x, p.y);
      fill(0, c2);
      p = new PVector(xx-ww*0.5+ss*(j+0), yy+hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1+dd, p2+dd, p3+dd, p4+dd);
      vertex(p.x, p.y);
      p = new PVector(xx-ww*0.5+ss*(j+1), yy+hh*0.5);
      p = rotateCenter(p, cen, ang);
      p = pointTrans(p.x, p.y, p1+dd, p2+dd, p3+dd, p4+dd);
      vertex(p.x, p.y);
      endShape(CLOSE);
    }
  }
}

PVector rotateCenter(PVector ori, PVector cen, float angle) {
  float x = cos(angle)*(ori.x-cen.x)-sin(angle)*(ori.y-cen.y)+cen.x;
  float y = sin(angle)*(ori.x-cen.x)+cos(angle)*(ori.y-cen.y)+cen.y;

  return new PVector(x, y);
}

void newPallet() {
  int[] aux = new int[colors.length]; 
  colorMode(HSB, 360, 100, 100);
  float mod = random(360);
  for (int i = 0; i < colors.length; i++) {
    aux[i] = color((hue(colors[i])+mod)%360, saturation(colors[i]), brightness(colors[i]));
  }
  colorMode(RGB, 256, 256, 256);
  colors = aux;
}

int noiseColor(float x, float y, float d) {
  return getColor(noise(x*d+304, y*d+7.13)*colors.length*2);
}

float randPow(float val) {
  if (random(1) < 0.5) {
    return random(1, val);
  }
  return 1./random(1, val);
}

PVector pointTrans(float x, float y, float p1, float p2, float p3, float p4) {
  x /= width; 
  y /= height;

  float sx = (x > 0)? 1 : -1;
  float sy = (y > 0)? 1 : -1;

  x = abs(x);
  y = abs(y);

  float xx = lerp(pow(x, p1), pow(x, p2), y)*width;
  float yy = lerp(pow(y, p3), pow(y, p4), x)*height;

  return new PVector(xx*sx, yy*sy);
}

int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
//int colors[] = {#0F0A2C, #2034A0, #5D1259, #CD172D, #F5AD00, #F8E988, #F7F1F5}; 
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}