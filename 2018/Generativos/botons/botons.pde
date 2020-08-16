int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
  int sub = int(random(1000));
  for (int c = 0; c < sub; c++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int cw = int(random(1, 4));
    int ch = int(random(1, 4));
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
    float cx = r.x+r.w*0.5;
    float cy = r.y+r.h*0.5;
    noStroke();
    fill(rcol(back));
    rect(r.x, r.y, r.w, r.h);

    int rnd = int(random(10));

    if (rnd == 0) {
      fill(rcol(back));
      triangle(r.x, r.y, cx, cy, r.x+r.w, r.y);
      fill(rcol(back));
      triangle(r.x+r.w, r.y, cx, cy, r.x+r.w, r.y+r.h);
      fill(rcol(back));
      triangle(r.x+r.w, r.y+r.h, cx, cy, r.x, r.y+r.h);
      fill(rcol(back));
      triangle(r.x, r.y+r.h, cx, cy, r.x, r.y);
    }

    noStroke();
    srect(cx, cy, r.w, r.h, min(r.w, r.h)*0.08, color(0), 20, 0);
    srect(cx, cy, r.w, r.h, min(r.w, r.h)*random(0.6, 1.8), rcol(back), 10, 0);
    srect(cx, cy, r.w, r.h, min(r.w, r.h)*random(0.1, 0.8), rcol(back), 30, 0);


    if (random(1) < 0.8) {
      float ss = min(r.w, r.h)*random(0.6, 1)*random(0.8);

      int cols[] = cols1;
      if (random(1) < 0.5) cols = cols2;

      fill(getColor(cols));
      ellipse(cx, cy, ss, ss);
      fill(getColor(cols));
      ellipse(cx, cy, ss*0.05, ss*0.05);

      arc2(cx, cy, ss, ss*2, 0, TAU, getColor(cols), 60, 0);
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

int back[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int cols1[] = {#223593, #1B6B90, #17838D, #223593};
int cols2[] = {#DF603E, #BC3820, #810B0C};
int rcol(int[] colors) {
  return colors[int(random(colors.length))];
}
int getColor(int[] colors) {
  return getColor(colors, random(colors.length));
}
int getColor(int[] colors, float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)];

  return lerpColor(c1, c2, v%1);
}