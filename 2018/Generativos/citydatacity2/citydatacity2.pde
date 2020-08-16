int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
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

  randomSeed(seed);

  background(0);

  ArrayList<Rect> rects = new  ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = int(random(20)*random(0.1, 1));
  float max = 20;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float mw = int(r.w*random(0.3, 0.7));
    float mh = int(r.h*random(0.3, 0.7));
    if (mw < max || mh < max || r.w-mw < max || r.h-mh < max) continue;
    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));
    rects.remove(ind);
  }


  ArrayList<Rect> rects2 = new ArrayList<Rect>();
  float p1 = random(1)*random(1)*0.2;
  float p2 = random(1)*random(1)*0.2;
  float p3 = random(1)*random(1)*0.2;
  float p4 = random(1)*random(1)*0.2;
  for (int j = 0; j < rects.size(); j++) {
    Rect r = rects.get(j);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h);
    rects2.clear();
    rects2.add(new Rect(r.x, r.y, r.w, r.h));
    float max2 = 4;
    int sub2 = int(random(400)*random(1));
    for (int i = 0; i < sub2; i++) {
      int ind = int(random(rects2.size())*random(1));
      Rect r2 = rects2.get(ind);
      float mw = int(r2.w*random(0.3, 0.7));
      float mh = int(r2.h*random(0.3, 0.7));
      if (mw < max2 || mh < max2 || r2.w-mw < max2 || r2.h-mh < max2) continue;
      if (random(1) > p1) rects2.add(new Rect(r2.x, r2.y, mw, mh));
      if (random(1) > p2) rects2.add(new Rect(r2.x+mw, r2.y, r2.w-mw, mh));
      if (random(1) > p3) rects2.add(new Rect(r2.x+mw, r2.y+mh, r2.w-mw, r2.h-mh));
      if (random(1) > p4) rects2.add(new Rect(r2.x, r2.y+mh, mw, r2.h-mh));
      if (rects2.size() > 1) rects2.remove(ind);
    }

    noStroke();
    for (int i = 0; i < rects2.size(); i++) {
      Rect r2 = rects2.get(i);
      float xx = r2.x+1;
      float yy = r2.y+1;
      float ww = r2.w-2;
      float hh = r2.h-2;
      rect2(xx, yy, ww, hh, rcol(), rcol());
      
      fill(rcol());
      float ss = 1;
      rect(xx,       yy,       ss, ss);
      rect(xx+ww-ss, yy,       ss, ss);
      rect(xx+ww-ss, yy+hh-ss, ss, ss);
      rect(xx,       yy+hh-ss, ss, ss);
      
    }
  }

  /*
  noFill();
   noStroke();
   Rect r;
   for (int i = 0; i < rects.size(); i++) {
   r = rects.get(i);
   fill(rcol());
   rect(r.x, r.y, r.w, r.h);
   }
   */
}

void rect2(float x, float y, float w, float h, int c1, int c2) {
  boolean hor = random(1) < 0.5;
  float alp = random(256);
  beginShape();
  if (hor) {
    fill(c1, alp);
    vertex(x, y);
    vertex(x+w, y);
    fill(c2, alp);
    vertex(x+w, y+h);
    vertex(x, y+h);
  } else {
    fill(c1, alp);
    vertex(x+w, y);
    vertex(x+w, y+h);
    fill(c2, alp);
    vertex(x, y+h);
    vertex(x, y);
  }
  endShape(CLOSE);
  
  /*
  float bb = min(min(w, h), 3);
  bb = min(w, h)*0.1;
  beginShape();
  fill(255);
  vertex(x, y+h);
  vertex(x+w, y+h);
  fill(255, 0);
  vertex(x+w-bb, y+h-bb);
  vertex(x, y+h-bb);
  endShape();
  beginShape();
  fill(255);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(255, 0);
  vertex(x+w-bb, y+h-bb);
  vertex(x+w-bb, y);
  endShape();
  */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#FF0000, #FF6C06, #EF9FE2, #0045D8, #152300};
int colors[] = {#3520A6, #68FB77, #FB8F2D, #F0F962, #874BAB};
//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
//int colors[] = {#34302E, #72574C, #9A4F7D, #488753, #D9BE3A, #D9CF7C, #E2DFDA, #CF4F5C, #368886};
//int colors[] = {#FFFFFF, #000000, #FFFFFF, #000000};
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