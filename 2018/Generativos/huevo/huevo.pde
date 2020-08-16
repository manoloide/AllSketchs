int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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
  background(250);

  int sep = 128;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(50)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    //if (sep <= r.w || sep <= r.h) continue;
    float nw = r.w/2.;//int(random(1, r.w/sep))*sep;
    float nh = r.h/2.;//int(random(1, r.h/sep))*sep;
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }

  noStroke();
  stroke(0, 10);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 8);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);

    float ss = min(r.w, r.h)*0.9;
    ArrayList<PVector> ac = new ArrayList<PVector>();
    ArrayList<PVector> cs = new ArrayList<PVector>();
    ac.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5, ss));
    cs.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5, ss));
    int div = int(random(20));
    for (int j = 0; j < div; j++) {
      int ind = int(random(ac.size()));
      PVector c = ac.get(ind);
      float ns1 = c.z*random(0.2, 0.8);
      float ns2 = c.z-ns1;
      float d1 = (ns1-c.z)*0.5;
      float d2 = (c.z-ns2)*-0.5;
      float a1 = random(TAU);
      float a2 = a1+PI;
      ac.add(new PVector(c.x+cos(a1)*d1, c.y+sin(a1)*d1, ns1));
      ac.add(new PVector(c.x+cos(a2)*d2, c.y+sin(a2)*d2, ns2));
      cs.add(new PVector(c.x+cos(a1)*d1, c.y+sin(a1)*d1, ns1));
      cs.add(new PVector(c.x+cos(a2)*d2, c.y+sin(a2)*d2, ns2));
      ac.remove(ind);
    }
    noStroke();
    for (int j = 0; j < cs.size(); j++) {
      PVector c = cs.get(j);
      arc2(c.x, c.y, c.z, c.z*1.2, 0, TAU, color(0), 30, 0);
      arc2(c.x, c.y, c.z, c.z*1.08, 0, TAU, color(0), 10, 0);
      fill(rcol());
      ellipse(c.x, c.y, c.z, c.z);
      arc2(c.x, c.y, c.z, c.z*0.2, 0, TAU, rcol(), 80, 0);
    }

    beginShape();
    fill(rcol(), random(120));
    vertex(r.x, r.y);
    vertex(r.x+r.w, r.y);
    fill(rcol(), random(120));
    vertex(r.x+r.w, r.y+r.h);
    vertex(r.x, r.y+r.h);
    endShape(CLOSE);

    int cw = int(random(2, 10));
    int ch = int(random(2, 10));
    float bb = floor(min(r.w/cw, r.h/ch)*random(0.02, 0.06));
    bb = max(bb, 1);
    float dw = (r.w-bb)/cw;
    float dh = (r.h-bb)/ch;
    fill(rcol());
    for (int k = 0; k <= cw; k++) {
      rect(r.x+k*dw, r.y, bb, r.h);
    }
    for (int k = 0; k <= ch; k++) {
      rect(r.x, r.y+k*dh, r.w, bb);
    }
  }

  noFill();
  strokeWeight(1);
  for (int i = 0; i < 1000; i++) {
    float xx = random(width); 
    float yy = random(height);
    float ss = width*random(0.012);
    float a1 = random(TAU);
    float a2 = a1+random(HALF_PI);
    stroke(0, random(20));
    arc(xx+1, yy+1, ss, ss, a1, a2);
    stroke(rcol(), random(240));
    arc(xx, yy, ss, ss, a1, a2);
  }
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

//int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
int colors[] = {#2E0551, #FF00C7, #01AFC2, #FDBE03, #F4F9FD};
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