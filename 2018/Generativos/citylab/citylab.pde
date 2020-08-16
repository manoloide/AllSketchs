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

  grid2();

  balls(4000);

  grid1();

  vivoritas();


  balls(300);
}

void vivoritas(){
  int cc = int(random(10, 90));
  stroke(0, 30);
  for(int c = 0; c < cc; c++){
    float x = random(-100, width);
    float y = random(- 100, height);

    float det = random(0.1);
    float des = random(10000);

    float vx = random(8);
    float vy = random(8);

    float hh = random(9);
    float ss = random(4);

    rectMode(CENTER);
    for(int i = 0; i < 100; i++){
      x += vx;
      float ang = x*vy;
      y += cos(ang)*hh;
      fill(rcol());
      pushMatrix();
      translate(x, y);
      rotate(ang);
      rect(0, 0, ss, ss);
      popMatrix();
    }
    rectMode(CORNER);
  }
}

void balls(int c) {
  stroke(0);
  float det = random(0.01);
  float des = random(100000);
  float min = random(-0.5, 0.5)*random(1);
  float max = random(0.6, 10);
  float ss = random(1, 8);
  int cc = int(random(c*0.2, c));
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float s = map(noise(x*det+des, y*det+des), 0, 1, min, max)*ss;
    //stroke(0);
    fill(rcol());
    ellipse(x, y, s, s);
    noStroke();
    //arc2(x, y, s, s*20, 0, TAU, rcol(), random(10), 0);
  }
}

void grid1() {
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = int(random(1000));
  for (int c = 0; c < sub; c++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int cw = int(random(1, 6));
    int ch = int(random(1, 6));
    float ww = r.w*1./cw;
    float hh = r.x*1./ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        rects.add(new Rect(r.x+i*ww, r.y+j*hh, ww, hh));
      }
    }
    rects.remove(ind);
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);

    int rnd = int(random(10));

    if(rnd == 0){
      float cx = r.x+r.w*0.5;
      float cy = r.y+r.h*0.5;
      fill(rcol());
      triangle(r.x, r.y, cx, cy, r.x+r.w, r.y);
      fill(rcol());
      triangle(r.x+r.w, r.y, cx, cy, r.x+r.w, r.y+r.h);
      fill(rcol());
      triangle(r.x+r.w, r.y+r.h, cx, cy, r.x, r.y+r.h);
      fill(rcol());
      triangle(r.x, r.y+r.h, cx, cy, r.x, r.y);

    }

    noStroke();
    srect(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h, min(r.w, r.h)*random(0.6, 1.8), rcol(), 10, 0);
    srect(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h, min(r.w, r.h)*random(0.1, 0.8), rcol(), 30, 0);
    srect(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h, min(r.w, r.h)*0.05, 0, 50, 0);
  }
}

void grid2() {
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = int(random(1000));
  for (int c = 0; c < sub; c++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int cw = int(random(1, 6));
    int ch = int(random(1, 6));
    float ww = r.w*1./cw;
    float hh = r.h*1./ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        rects.add(new Rect(r.x+i*ww, r.y+j*hh, ww, hh));
      }
    }
    rects.remove(ind);
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
  }
}

void circulo(float x, float y, float s) {
  int cs = int(random(0, 50));
  float amp = random(1);
  float ia = random(TWO_PI);
  int sub = int(random(10));
  int div = int(random(30));
  for (int j = 0; j < div; j++) {
    float ang = ia+map(j, 0, div, 0, TAU);
    for (int i = 0; i < sub; i++) {
      float dis = map(i, 0, sub, 0.1, +cos(ang*cs)*(0.2+amp))*s;
      float ss = random(4)*random(1);
      float a2 = random(60)*random(1);
      float xx = x+cos(ang)*dis;
      float yy = y+sin(ang)*dis;
      noStroke();
      arc2(xx, yy, ss*a2, ss*a2*1.8, 0, TAU, rcol(), 80, 0);
      stroke(0);
      fill(rcol(), random(250));
      ellipse(xx, yy, ss, ss);
      ellipse(xx, yy, ss*a2, ss*a2);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma*0.3));
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

int colors[] = {#050505, #FFFFFF, #1180FF, #43B16A, #FF5403, #FFDD07};
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
