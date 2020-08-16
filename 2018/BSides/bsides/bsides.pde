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
    box(s, s, s);

    int sub = int(random(1, random(1, 5)));
    float ms = s*0.5;
    for (int i = 1; i < sub; i++) {
      float ss = map(i, 0, sub, -ms, ms);
      line(ss, -ms, -ms, ss, +ms, -ms);
      line(ss, +ms, -ms, ss, +ms, +ms);
      line(ss, -ms, +ms, ss, +ms, +ms);
      line(ss, -ms, -ms, ss, -ms, +ms);

      line(-ms, ss, -ms, +ms, ss, -ms);
      line(+ms, ss, -ms, +ms, ss, +ms);
      line(-ms, ss, +ms, +ms, ss, +ms);
      line(-ms, ss, -ms, -ms, ss, +ms);

      line(-ms, -ms, ss, +ms, -ms, ss);
      line(+ms, -ms, ss, +ms, +ms, ss);
      line(-ms, +ms, ss, +ms, +ms, ss);
      line(-ms, -ms, ss, -ms, +ms, ss);
    }

    int cc = (6*sub*sub)/int(random(10, 20));
    for (int i = 0; i < cc; i++) {
      float xx = map(int(random(sub)), 0, sub, -ms, ms);
      float yy = map(int(random(sub)), 0, sub, -ms, ms);
      float hh = ms*((random(1) < 0.5)? -1 : 1);
      float ss = s/sub;
      fill(rcol(), random(100, 220));
      if (random(1) < 1./3) {
        beginShape();
        vertex(xx, yy, hh);
        vertex(xx+ss, yy, hh);
        vertex(xx+ss, yy+ss, hh);
        vertex(xx, yy+ss, hh);
        endShape(CLOSE);
      } else {
        if (random(1) < 0.5) {
          beginShape();
          vertex(xx, hh, yy);
          vertex(xx+ss, hh, yy);
          vertex(xx+ss, hh, yy+ss);
          vertex(xx, hh, yy+ss);
          endShape(CLOSE);
        } else {
          beginShape();
          vertex(hh, xx, yy);
          vertex(hh, xx+ss, yy);
          vertex(hh, xx+ss, yy+ss);
          vertex(hh, xx, yy+ss);
          endShape(CLOSE);
        }
      }
      noFill();
    }

    popMatrix();
  }
}

void generate() {
  background(#01131B);
  randomSeed(seed);

  blendMode(ADD);
  stroke(rcol(), 100);

  //lights();

  float len = random(1, random(1, 4));
  float fov = PI/len;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float  (height), 
    cameraZ/100.0, cameraZ*1000.0);

  translate(width/2, height/2);
  float maxRot = random(0.3);
  rotateX(random(-maxRot, maxRot));
  rotateY(random(-maxRot, maxRot));
  rotateZ(random(TAU));

  float maxSize = width*map(pow(map(len, 1, 4, 0, 1), 1.2), 0, 1, 50, 4);
  maxSize = width*2;

  ArrayList<Box> rects = new ArrayList<Box>();
  rects.add(new Box(0, 0, 0, maxSize));
  int sub = int(random(2, 5));
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

    //rects.remove(ind);
  }
  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Box b = rects.get(i);
    b.show();
  }
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