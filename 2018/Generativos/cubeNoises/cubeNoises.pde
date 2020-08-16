int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
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
  background(rcol());
  lights();

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(200));
  for (int j = 0; j < sub; j++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    //fill(rcol());
    //rect(r.x, r.y, r.z, r.z);
    cube(r.x+r.z*0.5, r.y+r.z*0.5, r.z*random(0.4, 0.5));
  }
}

void cube(float xx, float yy, float ss) {
  pushMatrix();
  translate(xx, yy);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));


  float det = random(0.01);
  float des = random(100000);
  float detc = random(0.01);
  float desc = random(10000);
  float size = ss*0.5;
  int cc = int(pow(ss, 3)*2);
  stroke(rcol(), 80);
  for (int i = 0; i < cc; i++) {
    float x = random(-size, size);
    float y = random(-size, size);
    float z = random(-size, size);
    stroke(getColor(noise(desc+x*detc, desc+y*detc, desc+z*detc)*colors.length*2));
    if (n(x, y, z, det, des) <  0.8) point(x, y, z);
  }
  popMatrix();
}

float n(float x, float y, float z, float det, float des) {
  return noise(des+x*det, des+y*det, des+z*det);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#A8B4CE, #5C6697, #352B4D, #ED5A67, #F389A0};
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