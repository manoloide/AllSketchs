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

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = 0;//int(random(4));
  for (int k = 0; k < sub; k++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind); 
    int cw = int(random(2, 4));
    int ch = 2;
    float sw = r.w/cw;
    float sh = r.h/ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        rects.add(new Rect(r.x+sw*i, r.y+sh*j, sw, sh));
        rects.add(new Rect(r.x+sw*(i+1), r.y+sh*j, sw, sh));
        rects.add(new Rect(r.x+sw*(i+1), r.y+sh*(j+1), sw, sh));
        rects.add(new Rect(r.x+sw*i, r.y+sh*(j+1), sw, sh));
      }
    }
    rects.remove(ind);
  }

  background(rcol());//);

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    room(r.x, r.y, r.w, r.h);
  }
}

void room(float x, float y, float w, float h) {
  int cw = int(random(8, 30));
  int ch = int(random(16, 50));
  float ww = w*1./cw;
  float hh = w*1./ch;

  float px[] = new float[cw+1];
  for (int i = 0; i <= cw; i++) {
    if (i == 0) px[i] = 0;
    else if (i == cw) px[i] = 1;
    else px[i] = map(i+random(-0.4, 0.4), 0, cw, 0, 1);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      if ((i+j)%2 == 1) continue;
      rects.add(new Rect(i*ww, j*hh, ww, hh));
    }
  }

  java.util.Collections.shuffle(rects);

  int c1 = rcol();
  int c2 = rcol();
  int c3 = rcol();

  stroke(0, 10);
  for (int i = 0; i < rects.size(); i++) {
    if (random(1) < 0.2) {
      float xx = x+random(w);
      float yy = y+random(h);
      float ss = min(w, h)*random(0.3)*random(1);
      noStroke();
      arc2(xx, yy, ss, ss*2.2, 0, TAU, color(0), 20, 0);
      stroke(0, 10);
      fill(c2);//fill(#4886B6);
      //fill(rcol());
      ellipse(xx, yy, ss, ss);
      noStroke();
      arc2(xx+ss*0.2, yy-ss*0.2, 0, ss*0.4, 0, TAU, color(255), 10, 0);
      arc2(xx+ss*0.2, yy-ss*0.2, 0, ss*0.2, 0, TAU, color(255), 10, 0);
    }
    Rect r = rects.get(i);
    fill(c3);//#F35076);
    rect(x+r.x, y+r.y, r.w, r.h);
    beginShape();
    fill(0, 0, 0, 0);
    vertex(x+r.x, y+r.y);
    vertex(x+r.x+r.w, y+r.y);
    fill(0, 0, 0, 30);
    vertex(x+r.x+r.w, y+r.y+r.h);
    vertex(x+r.x, y+r.y+r.h);
    endShape(CLOSE);
    //srect(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h, min(r.w, r.h)*0.2, color(0), 80, 0);
  }
}

void srect(float x, float y, float w, float h, float s, int col, float alp1, float alp2) {

  beginShape();
  fill(col, alp1);
  vertex(x-w*0.5, y-h*0.5);
  vertex(x-w*0.5, y+h*0.5);
  fill(col, alp2);
  vertex(x-w*0.5-s, y+h*0.5+s);
  vertex(x-w*0.5-s, y-h*0.5-s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(x-w*0.5, y+h*0.5);
  vertex(x+w*0.5, y+h*0.5);
  fill(col, alp2);
  vertex(x+w*0.5+s, y+h*0.5+s);
  vertex(x-w*0.5-s, y+h*0.5+s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(x+w*0.5, y+h*0.5);
  vertex(x+w*0.5, y-h*0.5);
  fill(col, alp2);
  vertex(x+w*0.5+s, y-h*0.5-s);
  vertex(x+w*0.5+s, y+h*0.5+s);
  endShape(CLOSE);

  beginShape();
  fill(col, alp1);
  vertex(x+w*0.5, y-h*0.5);
  vertex(x-w*0.5, y-h*0.5);
  fill(col, alp2);
  vertex(x-w*0.5-s, y-h*0.5-s);
  vertex(x+w*0.5+s, y-h*0.5-s);
  endShape(CLOSE);
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
int colors[] = {#F7F7F7, #3102F7, #000000};
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
