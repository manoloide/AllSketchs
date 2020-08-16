
void setup() {
  size(960, 960, P3D);
  smooth(8);
  generate();
}

void draw() {
  if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

int type;

void generate() {
  background(0);

  float fov = PI/random(2, 5);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  type = int(random(1.2));
  translate(width/2, height/2, 0);
  fill(0);
  stroke(255, 200);
  int c = int(random(10, 100*random(1)));
  for (int i = 0; i < c; i++) {
    pushMatrix();
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));
    int cc = 1;//int(random(1, 9));
    float da = PI/cc;
    float d = random(width*1.2);
    float s = random(4, random(8, 12));
    int res = 256;
    for (int j = 0; j < cc; j++) {
      rotateY(da);
      circle(d, s, res);
    }
    popMatrix();
  }
}

void circle(float d, float s, int res) {
  float r = d*0.5;
  float ms = s*0.5;
  float da = TWO_PI/res;
  for (int i = 0; i < res; i++) {
    float a1 = da*i;
    float a2 = da*(i+1);
    if (type == 1) {
      noStroke();
      fill(0);
      if (i%4 == 0) fill(255);
    }

    beginShape();
    vertex(cos(a1)*r, sin(a1)*r, -ms);
    vertex(cos(a1)*r, sin(a1)*r, ms);
    vertex(cos(a2)*r, sin(a2)*r, ms);
    vertex(cos(a2)*r, sin(a2)*r, -ms);
    endShape(CLOSE);

    //line(cos(a1)*r, sin(a1)*r, -ms, cos(a1)*r, sin(a1)*r, ms);
  }
}