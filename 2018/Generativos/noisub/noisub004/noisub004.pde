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
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(252);
  noiseDetail(2, 0.45);
  
  float desSize = random(1000);  
  float detSize = random(0.004, 0.006)*0.8;

  float desDir = random(1000);    
  float detDir = random(0.004, 0.006)*0.6;

  ArrayList<Rect> rects = new ArrayList<Rect>();

  int cc = 5;
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rects.add(new Rect(i*ss, j*ss, ss, ss));
    }
  }

  int sub = 1000000;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float noi = noise(desSize+(r.x+r.w*0.5)*detSize, desSize+(r.y+r.h*0.5)*detSize);
    float min = map(noi, 0, 1, 2, ss*0.5);

    float mw = r.w*0.5;
    float mh = r.w*0.5;
    if (mw < min || mh < min) continue;
    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
    rects.add(new Rect(r.x, r.y+mh, mw, mh));
    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    int type = int(random(3));
    if (type == 0) rect(r.x, r.y, r.w, r.h);
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

    float alp = random(60, 80);
    float s1 = 0.2;
    float s2 = 0.8;
    int shw = int(random(4));
    shw = int(noise(desDir+(r.x+r.w*0.5)*detDir, desDir+(r.y+r.h*0.5)*detDir)*4);
    if (shw == 0) {
      beginShape(QUADS);

      fill(0, alp);
      vertex(r.x, r.y); 
      vertex(r.x+r.w, r.y);
      fill(0, 0);
      vertex(r.x+r.w*s2, r.y+r.h*s1);
      vertex(r.x, r.y+r.h*s1);

      fill(0, alp);
      vertex(r.x+r.w, r.y);
      vertex(r.x+r.w, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s2, r.y+r.h);
      vertex(r.x+r.w*s2, r.y+r.h*s1);

      endShape();
    }

    if (shw == 1) {
      beginShape(QUADS);

      fill(0, alp);
      vertex(r.x, r.y);
      vertex(r.x, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s1, r.y+r.h*s2);
      vertex(r.x+r.w*s1, r.y);

      fill(0, alp);
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s1, r.y+r.h*s2);
      vertex(r.x+r.w, r.y+r.h*s2);

      endShape();
    }

    if (shw == 2) {
      beginShape(QUADS);

      fill(0, alp);
      vertex(r.x, r.y);
      vertex(r.x, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s1, r.y+r.h);
      vertex(r.x+r.w*s1, r.y+r.h*s1);

      fill(0, alp);
      vertex(r.x, r.y);
      vertex(r.x+r.w, r.y);
      fill(0, 0);
      vertex(r.x+r.w, r.y+r.h*s1);
      vertex(r.x+r.w*s1, r.y+r.h*s1);

      endShape();
    }

    if (shw == 3) {
      beginShape(QUADS);

      fill(0, alp);
      vertex(r.x, r.y+r.h);
      vertex(r.x+r.w, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s2, r.y+r.h*s2);
      vertex(r.x, r.y+r.h*s2);

      fill(0, alp);
      vertex(r.x+r.w, r.y);
      vertex(r.x+r.w, r.y+r.h);
      fill(0, 0);
      vertex(r.x+r.w*s2, r.y+r.h*s2);
      vertex(r.x+r.w*s2, r.y);

      endShape();
    }
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

int colors[] = {#DAAC80, #FCC9D2, #FC2E1D, #235F3F, #02272D};
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
