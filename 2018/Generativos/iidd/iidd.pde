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
  //if (frameCount%40 == 0) generate();
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

  float time = millis()*0.001;
  time += cos(time)*0.5;
  randomSeed(seed);

  //background(4);

  //ortho();
  translate(width*0.5, height*0.5);
  //rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateZ(-HALF_PI*0.5+time);

  //lights();

  stroke(0, 20);
  for (int i = 0; i < 100; i++) {
    pushMatrix();
    rotateX(time*random(-1, 1));
    rotateY(time*random(-1, 1));
    rotateZ(time*random(-1, 1));
    translate(random(-width, width), random(-width, width), random(-width, width));
    float min = random(40);
    float max = random(120);
    shape1(map(cos(time*random(0.6)), -1, 1, min, max));
    popMatrix();
  }
}

void shape1(float s) {
  float r = s*0.5;

  fill(rcol());

  beginShape();
  vertex(-r, 0, -r);
  vertex(0, -r, -r);
  vertex(-r, -r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(-r, 0, -r);
  vertex(0, +r, -r);
  vertex(-r, +r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(+r, 0, -r);
  vertex(0, +r, -r);
  vertex(+r, +r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(+r, 0, -r);
  vertex(0, -r, -r);
  vertex(+r, -r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(-r, 0, +r);
  vertex(0, -r, +r);
  vertex(-r, -r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(-r, 0, +r);
  vertex(0, +r, +r);
  vertex(-r, +r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(+r, 0, +r);
  vertex(0, +r, +r);
  vertex(+r, +r, 0);
  endShape(CLOSE);

  beginShape();
  vertex(+r, 0, +r);
  vertex(0, -r, +r);
  vertex(+r, -r, 0);
  endShape(CLOSE);


  fill(rcol());

  beginShape();
  vertex(-r, 0, -r);
  vertex(0, -r, -r);
  vertex(r, 0, -r);
  vertex(0, r, -r);
  endShape(CLOSE);
  beginShape();

  vertex(-r, 0, r);
  vertex(0, -r, r);
  vertex(r, 0, r);
  vertex(0, r, r);
  endShape(CLOSE);


  beginShape();
  vertex(-r, -r, 0);
  vertex(0, -r, -r);
  vertex(r, -r, 0);
  vertex(0, -r, r);
  endShape(CLOSE);
  beginShape();

  vertex(-r, r, 0);
  vertex(0, r, -r);
  vertex(r, r, 0);
  vertex(0, r, r);
  endShape(CLOSE);

  beginShape();
  vertex(-r, -r, 0);
  vertex(-r, 0, -r);
  vertex(-r, r, 0);
  vertex(-r, 0, r);
  endShape(CLOSE);
  beginShape();

  beginShape();
  vertex(+r, -r, 0);
  vertex(+r, 0, -r);
  vertex(+r, r, 0);
  vertex(+r, 0, r);
  endShape(CLOSE);
  beginShape();
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};
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