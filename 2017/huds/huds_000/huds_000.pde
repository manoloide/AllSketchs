PFont font;


void setup() {
  size(960, 960);
  font = createFont("Supply-Light", 48, true);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  blendMode(BLEND);
  background(#0a0d0f);

  rectNoise(0, 0, width, height, 60);
  rectNoise(0, 0, width, height, 30);
  rectNoise(0, 0, width, height, 15);
  stroke(0, 40);
  grid(0, 0, width, height, 15);
  stroke(0, 40);
  grid(0, 0, width, height, 30);
  noisee(5, 0, 0, width, height);

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));

  int cc = int(random(30));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind);
    float ss = q.z*0.5;
    if (ss < 20) continue;
    quads.add(new PVector(q.x, q.y, ss));
    quads.add(new PVector(q.x+ss, q.y, ss));
    quads.add(new PVector(q.x+ss, q.y+ss, ss));
    quads.add(new PVector(q.x, q.y+ss, ss));
    quads.remove(ind);
  }

  float ss = width*1./cc;

  blendMode(ADD);
  noFill();
  stroke(255, 80);
  strokeCap(SQUARE);
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    float s = q.z;
    float x = q.x;
    float y = q.y;
    color col = rcol();
    int rnd = int(random(2.5));
    if (rnd == 0) {
      x += s*0.5;
      y += s*0.5;
      fill(col, 4);
      stroke(col, 100);
      strokeWeight(min(2, s*0.02));
      circle(x, y, s*0.94, int(pow(2, int(random(5)))), int(random(1, 8)));
      stroke(col, 40);
      strokeWeight(min(2, s*random(0.02)));
      circle(x, y, s*0.94, int(pow(2, int(random(5)))), int(random(1, 16)));
      int ccc = int(random(random(4, 20)*random(1)));
      for (int k = 0; k < ccc; k++) {
        float d = random(s*0.4);
        float a = random(TWO_PI);
        fill(col, 180);
        ellipse(x+cos(a)*d, y+sin(a)*d, s*0.01, s*0.01);
      }
    } else if (rnd == 1) {
      fill(col);
      strokeWeight(min(2, s*0.02));
      int c = int(random(2, 20));
      grid(x, y, s, s, c, 4);
    } else {
      waveShape(x, y, s, s, col);
    }
  } 
  /*
  for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   circle((i+0.5)*ss, (j+0.5)*ss, ss*0.8, int(pow(2, int(random(5)))), int(random(1, 8)));
   }
   }
   */
}

void waveShape(float x, float y, float w, float h, color col) {
  x += 2;
  y += 2;
  w -= 4;
  h -= 4;
  float per1 = 0.05*random(1)*random(1);
  float amp1 = random(0.4, 0.8);
  float m1 = int(random(4));
  float per2 = 0.05*random(1)*random(1);
  float amp2 = random(0.2, 0.5);
  float m2= random(4);
  float mix = random(1);
  beginShape();
  noFill();
  stroke(col, 20);
  strokeWeight(1);
  int stp = int(random (4, 60));
  grid2(x, y, w, h, stp);
  stroke(col, 80);
  rect(x, y, w, h);
  fill(col, random(80));
  stroke(col, 200);
  strokeWeight(min(2, w*0.02));
  for (float i = x; i < x+w; i++) {
    float val = lerp(osc(i*per1, m1)*amp1, osc(i*per2, m2)*amp2, mix);
    vertex(i, h*0.25+y+val*h);
  }
  vertex(x+w, y+h);
  vertex(x, y+h);
  endShape(CLOSE);
}

float osc(float v, float m) {
  m %= 4;
  v %= 1;
  float saw = v;
  float sqr = (v < 0.5)? 0 : 1;
  float sin = abs(sin(v*TWO_PI));
  float tri = abs(v*2-1);

  float res = 0;
  if (m < 1) res = lerp(saw, sqr, m%1);
  else if (m < 2) res = lerp(sqr, sin, m%1);
  else if (m < 3) res = lerp(sin, tri, m%1);
  else if (m < 4) res = lerp(tri, saw, m%1);
  return res;
}

void grid(float x, float y, float w, float h, int cc, float b) {
  float dx = x+b;
  float dy = y+b;
  float sw = (w-b*2)/cc;
  float sh = (h-b*2)/cc;
  color col = g.fillColor;
  float det = random(0.05, 2);
  float ss = 1;
  if (random(1) < 0.4) {
    ss = random(0.7, 0.99);
    dx += (sw-sw*ss)*0.5;
    dy += (sh-sh*ss)*0.5;
  }
  for (int j = 0; j < cc; j++) { 
    for (int i = 0; i < cc; i++) {
      fill(col, pow(noise(i*det, j*det), 1.4)*160);
      stroke(col, 80);
      rect(dx + i*sw, dy + j*sh, sw*ss, sh*ss);
      noStroke();
      rect(dx + i*sw, dy + j*sh, sw*ss, sh*ss);
    }
  }
  fill(col);
}

void rectNoise(float x, float y, float w, float h, float ss) {
  noStroke();
  for (float j = y; j < y+h; j+=ss) {
    for (float i = x; i < x+w; i+=ss) {
      fill(random(256), random(5, 15));
      rect(i, j, ss, ss);
    }
  }
}

void grid(float x, float y, float w, float h, float stp) {
  w -= w%stp;
  h -= h%stp;
  for (float i = x; i <= x+w; i+=stp) {
    line(i, y, i, y+h);
  }
  for (float j = y; j <= y+h; j+=stp) {
    line(x, j, x+w, j);
  }
}

void grid2(float x, float y, float w, float h, int cc) {
  float dx = w/cc;
  float dy = h/cc;
  for (float i = 0; i <= cc; i++) {
    line(x+i*dx, y, x+i*dx, y+h);
  }
  for (float j = 0; j <= cc; j++) {
    line(x, y+j*dy, x+w, y+j*dy);
  }
}

void noisee(int n, int x, int y, int w, int h) {
  int x1 = constrain(x, 0, width);
  int x2 = constrain(x+w, 0, width);
  int y1 = constrain(y, 0, height);
  int y2 = constrain(y+h, 0, height);
  for (int j = y1; j < y2; j++) {  
    for (int i = x1; i < x2; i++) {
      color col = get(i, j);
      float b = random(-n, n);
      col = color(red(col)+b, green(col)+b, blue(col)+b);
      set(i, j, col);
    }
  }
}

int pallet[] = {#e58222, #45b1e0, #74e39c};
int rcol() { 
  return pallet[int(random(pallet.length))];
}

void circle(float x, float y, float s, int div, int seg) {
  float r = s*0.5;
  float da = TWO_PI/div;

  for (int i = 0; i < div/2; i++) {
    line(x+cos(da*i)*r*1.08, y+sin(da*i)*r*1.08, x+cos(da*i+PI)*r*1.08, y+sin(da*i+PI)*r*1.08);
  }
  ellipse(x, y, s-2, s-2);
  for (int i = 0; i < seg; i++) {
    float ss = map(i, 0, seg, s, 0);
    ellipse(x, y, ss, ss);
  }
}

void circleSeg(float x, float y, float s, int div, int seg) {
  float r = s*0.5;
  float da = TWO_PI/div;
  float a1, a2;
  for (int j = 0; j < div; j++) {
    a1 = j*da;
    a2 = (j+1)*da;
    for (int i = 0; i < seg; i++) {
      if (random(1) < 0.5) continue;
      float ss = map(i, 0, seg, s, 0);
      arc(x, y, ss, ss, a1, a2);
    }
  }
}

/*
void grid(float x, float y, float w, float h) {
 y += 1;
 float ww = 0;
 float dx = 1;
 fill(255, 10);
 rect(x+2, y+2, w-4, h-4);
 while (dx < w-2) {
 ww = int(random(w*random(0.2*random(1))));
 ww = max(1, min(ww, (w-2)-dx));
 if (random(1) < 0.3) {
 fill(255, random(200, 240));
 rect(x+dx, y, ww, h-2);
 }
 dx += ww;
 }
 }
 */