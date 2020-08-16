int seed = int(random(999999));

void setup() {
  size(3250, 3250, P3D);
  smooth(2);
  pixelDensity(2);
  for (int i = 0; i < 10; i++) {
    generate();
    saveImage();
  }
  exit();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
  seed = int(random(999999));

  int back = rcol();
  int grid = rcol();
  while (grid == back) grid = rcol();

  background(back);
  randomSeed(seed);


  //lights();
  pushMatrix();

  fill(grid, random(220, 256));
  int cc = int(random(20, random(20, 100)));
  float ss = width*1./cc;
  rectMode(CENTER);
  noStroke();
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      rect(ss*i, ss*j, width*0.002, width*0.002);
    }
  }

  fill(rcol());
  translate(width/2, height/2, 0);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  //planet(width*random(0.1, 0.4));


  float size = width*0.83;
  int c = int(random(40)*random(1));
  for (int i = 0; i < c; i++) {
    float a1 = random(TAU);
    float a2 = random(TAU);
    float r = size*0.5;
    float x = sin(a1)*cos(a2)*r;
    float y = sin(a1)*sin(a2)*r;
    float z = cos(a1)*r;
    float s = size*random(0.4)*random(1);
    pushMatrix();
    translate(x, y, z);
    planet(s);
    popMatrix();
  }


  stroke(rcol(), 100);
  float des = random(10000);
  float det = random(0.01)*random(1);
  float min = -random(random(1, 2));
  float max = random(0.6, 1);
  float sss = width*random(0.018, 0.031);
  float desc = random(10000);
  float detc = random(0.01);
  for (int i = 0; i < 10000; i++) {
    float x = random(-size, size);
    float y = random(-size, size);
    float z = random(-size, size);
    float n = map(noise(des+x*det, des+y*det, des+z*det), 0, 1, min, max);
    if (n < 0) continue;
    float s = n*sss;
    pushMatrix();
    translate(x, y, z);
    fill(getColor(noise(desc+x*detc, desc+y*detc, desc+z*detc)*colors.length*2));
    box(s);
    line(-s, 0, 0, s, 0, 0);
    line(0, -s, 0, 0, s, 0);
    line(0, 0, -s, 0, 0, s);
    popMatrix();
  }
  popMatrix();
}

void planet(float s) {

  float ps = random(0.4, 0.8);

  int c1 = rcol();
  int c2 = rcol();
  while (c1 == c2) c2 = rcol();

  noStroke();
  fill(c1);
  sphere(s*ps);

  float des = random(10000);
  float det = random(2, 10);
  float desc = random(10000);
  float detc = random(0.4, 4);
  float s1 = s*ps;
  float s2 = s;
  float min = random(0.2, 0.4);
  stroke(rcol());
  for (int j = 0; j < 100000; j++) {
    float theta = random(TAU);
    float phi = acos(random(-1, 1));
    float x = sin(phi)*cos(theta);
    float y = sin(phi)*sin(theta);
    float z = cos(phi);
    float n = noise(des+x*det, des+y*det, des+z*det);
    if (n < min) continue;
    float nc = noise(desc+x*detc, desc+y*detc, desc+z*detc)*colors.length*2;
    stroke(getColor(nc), 220);
    float ss = map(n, min, 1, s1, s2);
    line(x*s1, y*s1, z*s1, x*ss, y*ss, z*ss);// x*s2, y*s2, z*s2);
  }

  stroke(c2);
  int cc = int(random(2, random(4, 20)));
  for (int i = 0; i < cc; i++) {
    stroke(rcol());
    noFill();
    strokeWeight(random(0.5, 2));
    pushMatrix();
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));

    float ss = s*random(ps, 1);
    int rnd = int(random(3.5));

    if (rnd == 0)ellipse(0, 0, ss*2, ss*2);
    if (rnd == 1) {
      int ccc = int(random(3, 80));
      float da = TAU/ccc;
      float ang = random(TAU);
      float amp = random(0.1, 0.9);
      for (int j = 0; j < ccc; j++) {
        arc(0, 0, ss*2, ss*2, ang+da*j, ang+(da*(j+amp)));
      }
    }
    if (rnd == 2) {
      int ccc = int(random(3, 40));
      float da = TAU/ccc;
      float ang = random(TAU);
      float amp = random(0.008, 0.04);
      for (int j = 0; j < ccc; j++) {
        float xx = cos(ang+da*j)*ss;
        float yy = sin(ang+da*j)*ss;
        line(xx, yy, ss*amp, xx, yy, -ss*amp);
      }
    }
    if (rnd == 3) {
      line(0, 0, 0, 0, 0, ss);
    }
    popMatrix();
  }

  strokeWeight(1);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#64CD8B, #D5FF45, #717171, #092CC8, #000000, #FFFFFF};
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