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

  randomSeed(seed);
  noiseSeed(seed);

  background(#000000);

  float time = millis()*0.01;

  float fov = PI/random(1.1, 2.4);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*1000.0);
  translate(width/2, height/2);
  rotateX(random(TWO_PI)+time*random(-0.1, 0.1));
  rotateY(random(TWO_PI)+time*random(-0.1, 0.1));
  rotateZ(random(TWO_PI)+time*random(-0.1, 0.1));

  int cc = int(random(100));

  float size = width*random(2, 5);

  noFill();

  noiseDetail(1);
  float des = random(1000)+time*random(-0.1, 0.1)*random(1);
  float det = random(.01);

  for (int i = 0; i < cc; i++) {
    float dep = random(-3, 3)*width;
    float r1 = size*0.5*noise(des+det*dep);//size*random(1)*random(1)*0.5;
    float r2 = r1*random(random(random(0.1, 0.9), 0.96), 1);
    int rnd = int(random(8));
    color col = rcol();
    pushMatrix();
    translate(0, 0, dep);

    noFill();
    stroke(col, random(120, 230));
    if (rnd == 0) {
      ellipse(0, 0, r1*2, r1*2);
    }
    strokeWeight(1.2);
    if (rnd == 1) {
      int sub = int(random(4, random(random(320))));
      float ang = random(TWO_PI)+time*random(-0.1, 0.1)*random(1);
      float da = TWO_PI/sub;
      for (int j = 0; j < sub; j++) {
        float a = ang+da*j;
        line(cos(a)*r1, sin(a)*r1, cos(a)*r2, sin(a)*r2);
        point(cos(a)*r1, sin(a)*r1, 0);
      }
    }
    if (rnd == 3) {
      float amp = r1*random(0.1)*random(0.2, 1);
      int sub = int(random(4, random(random(320))));
      float ang = random(TWO_PI)+time*random(-0.1, 0.1)*random(1);
      float da = TWO_PI/sub;
      for (int j = 0; j < sub; j++) {
        float a = ang+da*j;
        line(cos(a)*r1, sin(a)*r1, -amp, cos(a)*r1, sin(a)*r1, amp);
      }
    }
    if (rnd == 4) {
      noStroke();
      fill(col, random(random(100, 255), 255));
      int c = int(random(2, 12));
      float da = TWO_PI/c;
      float ang = random(TWO_PI);
      float amp = r1*random(0.04);
      int form = int(random(2));
      for (int j = 0; j < c; j++) {
        float a = da*j+ang;
        if (form == 0) {
          beginShape();
          vertex(cos(a)*(r1+amp), sin(a)*(r1+amp));
          vertex(cos(a)*r1+cos(a+HALF_PI)*amp, sin(a)*r1+sin(a+HALF_PI)*amp);
          vertex(cos(a)*r1-cos(a+HALF_PI)*amp, sin(a)*r1-sin(a+HALF_PI)*amp);
          endShape(CLOSE);
        }
        if (form == 1) {
          ellipse(cos(a)*r1, sin(a)*r1, amp, amp);
        }
      }
    }
    if (rnd == 5) {
      int c = int(random(2, 12));
      float da = PI/c;
      float ang = random(TWO_PI);
      float amp = r1*random(1, 1.2);
      for (int j = 0; j < c; j++) {
        float a = da*j+ang;
        line(cos(a)*amp, sin(a)*amp, cos(a+PI)*amp, sin(a+PI)*amp);
      }
    }
    popMatrix();
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF5949, #FFC956, #1CEA64, #53EFF4};
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