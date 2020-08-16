boolean save = false;

int seed = int(random(9999999));

PFont font;
PShader post;
float millis = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(60);

  float fov = PI/2 ;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  post = loadShader("data/post.glsl");
  post.set("iResolution", float(width), float(height));

  font = createFont("Stockholm Mono", 16, true);
}

void draw() {
  if (frameCount%120 == 0) {
    seed = int(random(9999999));
  }
  millis += frameCount/60.;
  post.set("iGlobalTime", millis);
  randomSeed(seed);
  background(10);

  randomMovementAnimation(1, 8);
  pushMatrix();
  translate(width/2, height/2, -100);
  randomRotationAnimation(0.5);
  stroke(255);
  noFill();
  int cc = int(random(5, 22));
  for (int i = 0; i < cc; i++) {
    pushMatrix();
    //randomRotation();
    randomRotationRect();
    //randomRotationAnimation(0.1);
    strokeWeight(1);
    float d = height*random(0.3, 0.45);
    int t = int(random(8));
    if (t == 0) circle(d, random(1, 4));
    if (t == 1) arc1(d, random(TWO_PI), random(TWO_PI), random(1, 4));
    if (t == 2) arcConect(d, random(TWO_PI), random(TWO_PI), int(random(1, 10)));
    if (t == 3) circleLines(d, int(random(3, 60)), random(8, 20));
    if (t == 4) circleLines(d, int(random(3, 20)), int(random(2, 9)), random(8, 20), random(2, 10)*random(1));
    if (t == 5) arc2(d, int(random(2, 10)), random(0.1, 0.9), 1);
    if (t == 6) arcDouble(d, int(random(2, 10)), random(0.1, 0.9), 0.5, random(2, 10));
    if (t == 7) lineDot(d*1.5, int(random(4, 20)), random(0.1, 0.8));
    popMatrix();
  }
  popMatrix(); 


  pushMatrix();
  translate(width+100, height/2);
  strokeWeight(1);
  for (int i = -50; i <= 50; i++) {
    float x = 0;
    float y = i*6;
    noStroke();
    fill(255);
    rect(x, y, 4, 4);
    if (i%2 == 0) {
      rect(x-6, y, 4, 4);
    }
    if (i%5 == 0) {
      stroke(255);
      line(x+14, y+2, x+28, y+2);
    }
  }
  popMatrix();

  textFont(font);
  fill(255);
  //text("process...", 40, 40);
  text(seed+"s", -140, -140);
  filter(post);

  if (save) {
    if (frameCount%2 == 0) saveFrame("export/#####.png");
    if (frameCount > 60*60) {
      exit();
    }
  }
}

void keyPressed() {
  seed = int(random(9999999));
}

void randomMovementAnimation(float mov, float amp) {
  translate(noise(millis()*0.003*mov)*amp-amp/2, noise(millis*0.003*mov+40)*amp-amp/2, noise(67+millis*0.003*mov)*amp-amp/2);
}

void randomRotationAnimation(float vel) {
  rotateX(random(-0.003, 0.003)*millis*random(vel));
  rotateY(random(-0.003, 0.003)*millis*random(vel));
  rotateZ(random(-0.003, 0.003)*millis*random(vel));
}

void randomRotation() {
  rotateX(random(TWO_PI));
  rotateY(random(TWO_PI));
  rotateZ(random(TWO_PI));
}

void randomRotationRect() {
  int m = (random(1) < 0.01)? 2 : 4;
  m = 2;
  rotateX((PI/m)*int(random(m*2)));
  rotateY((PI/m)*int(random(m*2)));
  rotateZ((PI/m)*int(random(m*2)));
}

void circle(float r, float s) {
  strokeWeight(s);
  ellipse(0, 0, r*2, r*2);
}

void arc1(float r, float a1, float a2, float s) {
  strokeWeight(s);
  arc(0, 0, r*2, r*2, a1, a2);
}

void arc2(float r, int c, float a, float s) {
  strokeWeight(s);
  float da = TWO_PI/c;
  for (int i = 0; i < c; i++) {
    arc(0, 0, r*2, r*2, da*i, da*(i+a));
  }
}

void arcDouble(float r, int c, float a, float s, float d) {
  strokeWeight(s);
  float da = TWO_PI/c;
  for (int i = 0; i < c; i++) {
    arc(0, 0, r*2, r*2, da*i, da*(i+a));
    arc(0, 0, (r+d)*2, (r+d)*2, da*i, da*(i+a));
  }
}

void arcConect(float r, float a1, float a2, int c) {
  float da = (a2-a1)/c; 
  for (int i = 0; i < c; i++) {
    if (i > 0) 
      line(cos(a1+da*(i-1))*r, sin(a1+da*(i-1))*r, 0, cos(a1+da*i)*r, sin(a1+da*i)*r, 0);
    line(0, 0, 0, cos(a1+da*i)*r, sin(a1+da*i)*r, 0);
  }
}

void circleLines(float r, int c, float l) {
  float da = TWO_PI/c; 
  for (int i = 0; i < c; i++) {
    line(cos(da*i)*r, sin(da*i)*r, -l, cos(da*i)*r, sin(da*i)*r, l);
  }
}

void circleLines(float r, int c, int ic, float l, float il) {
  int cc = (c*ic);
  float da = TWO_PI/cc; 
  for (int i = 0; i < cc; i++) {
    float ll = (i%ic == 0)? l : il;
    line(cos(da*i)*r, sin(da*i)*r, -ll, cos(da*i)*r, sin(da*i)*r, ll);
  }
}

void lineDot(float r, int c, float a) {
  float d = r/c;
  float lar = d*a; 
  for (int i = 0; i < c; i++) {
    line(i*d, 0, 0, i*d+lar, 0, 0);
  }
}

void lineIndicador(float r, String txt) {
  line(0, 0, 0, r, r, 0);
  text(txt, r+10, r, 0);
}

