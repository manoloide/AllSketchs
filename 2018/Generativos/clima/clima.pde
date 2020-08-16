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

  int sep = 120;
  int gri = 15;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(500)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    if (sep*2 >= r.w || sep*2 >= r.h) continue;
    float nw = int(random(1, r.w/sep-1))*sep;
    float nh = int(random(1, r.h/sep-1))*sep;
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

    float alp = random(80)*random(1);
    for (float gx = 0; gx < r.w; gx+=gri) {
      stroke(rcol(), alp);
      line(r.x+gx, r.y, r.x+gx, r.y+r.h);
    }
    for (float gy = 0; gy < r.h; gy+=gri) {
      stroke(rcol(), alp);
      line(r.x, r.y+gy, r.x+r.w, r.y+gy);
    }

    float det1 = random(0.01);
    float des1 = random(1000);
    float det2 = random(0.01);
    float des2 = random(1000);
    for (float gy = -gri; gy < r.h+gri; gy+=gri*0.25) {
      for (float gx = -gri; gx < r.w+gri; gx+=gri*0.25) {
        float xx = r.x+gx+gri*0.5;
        float yy = r.y+gy+gri*0.5;
        float an = noise(des1+xx*det1, des1+yy*det1)*TAU*2;
        float dd = noise(des2+xx*det2, des2+yy*det2)*gri;
        float x1 = constrain(xx, r.x, r.x+r.w);
        float y1 = constrain(yy, r.y, r.y+r.h);
        float x2 = constrain(xx+cos(an)*dd, r.x, r.x+r.w);
        float y2 = constrain(yy+sin(an)*dd, r.y, r.y+r.h);
        stroke(rcol(), random(120)*random(0.2, 1));
        line(x1, y1, x2, y2);
      }
    }

    float vol = (r.w*r.h)/gri;

    for (int j = 0; j < vol*0.04; j++) {
      float ss = random(2);
      float xx = r.x+random(ss*0.5, r.w-ss*0.5);
      float yy = r.y+random(ss*0.5, r.h-ss*0.5);
      noStroke();
      fill(rcol(), random(200));
      ellipse(xx, yy, ss, ss);
    }

    int ccc = int(vol*random(0.1));
    for (int j = 0; j < ccc; j++) {
      float xx = r.x+int(random(r.w/gri))*gri;
      float yy = r.y+int(random(r.h/gri))*gri;
      fill(rcol(), random(250)*random(1));
      rect(xx+2, yy+2, gri-3, gri-3);
    }

    ccc = int(vol*random(0.1));
    for (int j = 0; j < ccc; j++) {
      float xx = r.x+int(random(1, r.w/gri))*gri;
      float yy = r.y+int(random(1, r.h/gri))*gri;
      float ss = random(1, 4);
      fill(rcol(), random(250)*random(1));
      ellipse(xx+0.5, yy+0.5, ss, ss);
    }



    beginShape();
    fill(rcol(), random(20));
    vertex(r.x, r.y);
    vertex(r.x+r.w, r.y);
    fill(rcol(), random(20));
    vertex(r.x+r.w, r.y+r.h);
    vertex(r.x, r.y+r.h);
    endShape(CLOSE);

    ArrayList<PVector> ac = new ArrayList<PVector>();
    ArrayList<PVector> cs = new ArrayList<PVector>();
    float ss = min(r.w, r.h)*random(0.2, 0.9);
    float xx = r.x+lerp(r.w*0.5, random(ss*0.5, r.w-ss*0.5), random(0.8));
    float yy = r.y+lerp(r.h*0.5, random(ss*0.5, r.h-ss*0.5), random(0.8));
    ac.add(new PVector(xx, yy, ss));
    cs.add(new PVector(xx, yy, ss));
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
    fill(rcol(), random(80));
    vertex(r.x, r.y);
    vertex(r.x+r.w, r.y);
    fill(rcol(), random(80));
    vertex(r.x+r.w, r.y+r.h);
    vertex(r.x, r.y+r.h);
    endShape(CLOSE);

    int cc = int(random(1, 4));
    for (int j = 0; j < cc; j++) {
      montains(r.x, r.y, r.w, r.h);
    }

    /*
    int cw = int(random(2, 20));
     int ch = int(random(2, 20));
     float bb = floor(min(r.w/cw, r.h/ch)*random(0.02, 0.04));
     bb = max(bb, 1);
     float dw = (r.w-bb)/cw;
     float dh = (r.h-bb)/ch;
     fill(rcol(), 180);
     for (int k = 0; k <= cw; k++) {
     rect(r.x+k*dw, r.y, bb, r.h);
     }
     for (int k = 0; k <= ch; k++) {
     rect(r.x, r.y+k*dh, r.w, bb);
     }
     */
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

void montains(float x, float y, float w, float h) {
  FloatList p = new FloatList();
  p.append(0);
  p.append(w);
  for (int i = 0; i < 10; i++) {
    p.append(random(w));
  }
  p.sort();

  int c1 = rcol();
  int c2 = rcol();
  beginShape();
  for (int i = 0; i < p.size()-1; i++) {
    float v1 = p.get(i);
    float v2 = p.get(i+1);
    float m = lerp(v1, v2, random(0.2, 0.8));
    float hh = map(v2-v1, 0, w, 0, h);//*random(5);
    fill(c1);
    if (i == 0) vertex(x+v1, y+h);
    fill(c2);
    vertex(x+m, y+h-hh);
    fill(c1);
    vertex(x+v2, y+h);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
//int colors[] = {#2E0551, #FF00C7, #01AFC2, #FDBE03, #F4F9FD};
//int colors[] = {#2E601D, #E4428D, #F798D3, #1C506E, #04192C};
int colors[] = {#19143C, #F67379, #F6C7C2, #C3C5A1, #7DA89B};
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