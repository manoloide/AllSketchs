int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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

void generate() {
  //background(#01131B);
  if (random(1) < 0.5) background(lerpColor(rcol(), color(0), random(0.3)));
  else background(lerpColor(rcol(), color(255), random(0.5)));
  randomSeed(seed);

  deta = random(0.04)*random(1); 
  desa = random(100000);
  umb = random(1);

  det = random(0.02); 
  des = random(10000);
  amp = random(5000)*random(1)*random(0.2, 1);

  //blendMode(ADD);
  stroke(rcol(), 100);

  //lights();

  float len = random(1.2, random(1.2, 4));
  float fov = PI/len;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float  (height), 
    cameraZ/1000.0, cameraZ*1000.0);

  translate(width*random(0, 1), height*random(0, 1));
  float maxRot = random(PI);
  rotateX(random(-maxRot, maxRot));
  rotateY(random(-maxRot, maxRot));
  rotateZ(random(TAU));

  float maxSize = width*map(pow(map(len, 1, 4, 0, 1), 1.2), 0, 1, 50, 4);
  maxSize = width*random(2, 3);

  ArrayList<Box> rects = new ArrayList<Box>();
  rects.add(new Box(0, 0, 0, maxSize));
  int sub = int(random(2, random(5, random(10, 1200))));
  float prob = random(0.6, 1);
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Box b = rects.get(ind);
    if (random(1) < prob) rects.add(new Box(b.x-b.s*0.25, b.y-b.s*0.25, b.z-b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x+b.s*0.25, b.y-b.s*0.25, b.z-b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x+b.s*0.25, b.y+b.s*0.25, b.z-b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x-b.s*0.25, b.y+b.s*0.25, b.z-b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x-b.s*0.25, b.y-b.s*0.25, b.z+b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x+b.s*0.25, b.y-b.s*0.25, b.z+b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x+b.s*0.25, b.y+b.s*0.25, b.z+b.s*0.25, b.s*0.5));
    if (random(1) < prob) rects.add(new Box(b.x-b.s*0.25, b.y+b.s*0.25, b.z+b.s*0.25, b.s*0.5));

    rects.remove(ind);
  }
  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Box b = rects.get(i);
    b.show();
  }
}

class Box {
  float x, y, z, s;
  Box(float x, float y, float z, float s) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    this.s = s;
  }
  void show() {
    noFill();
    pushMatrix();
    translate(x, y, z);
    //stroke(rcol(), random(140, 200));
    bbox(s);
    if (random(1) < 0.2) bbox(s*0.1);

    int sub = int(random(1, random(1, 5)));
    float ms = s*0.5;

    PVector p1, p2;
    for (int i = 1; i < sub; i++) {
      float ss = map(i, 0, sub, -ms, ms);
      p1 = dp(ss, -ms, -ms);
      p2 = dp(ss, +ms, -ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      p1 = dp(ss, +ms, -ms);
      p2 = dp(ss, +ms, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(ss, -ms, +ms);
      p2 = dp(ss, +ms, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(ss, -ms, -ms);
      p2 = dp(ss, -ms, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, ss, -ms);
      p2 = dp(+ms, ss, -ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(+ms, ss, -ms);
      p2 = dp(+ms, ss, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, ss, +ms);
      p2 = dp(+ms, ss, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, ss, -ms);
      p2 = dp(-ms, ss, +ms);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, -ms, ss);
      p2 = dp(+ms, -ms, ss);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(+ms, -ms, ss);
      p2 = dp(+ms, +ms, ss);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, +ms, ss);
      p2 = dp(+ms, +ms, ss);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

      p1 = dp(-ms, -ms, ss);
      p2 = dp(-ms, +ms, ss);
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    }



    int cc = (6*sub*sub)/int(random(10, 20));
    for (int i = 0; i < cc; i++) {
      float xx = map(int(random(sub)), 0, sub, -ms, ms);
      float yy = map(int(random(sub)), 0, sub, -ms, ms);
      float hh = ms*((random(1) < 0.5)? -1 : 1);
      float ss = s/sub;
      int c1 = rcol();
      int c2 = rcol();
      if (random(1) < 0.5) c2 = c1;
      fill(c1, random(100, 220));
      if (random(1) < 1./3) {
        beginShape();
        p1 = dp(xx, yy, hh);
        vertex(p1.x, p1.y, p1.z);
        p1 = dp(xx+ss, yy, hh);
        vertex(p1.x, p1.y, p1.z);
        fill(c2, random(100, 220)); 
        p1 = dp(xx+ss, yy+ss, hh);
        vertex(p1.x, p1.y, p1.z);
        p1 = dp(xx, yy+ss, hh);
        vertex(p1.x, p1.y, p1.z);
        endShape(CLOSE);
      } else {
        if (random(1) < 0.5) {
          beginShape();
          p1 = dp(xx, hh, yy);
          vertex(p1.x, p1.y, p1.z);
          p1 = dp(xx+ss, hh, yy);
          vertex(p1.x, p1.y, p1.z);
          fill(c2, random(100, 220)); 
          p1 = dp(xx+ss, hh, yy+ss);
          vertex(p1.x, p1.y, p1.z);
          p1 = dp(xx, hh, yy+ss);
          vertex(p1.x, p1.y, p1.z);
          endShape(CLOSE);
        } else {
          beginShape();
          p1 = dp(hh, xx, yy);
          vertex(p1.x, p1.y, p1.z);
          p1 = dp(hh, xx+ss, yy);
          vertex(p1.x, p1.y, p1.z);
          fill(c2, random(100, 220)); 
          p1 = dp(hh, xx+ss, yy+ss);
          vertex(p1.x, p1.y, p1.z);
          p1 = dp(hh, xx, yy+ss);
          vertex(p1.x, p1.y, p1.z);
          endShape(CLOSE);
        }
      }
      noFill();
    }
    popMatrix();
  }
}

void bbox(float s) {
  float r = s*0.5;

  PVector p1 = dp(-r, -r, -r);
  PVector p2 = dp(+r, -r, -r);
  PVector p3 = dp(-r, +r, -r);
  PVector p4 = dp(+r, +r, -r);
  PVector p5 = dp(-r, -r, +r);
  PVector p6 = dp(+r, -r, +r);
  PVector p7 = dp(-r, +r, +r);
  PVector p8 = dp(+r, +r, +r);

  line(p1.x, p1.y, p1.z, p5.x, p5.y, p5.z);
  line(p2.x, p2.y, p2.z, p6.x, p6.y, p6.z);
  line(p3.x, p3.y, p3.z, p7.x, p7.y, p7.z);
  line(p4.x, p4.y, p4.z, p8.x, p8.y, p8.z);

  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  line(p2.x, p2.y, p2.z, p4.x, p4.y, p4.z);
  line(p3.x, p3.y, p3.z, p1.x, p1.y, p1.z);
  line(p4.x, p4.y, p4.z, p3.x, p3.y, p3.z);

  line(p5.x, p5.y, p5.z, p6.x, p6.y, p6.z);
  line(p6.x, p6.y, p6.z, p8.x, p8.y, p8.z);
  line(p7.x, p7.y, p7.z, p5.x, p5.y, p5.z);
  line(p8.x, p8.y, p8.z, p7.x, p7.y, p7.z);
}

float deta = 0.01; 
float desa = 1000;
float det = 0.01; 
float des = 1000;
float amp = 100;
float umb = 0.1;
PVector dp(float x, float y, float z) {
  float aa = amp*noise(desa+x*deta, desa+y*deta, desa+z*deta);
  if (aa < umb) aa = 0;
  else umb = map(aa, umb, 1, 0, 1);
  float xx = x+(noise(1000+des+x*det, 100+des+y*det, des+z*det)*2-1)*aa;
  float yy = y+(noise(100+des+x*det, des+y*det, 1000+des+z*det)*2-1)*aa;
  float zz = z+(noise(des+x*det, 1000+des+y*det, 100+des+z*det)*2-1)*aa;
  return new PVector(xx, yy, zz);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#022B53, #FEAB15, #F15B62, #FE0032};
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