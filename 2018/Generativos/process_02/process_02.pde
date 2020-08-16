int seed = int(random(999999));

PImage noise;
PShader post;


void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  
  
  post = loadShader("post.glsl");

  createNoise();

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void generate() {

  float time = millis()*0.0002;

  randomSeed(seed);
  background(rcol(backs));

  ambientLight(240, 240, 240);
  directionalLight(20, 20, 20, 0, 1, 0);
  directionalLight(10, 10, 20, -1, 0, 0);
  noStroke();
  pushMatrix();
  ortho();
  translate(width/2, height/2, -1000);
  rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateZ(-HALF_PI*0.5-time);


  //strokeWeight(2);
  //stroke(0, 10);
  float ss = width*0.6;
  float minS = ss/128.;
  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, ss));
  int sub = int(random(4, random(80)));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    if (ms <= minS) continue;
    float mm = ms*0.5;
    rects.add(new PVector(r.x-mm, r.y-mm, ms));
    rects.add(new PVector(r.x+mm, r.y-mm, ms));
    rects.add(new PVector(r.x+mm, r.y+mm, ms));
    rects.add(new PVector(r.x-mm, r.y+mm, ms));
    rects.remove(ind);
  }

  pushMatrix();
  float det = random(0.1);
  float des = random(100000);
  float amp = random(0.3, 0.5);
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float noi = noise(des+r.x*det, des+r.y*det);
    if (noi < amp) continue;
    pushMatrix();
    translate(r.x, r.y, -80);//r-r.z*0.5);
    /*
    rotateX(random(TWO_PI));
     rotateY(random(TWO_PI));
     rotateZ(random(TWO_PI));
     */
    fill(rcol(colors));
    float s = r.z;//*map(noi, amp, 1, 0, 1);
    boxColors(s, s, minS, true);

    int rnd = int(random(8));

    if (rnd == 0) {
      int cc = int(map(noi, 0, 1, 1, 12));
      float a = random(0.5);
      float hh = minS*random(1, 4);
      for (int j = 1; j < cc; j++) {
        translate(0, 0, hh);
        float sss = map(j, 0, cc, s, 0);
        boxRound(sss, sss, hh, a);
      }
    }

    if (rnd == 1) {
      float sss = s*random(0.1, 0.5);
      float h = sss*random(1.5);
      if (random(1) < 5) fill(rcol(colors));
      translate(0, 0, h);
      sphere(sss);
    }

    if (rnd == 2) {
      int cc = int(map(noi, 0, 1, 1, 8));
      float sss = s*random(0.1, random(0.8));
      float sep = random(1, 1.4);
      translate(0, 0, sss*0.5+minS);
      for (int j = 1; j < cc; j++) {
        boxColors(sss, sss, sss, true);
        translate(0, 0, sss*sep);
      }
    }

    if (rnd == 3) {
      int cw = int(random(2, random(2, 10)));
      int ch = int(random(2, random(2, 10))); 
      float bb = s*random(0.05, 0.1);
      float dw = (s-bb*2)/cw;
      float dh = (s-bb*2)/ch;
      float ww = dw*random(0.3, 1);
      float hh = dh*random(0.3, 1);
      float dd = min(ww, hh)*random(0.5, random(2));

      for (int j = 0; j < ch; j++) {
        for (int k = 0; k < cw; k++) {
          pushMatrix();
          translate(bb+dw*(k+0.5)-s*0.5, bb+dh*(j+0.5)-s*0.5, (minS+dd)*0.5);
          boxColors(ww, hh, dd, true);
          popMatrix();
        }
      }
    }

    popMatrix();
  }
  popMatrix();
  popMatrix();
  
  

  post = loadShader("post.glsl");
  filter(post);


  //image(noise, 0, 0);
}

void boxColors(float ss) {
  boxColors(ss, ss, ss);
}

void boxColors(float w, float h, float d) {
  boxColors(w, h, d, g.fillColor, g.fillColor, false);
}

void boxColors(float w, float h, float d, boolean rand) {
  boxColors(w, h, d, g.fillColor, g.fillColor, rand);
}

void boxColors(float w, float h, float d, int c1, int c2, boolean rand) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;

  if (rand) fill(rcol(colors));
  //fill(0);
  beginShape();
  if (!rand) fill(c1);
  vertex(-mw, -mh, -md);
  vertex(-mw, +mh, -md);
  if (!rand) fill(c2);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  endShape(CLOSE);


  if (rand) fill(rcol(colors));
  beginShape();
  if (!rand) fill(c1);
  vertex(-mw, +mh, -md);
  vertex(+mw, +mh, -md);
  if (!rand) fill(c2);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape(CLOSE);

  if (rand) fill(rcol(colors));
  beginShape();
  if (!rand) fill(c2);
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape(CLOSE);

  boolean opti = false;
  if (!opti) {
    if (rand) fill(rcol(colors));
    beginShape();
    if (!rand) fill(c1);
    vertex(+mw, -mh, -md);
    vertex(+mw, +mh, -md);
    if (!rand) fill(c2);
    vertex(+mw, +mh, +md);
    vertex(+mw, -mh, +md);
    endShape(CLOSE);
    if (rand) fill(rcol(colors));
    beginShape();
    if (!rand) fill(c1);
    vertex(-mw, -mh, -md);
    vertex(+mw, -mh, -md);
    if (!rand) fill(c2);
    vertex(+mw, -mh, +md);
    vertex(-mw, -mh, +md);
    endShape(CLOSE);
    if (rand) fill(rcol(colors));
    beginShape();
    if (!rand) fill(c1);
    vertex(-mw, -mh, -md);
    vertex(+mw, -mh, -md);
    vertex(+mw, +mh, -md);
    vertex(-mw, +mh, -md);
    endShape(CLOSE);
  }
}

void boxRound(float w, float h, float d, float rou) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;
  float r = min(w, h)*rou;
  int res = int(max(4, r*HALF_PI*0.2));
  float da = HALF_PI/res;
  float sqrt2 = sqrt(2);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 4; i++) {
    float ang = (i)*HALF_PI;
    float xx = (mw-r)*cos(ang+HALF_PI*0.5)*sqrt2;
    float yy = (mh-r)*sin(ang+HALF_PI*0.5)*sqrt2;
    for (int j = 0; j < res; j++) {
      float ang2 = ang+da*j;
      points.add(new PVector(xx+cos(ang2)*r, yy+sin(ang2)*r));
    }
  }

  beginShape();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    vertex(p.x, p.y, md);
  }
  endShape(CLOSE);

  fill(rcol(colors));
  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);
    PVector p2 = points.get((i+1)%points.size());
    beginShape();
    vertex(p1.x, p1.y, -md);
    vertex(p1.x, p1.y, +md);
    vertex(p2.x, p2.y, +md);
    vertex(p2.x, p2.y, -md);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int backs[] = {#2CB4F2, #E63B68, #F0C6B6, #D8D8D8};
int colors[] = {#27B2F0, #2D27A1, #EA3C3B, #F86404, #F9AA08, #06AA82};
int rcol(int cols[]) {
  return cols[int(random(cols.length))];
}
int getColor(int cols[]) {
  return getColor(cols, random(cols.length));
}
int getColor(int cols[], float v) {
  v = abs(v);
  v = v%(cols.length); 
  int c1 = cols[int(v%cols.length)]; 
  int c2 = cols[int((v+1)%cols.length)]; 
  return lerpColor(c1, c2, v%1);
}

void createNoise() {
  int w = 512;
  int h = 512;
  noise = createImage(w, h, RGB);
  noise.loadPixels();
  for (int i = 0; i < noise.pixels.length; i++) {
    int x = i%w;
    int y = i/w;
    float noi = random(1)*random(1)*random(1);
    noise.set(x, y, color(noi));
  }
  noise.updatePixels();
}