import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float time;

void setup() {
  size(960, 960, P3D);
  smooth(2);
  //pixelDensity(2);


  rectMode(CENTER);
  strokeWeight(0.6);


  generate();
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
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

void draw() {

  time = frameCount/60.;//millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(2);
  background(8);

  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);


  float fov = PI/4.2;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  //ortho();
  translate(width*0.5, height*0.5, -200);

  rotateX(PI*0.12+random(-0.1, 0.1)*time);
  rotateY(random(-0.1, 0.1)*time);
  rotateZ(PI*0.25+random(-0.1, 0.1)*time);


  float ww = width*1.75;
  float hh = width*1.75;
  float dd = width*1.60;


  bb(0, 0, 0, ww*0.6, hh*0.6, dd*0.6);
}

float curve(float val, float pwr) {
  float nv = val;
  if (val < 0.5) {
    nv = pow(map(val, 0.0, 0.5, 0, 1), pwr);
  } else {
    nv = pow(map(val, 0.5, 1.0, 1, 0), pwr);
  }
  return nv;
}

void bb(float x, float y, float z, float w, float h, float d) {

  ArrayList<Box> boxes = new  ArrayList<Box>();
  boxes.add(new Box(x, y, z, w, h, d));

  float des = random(10000);
  float det = random(0.001);

  float vel = random(1)*0.2;

  int div = int(random(10, 30)*2);
  for (int i = 0; i < div; i++) {

    int ind = int(random(boxes.size()*random(1)*random(1)));
    Box b = boxes.get(ind);

    float m1w = curve((float) noise(100+des+b.x*det, des+b.y*det, -23.3+i+time*vel), random(0.8, 5));
    float m1h = curve((float) noise(des+b.x*det, 100+des+b.y*det, +57.6+i+time*vel+5.4), random(0.8, 5));
    float m1d = curve((float) noise(des-b.x*det, 100+des+b.y*det, +27.1+i-time*vel), random(0.8, 5));
    float m2w = 1-m1w;
    float m2h = 1-m1h;
    float m2d = 1-m1d;

    m1w = m1w*0.4+0.3;
    m1h = m1h*0.4+0.3;
    m1d = m1d*0.4+0.3;
    m2w = m2w*0.4+0.3;
    m2h = m2h*0.4+0.3;
    m2d = m2d*0.4+0.3;

    m1w *= b.w;
    m2w *= b.w;
    m1h *= b.h;
    m2h *= b.h;
    m1d *= b.d;
    m2d *= b.d;

    boxes.add(new Box(b.x-b.w*0.5+m1w*0.5, b.y-b.h*0.5+m1h*0.5, b.z-b.d*0.5+m1d*0.5, m1w, m1h, m1d));
    boxes.add(new Box(b.x+b.w*0.5-m2w*0.5, b.y-b.h*0.5+m1h*0.5, b.z-b.d*0.5+m1d*0.5, m2w, m1h, m1d));
    boxes.add(new Box(b.x+b.w*0.5-m2w*0.5, b.y+b.h*0.5-m2h*0.5, b.z-b.d*0.5+m1d*0.5, m2w, m2h, m1d));
    boxes.add(new Box(b.x-b.w*0.5+m1w*0.5, b.y+b.h*0.5-m2h*0.5, b.z-b.d*0.5+m1d*0.5, m1w, m2h, m1d));

    boxes.add(new Box(b.x-b.w*0.5+m1w*0.5, b.y-b.h*0.5+m1h*0.5, b.z+b.d*0.5-m2d*0.5, m1w, m1h, m2d));
    boxes.add(new Box(b.x+b.w*0.5-m2w*0.5, b.y-b.h*0.5+m1h*0.5, b.z+b.d*0.5-m2d*0.5, m2w, m1h, m2d));
    boxes.add(new Box(b.x+b.w*0.5-m2w*0.5, b.y+b.h*0.5-m2h*0.5, b.z+b.d*0.5-m2d*0.5, m2w, m2h, m2d));
    boxes.add(new Box(b.x-b.w*0.5+m1w*0.5, b.y+b.h*0.5-m2h*0.5, b.z+b.d*0.5-m2d*0.5, m1w, m2h, m2d));

    boxes.remove(ind);
  }

  //blendMode(ADD);


  noFill();
  stroke(255, 200);
  sphereDetail(8);
  for (int i = 0; i < boxes.size(); i++) {
    Box b = boxes.get(i);
    float ddd = min(b.w, b.h);
    pushMatrix();
    translate(b.x, b.y, b.z);
    strokeWeight(1);
    //point(b.x, b.y, b.z);
    strokeWeight(random(2));
    stroke(255, 200);
    fill(240);
    lbox(b.w, b.h, b.d);
    //nave(b.w*0.6, b.h*0.6, b.d*0.6);
    //lbox(b.w*0.2, b.h*0.2, b.d*0.2);
    noStroke();
    pushMatrix();
    rotateX(time*random(-1, 1));
    rotateY(time*random(-1, 1));
    rotateZ(time*random(-1, 1));
    scale(b.w*0.2, b.h*0.2, b.d*0.2);
    fill(rcol());
    sphere(1);
    popMatrix();

    float ss = min(min(b.w*0.004, b.h*0.004), b.d*0.004)*0.2;

    noStroke();
    fill(255);
    box(ss, ss, ss);

    popMatrix();
  }
}

void nave(float w, float h, float d) {
  float s1 = w*random(0.2, 0.5)*0.01;
  float s2 = h*random(0.2, 0.5)*0.2;
  float s3 = d*random(0.2, 0.5)*0.01;
  float mw = w*0.2; 
  float mh = h*0.2; 
  float md = d*0.2; 
  noStroke();
  for (int i = 0; i < 40; i++) {
    float nx = random(-mw, mw);
    float ny = random(-mh, mh);
    float nz = random(-md, md);
    float rx = random(-1, 1)*random(1.1);
    float ry = random(-1, 1)*random(1.1);
    float rz = random(-1, 1)*random(1.1);
    fill(rcol());
    pushMatrix();
    translate(nx, ny, nz);
    ;
    rotateZ(rz);
    rotateY(ry);
    rotateX(rx);
    box(s1, s2, s3);
    popMatrix();
    pushMatrix();
    translate(-nx, ny, nz);
    rotateZ(-rz+PI);
    rotateY(ry);
    rotateX(rx);
    box(s1, s2, s3);
    popMatrix();
  }
}

void lbox(float w, float h, float d) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;


  strokeWeight(1);

  lline(-w*0.5, -h*0.5, -d*0.5, +w*0.5, -h*0.5, -d*0.5);
  lline(-w*0.5, -h*0.5, +d*0.5, +w*0.5, -h*0.5, +d*0.5);
  lline(-w*0.5, +h*0.5, -d*0.5, +w*0.5, +h*0.5, -d*0.5);
  lline(-w*0.5, +h*0.5, +d*0.5, +w*0.5, +h*0.5, +d*0.5);

  lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, +h*0.5, -d*0.5);
  lline(+w*0.5, -h*0.5, -d*0.5, +w*0.5, +h*0.5, -d*0.5);
  lline(+w*0.5, -h*0.5, +d*0.5, +w*0.5, +h*0.5, +d*0.5);
  lline(-w*0.5, -h*0.5, +d*0.5, -w*0.5, +h*0.5, +d*0.5);


  lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, -h*0.5, +d*0.5);
  lline(+w*0.5, -h*0.5, -d*0.5, +w*0.5, -h*0.5, +d*0.5);
  lline(+w*0.5, +h*0.5, -d*0.5, +w*0.5, +h*0.5, +d*0.5);
  lline(-w*0.5, +h*0.5, -d*0.5, -w*0.5, +h*0.5, +d*0.5);

  //lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, +h*0.5, -d*0.5);


  //lline(+w*0.5, +h*0.5, -d*0.5, +w*0.5, +h*0.5, +d*0.5);
  /*
  lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, -h*0.5, -d*0.5);
   lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, -h*0.5, -d*0.5);
   lline(-w*0.5, -h*0.5, -d*0.5, -w*0.5, -h*0.5, -d*0.5);
   
  /*
   lline(+w*0.5, +h*0.5, +d*0.5, -w*0.5, +h*0.5, +d*0.5);
   lline(+w*0.5, +h*0.5, +d*0.5, +w*0.5, -h*0.5, +d*0.5);
   lline(+w*0.5, +h*0.5, +d*0.5, +w*0.5, +h*0.5, -d*0.5);
   */

  beginShape(POINTS);
  vertex(-mw, -mh, -md);

  vertex(+mw, -mh, -md);
  vertex(-mw, +mh, -md);
  vertex(-mw, -mh, +md);

  vertex(-mw, +mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, -md);

  vertex(+mw, +mh, +md);
  endShape();
}

void lline(float x1, float y1, float z1, float x2, float y2, float z2) {
  float dis = dist(x1, y1, z1, x2, y2, z2);
  float cc = max(2, dis*0.08);
  float amp = 0.1;
  for (int i = 0; i < cc; i++) {
    float v1 = map(i, 0, cc, 0, 1);
    float v2 = map(i+amp, 0, cc, 0, 1);
    float xx1 = lerp(x1, x2, v1); 
    float xx2 = lerp(x1, x2, v2); 
    float yy1 = lerp(y1, y2, v1); 
    float yy2 = lerp(y1, y2, v2); 
    float zz1 = lerp(z1, z2, v1); 
    float zz2 = lerp(z1, z2, v2); 
    line(xx1, yy1, zz1, xx2, yy2, zz2);
  }
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(99999));
}

int colors[] = {#81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
