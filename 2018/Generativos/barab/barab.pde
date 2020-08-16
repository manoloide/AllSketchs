int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
  /*
  saveImage();
   exit();
   */
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
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
  seed = int(random(999999));
  randomSeed(seed);
  background(250);

  int sep = 10;
  int cw = width/sep;
  int ch = height/sep;
  noStroke();
  float des1 = random(100000);
  float det1 = random(0.01);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float x = i*sep;
      float y = j*sep;
      fill(220, 40);
      rect(x-2, y-2, 4, 4);
      fill(getColor(noise(des1+x*det1, des1+y*det1)*colors.length), 20);
      rect(x-1, y-1, 2, 2);
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(1, 1, cw-2, ch-2));
  int sub = int(random(4000)*random(1)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    boolean hor = random(1) < 0.5;
    if (r.w > r.h) hor = true;
    else hor = false;
    if (hor && r.w >= 2) {
      int nw = int(random(1, r.w-1));
      rects.add(new Rect(r.x, r.y, nw, r.h));
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, r.h));
      rects.remove(ind);
    } 
    if (!hor && r.h >= 2) {
      int nh = int(random(1, r.h-1));
      rects.add(new Rect(r.x, r.y, r.w, nh));
      rects.add(new Rect(r.x, r.y+nh, r.w, r.h-nh));
      rects.remove(ind);
    }
  }

  stroke(0);
  for (int i = 0; i < rects.size(); i++) {
    Rect r1 = rects.get(i);
    float cx1 = (r1.x+r1.w*0.5)*sep;
    float cy1 = (r1.y+r1.h*0.5)*sep;
    for (int j = i; j < rects.size(); j++) {
      Rect r2 = rects.get(j); 
      float cx2 = (r2.x+r2.w*0.5)*sep;
      float cy2 = (r2.y+r2.h*0.5)*sep;
      float dis = dist(cx1, cy1, cx2, cy2);
      if (dis < (min(min(r1.w, r1.h), min(r2.w, r2.h))*sep*1.8)) {
        noStroke();
        fill(rcol(), 250);
        ll(cx1, cy1, cx2, cy2);
      }
    }
  }

  noStroke();
  fill(0);
  float des = random(10000);
  float det = random(0.01);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float bb = min(r.w, r.h)*sep*0.5;
    if (random(1) < 0.5) {
      noStroke();
      fill(rcol());
    } else {
      noFill();
      stroke(0);
      fill(rcol(), random(40));
    }
    rect(r.x*sep+1, r.y*sep+1, r.w*sep-2, r.h*sep-2, random(bb), random(bb), random(bb), random(bb));

    float cx = (r.x+r.w*0.5)*sep;
    float cy = (r.y+r.h*0.5)*sep;
    if (random(1) < 0.1) {
      noStroke();
      fill(rcol());
      beginShape();
      vertex(r.x*sep+1, cy);
      vertex(cx, r.y*sep+1);
      vertex((r.x+r.w)*sep-2, cy);
      vertex(cx, (r.y+r.h)*sep-2);
      endShape(CLOSE);
    }
    fill(255);
    float ss = min(r.w, r.h)*sep*0.5;
    fill(getColor(noise(des+det*r.x, des+det*r.y)*colors.length*2), 8);
    stroke(0, 20);
    ellipse(cx, cy, ss, ss);
    noStroke();
    stroke(0, 1);
    arc2(cx, cy, ss, ss*2, 0, TAU, rcol(), 50, 0);
    arc2(cx, cy, ss, ss*1.4, 0, TAU, rcol(), 20, 0);
    arc2(cx, cy, ss, ss*0.2, 0, TAU, rcol(), 20, 0);
    noStroke();
    fill(rcol());
    //ellipse(cx, cy, ss*0.05, ss*0.05);
  }
}

void ll(float x1, float y1, float x2, float y2) {
  float ang = atan2(y2-y1, x2-x1);
  float dd = dist(x1, y1, x2, y2);
  float rr = dd*0.06;
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5;
  int res = int(max(4, PI*rr));
  beginShape();
  float aa = 0.95;
  for (int i = 0; i <= res; i++) {
    float a = map(i, 0, res, +PI*aa, -PI*aa);
    float r = rr;
    vertex(x1+cos(ang+a+PI)*r, y1+sin(ang+a+PI)*r);
  }
  for (int i = 0; i <= res; i++) {
    float a = map(i, 0, res, +PI*aa, -PI*aa);
    vertex(x2+cos(ang+a)*rr, y2+sin(ang+a)*rr);
  }
  endShape(CLOSE);
}



void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};
int colors[] = {#FE1451, #00EFF1, #0001DD, #000000};
//int colors[] = {#F97EB2, #EFDB01, #018FD8, #6EB201, #F92F23, #F9F6FA, #783391};
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