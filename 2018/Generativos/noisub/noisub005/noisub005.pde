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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Rect {
  float x, y, w, h;
  int sub;
  Rect(float x, float y, float w, float h, int sub) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.sub = sub;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(252);
  noiseDetail(2, 0.45);

  float desSizeX = random(1000);  
  float detSizeX = random(0.004, 0.006)*0.8;
  float desSizeY = random(1000);  
  float detSizeY = random(0.004, 0.006)*0.8;

  desSizeY = desSizeX;
  detSizeY = detSizeX;

  float desDir = random(1000);    
  float detDir = random(0.004, 0.006)*0.6;

  ArrayList<Rect> rects = new ArrayList<Rect>();

  int cc = 3;
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rects.add(new Rect(i*ss, j*ss, ss, ss, 1));
    }
  }

  int sub = 1000000;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float xx = r.x+r.w*0.5;
    float yy = r.y+r.h*0.5;

    float noiX = noise(desSizeX+xx*detSizeX, desSizeX+yy*detSizeX);
    float minW = map(pow(noiX, 2), 0, 1, 2, ss);

    float noiY = noise(desSizeY+xx*detSizeY, desSizeY+yy*detSizeY);
    float minH = map(pow(noiY, 2), 0, 1, 2, ss);

    int cw = (r.w < minW)? 1 : 2;
    int ch = (r.h < minH)? 1 : 2;

    float mw = r.w/cw;
    float mh = r.h/ch;
    for (int dy = 0; dy < ch; dy++) {
      for (int dx = 0; dx < cw; dx++) {
        rects.add(new Rect(r.x+dx*mw, r.y+dy*mh, mw, mh, r.sub+1));
      }
    }
    rects.remove(ind);
  }

  float desColor = random(1000);  
  float detColor = random(0.004, 0.006)*0.14;

  float desAlp = random(1000);  
  float detAlp = random(0.004, 0.006)*0.14;

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    int type = int(random(3));
    type = 0;
    
    float x = r.x+r.w*0.5;
    float y = r.y+r.h*0.5;

    int col = getColor(x, y, detColor, desColor, r.sub);
    fill(col);
    if (type == 0) rect(r.x, r.y, r.w, r.h);
    /*
    if (type == 1) {
     beginShape();
     fill(rcol());
     vertex(r.x, r.y);
     vertex(r.x+r.w, r.y);
     fill(rcol());
     vertex(r.x+r.w, r.y+r.h);
     vertex(r.x, r.y+r.h);
     endShape(CLOSE);
     }
     if (type == 2) {
     beginShape();
     fill(rcol());
     vertex(r.x, r.y+r.h);
     vertex(r.x, r.y);
     fill(rcol());
     vertex(r.x+r.w, r.y);
     vertex(r.x+r.w, r.y+r.h);
     endShape(CLOSE);
     }
     */
    int shw = int(random(4));
    shw = int(noise(desDir+(r.x+r.w*0.5)*detDir, desDir+(r.y+r.h*0.5)*detDir)*4);

    float alp = noise(desAlp+x*detAlp, desAlp+y*detAlp)*200;

    shadow(r.x, r.y, r.w, r.h, shw, lerpColor(col, color(0), 0.4), 20);
  }
}

void shadow(float x, float y, float w, float h, int dir, int col, float alp) {
  float s1 = 0.2;
  float s2 = 0.8;

  if (dir == 0) {
    beginShape(QUADS);

    fill(col, alp);
    vertex(x, y); 
    vertex(x+w, y);
    fill(col, 0);
    vertex(x+w*s2, y+h*s1);
    vertex(x, y+h*s1);

    fill(col, alp);
    vertex(x+w, y);
    vertex(x+w, y+h);
    fill(col, 0);
    vertex(x+w*s2, y+h);
    vertex(x+w*s2, y+h*s1);

    endShape();
  }

  if (dir == 1) {
    beginShape(QUADS);

    fill(col, alp);
    vertex(x, y);
    vertex(x, y+h);
    fill(col, 0);
    vertex(x+w*s1, y+h*s2);
    vertex(x+w*s1, y);

    fill(col, alp);
    vertex(x+w, y+h);
    vertex(x, y+h);
    fill(col, 0);
    vertex(x+w*s1, y+h*s2);
    vertex(x+w, y+h*s2);

    endShape();
  }

  if (dir == 2) {
    beginShape(QUADS);

    fill(col, alp);
    vertex(x, y);
    vertex(x, y+h);
    fill(col, 0);
    vertex(x+w*s1, y+h);
    vertex(x+w*s1, y+h*s1);

    fill(col, alp);
    vertex(x, y);
    vertex(x+w, y);
    fill(col, 0);
    vertex(x+w, y+h*s1);
    vertex(x+w*s1, y+h*s1);

    endShape();
  }

  if (dir == 3) {
    beginShape(QUADS);

    fill(col, alp);
    vertex(x, y+h);
    vertex(x+w, y+h);
    fill(col, 0);
    vertex(x+w*s2, y+h*s2);
    vertex(x, y+h*s2);

    fill(col, alp);
    vertex(x+w, y);
    vertex(x+w, y+h);
    fill(col, 0);
    vertex(x+w*s2, y+h*s2);
    vertex(x+w*s2, y);

    endShape();
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma*0.5));
  float da = amp/cc;
  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape(CLOSE);
}

int getColor(float x, float y, float det, float des, int sub) {
  float dd = det*sub*0.02;
  return getColor(noise(des+x*dd, des+y*dd)*colors.length);
}

//int colors[] = {#DAAC80, #FCC9D2, #FC2E1D, #235F3F, #02272D};
int colors[] = {#100A01, #51247F, #F5B424, #F6F6F6};
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
