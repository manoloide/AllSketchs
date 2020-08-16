void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  background(0);

  /*for (int i = 0; i < 100; i++) {
   circle(random(width), random(height), random(400));
   }*/
  circle(width/2, height/2, width*1.42);
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  float da = random(TWO_PI)*random(1);
  int div = int(random(2, 10));
  int cc = int(s*PI*1./div);
  noStroke();
  for (int i = 0; i < cc; i++) {
    float dd = map(i, 0, cc, 0, r);
    float ss = 160*dd/s;
    for (int j = 0; j < div; j++) {
      fill(((i+j)%2 == 0)? 0 : 255);
      float a = da*i+(TWO_PI/div)*j;
      float xx = x+cos(a)*dd;
      float yy = y+sin(a)*dd;
      //fill(random(255));
      //ellipse(xx, yy, ss, ss);
      tri(xx, yy, a, ss*2);
    }
  }
}

void tri(float x, float y, float a, float ss) {
  beginShape();
  vertex(x, y);
  vertex(x+cos(a-HALF_PI*0.25)*ss, y+sin(a-HALF_PI*0.25)*ss);
  vertex(x+cos(a+HALF_PI*0.25)*ss, y+sin(a+HALF_PI*0.25)*ss);
  endShape(CLOSE);
}