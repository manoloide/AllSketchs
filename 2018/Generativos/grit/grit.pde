int seed = int(random(999999));
void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();


  saveImage();
  exit();
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

class Rect {
  float x, y, w, h; 
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
}

void generate() {
  background(0);
  randomSeed(seed);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = int(random(10000));
  for (int c = 0; c < sub; c++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int cw = int(random(1, 4));
    int ch = int(random(1, 4));
    float ww = r.w/cw;
    float hh = r.h/ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        rects.add(new Rect(r.x+ww*i, r.y+hh*j, ww, hh));
      }
    }
    rects.remove(ind);
  }

  noStroke();
  rectMode(CENTER);

  float det = random(0.02);
  float des = random(1000);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float xx = r.x+r.w*0.5;
    float yy = r.y+r.h*0.5;
    float ss = noise(des+xx*det, des+yy*det)*min(r.w, r.h);
    fill(getColor());
    rect(xx, yy, r.w, r.h);

    if (random(1) < 0.5) {
      beginShape();
      fill(getColor(), random(140));
      vertex(r.x, r.y);
      vertex(r.x+r.w, r.y);
      fill(getColor(), random(140));
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x, r.y+r.h);
      endShape(CLOSE);
    } else {
      beginShape();
      fill(getColor(), random(140));
      vertex(r.x+r.w, r.y);
      vertex(r.x+r.w, r.y+r.h);
      fill(getColor(), random(140));
      vertex(r.x, r.y+r.h);
      vertex(r.x, r.y);
      endShape(CLOSE);
    }


    fill(getColor());
    ellipse(xx, yy, ss, ss);
    arc2(xx, yy, ss, ss*1.8, 0, TAU, getColor(), 30, 0);
    arc2(xx, yy, ss, ss*1.1, 0, TAU, color(0), 20, 0);
    arc2(xx, yy, ss, ss*0.4, 0, TAU, getColor(), 30, 0);


    srect(xx, yy, r.w, r.h, -min(r.w, r.h)*0.25, getColor(), 20, 0);
    srect(xx, yy, r.w, r.h, -min(r.w, r.h)*0.1, getColor(), 20, 0);
  }

  /*
  det = random(0.02);
   des = random(1000);
   float pwr = random(1, 20);
   float min = random(5)*random(1);
   float max = random(6);
   if (random(1) < 0.5) pwr = 1/pwr;
   rectMode(CENTER);
   for (int i = 0; i < 1000; i++) {
   float x = random(width);
   float y = random(height);
   float s = map(pow(noise(des+x*det, des+y*det), pwr), 0, 1, min, max);
   pushMatrix();
   translate(x, y);
   
   noStroke();
   arc2(0, 0, s, s*4, 0, TAU, getColor(), 60, 0);
   fill(getColor());
   
   int cc = int(random(1, 6));
   float da = TAU/cc;
   float ang = random(TAU);
   rotate(ang);
   for (int j = 0; j < cc; j++) {
   rotate(da);
   rect(0, 0, s*3, s*0.1);
   }
   ellipse(0, 0, s, s);
   fill(getColor());
   ellipse(0, 0, s*0.1, s*0.1);
   popMatrix();
   }
   */
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void srect(float x, float y, float w, float h, float s, int col, float alp1, float alp2) {
  float mw = w*0.5;
  float mh = h*0.5;
  float sw = mw+s;
  float sh = mh+s;
  beginShape();
  fill(col, alp2);
  vertex(x-sw, y-sh);
  vertex(x+sw, y-sh);
  fill(col, alp1);
  vertex(x+mw, y-mh);
  vertex(x-mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y-sh);
  vertex(x+sw, y+sh);
  fill(col, alp1);
  vertex(x+mw, y+mh);
  vertex(x+mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y+sh);
  vertex(x-sw, y+sh);
  fill(col, alp1);
  vertex(x-mw, y+mh);
  vertex(x+mw, y+mh);
  endShape();

  beginShape();
  fill(col, alp2);
  vertex(x-sw, y+sh);
  vertex(x-sw, y-sh);
  fill(col, alp1);
  vertex(x-mw, y-mh);
  vertex(x-mw, y+mh);
  endShape();
}

int colors[] = {#4A3088, #03786C, #06A397, #00A459, #E72428, #F06DA3, #FDF9CB, #FCCD21, #F89C1A, #F35E22};
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