int seed = int(random(999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  if (frameCount%120 == 0) generate();
  render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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

ArrayList<Rect> rects;

void generate() {
  seed = int(random(999999));
  subdivision();
}

void subdivision() {
  rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(100));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    boolean hor = r.w > r.h;
    if (hor) {
      float ww = r.w/3.0;
      rects.add(new Rect(r.x+ww*0, r.y, ww, r.h)); 
      rects.add(new Rect(r.x+ww*1, r.y, ww, r.h)); 
      rects.add(new Rect(r.x+ww*2, r.y, ww, r.h));
    } else {
      float hh = r.h/3.0;
      rects.add(new Rect(r.x, r.y+hh*0, r.w, hh)); 
      rects.add(new Rect(r.x, r.y+hh*1, r.w, hh)); 
      rects.add(new Rect(r.x, r.y+hh*2, r.w, hh));
    }
    rects.remove(ind);
  }
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

void lineGrid(float x1, float y1, float x2, float y2) {

  int res = max(1, int(max(abs(x1-x2), abs(y1-y2)*0.1)));
  float dx = (x2-x1)*1./res;
  float dy = (y2-y1)*1./res;
  PVector l1 = pointTrans(x1, y1, p1, p2, p3, p4);
  PVector l2;
  for (int i = 1; i <= res; i++) {
    l2 = pointTrans(x1+dx*i, y1+dy*i, p1, p2, p3, p4);
    line(l1.x, l1.y, l2.x, l2.y);
    l1 = l2.copy();
  }
}

float p1, p2, p3, p4;

void render() {
  background(10);

  randomSeed(seed);

  float time = millis()/1000.;

  p1 = randPow(5+cos(random(TWO_PI)+time*random(2))*4);
  p2 = randPow(5+cos(random(TWO_PI)+time*random(2))*4);
  p3 = randPow(5+cos(random(TWO_PI)+time*random(2))*4);
  p4 = randPow(5+cos(random(TWO_PI)+time*random(2))*4);

  noStroke();
  stroke(255);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    int sub = int(random(1, min(r.w, r.w)*0.1));
    float dw = r.w/sub;
    float dh = r.h/sub;
    float v1 = (time*random(-1, 1)*random(10))%sub;
    float v2 = (time*random(-1, 1)*random(10))%sub;
    float xx, yy;
    for (int j = 0; j < sub; j++) {
      xx = r.x+dw*((j+v1+sub)%sub);
      yy = r.y+dh*((j+v2+sub)%sub);
      lineGrid(xx, r.y, xx, r.y+r.h);
      lineGrid(r.x, yy, r.x+r.w, yy);
    }
  }
}