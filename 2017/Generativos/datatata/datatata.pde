int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  //lights();
  seed = int(random(999999));
  background(0);//getColor(random(colors.length*2)));

  float fov = PI/random(1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);


  translate(width/2, height/2);

  for (int k = 0; k < 5; k++) {
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));

    int cc = 200; 
    float r = width*random(1, 2);
    float rr = r*random(0.8, 1);
    float da = TWO_PI/cc;
    noStroke();
    strokeWeight(2);
    noFill();

    for (int i = 0; i < cc; i++) {
      float ang = da*i;
      float xx = cos(ang)*r; 
      float yy = sin(ang)*r;
      //stroke(getColor(random(colors.length*2)));
      pushMatrix();
      translate(xx, yy);
      rotateZ(ang);
      rotateX(PI*0.5);
      //ellipse(0, 0, rr, rr);
      circle(rr, random(1, 4));
      popMatrix();
    }
  }
}

void circle(float s, float a) {
  float r = s*0.5;
  int res = 360; 
  float da = TWO_PI/res;
  for (int i = 0; i < res; i++) {
    float a1 = da*i;
    float a2 = da*(i+1);
    fill(int(random(2))*255);
    //fill(rcol());
    beginShape();
    vertex(cos(a1)*r, sin(a1)*r, a);
    vertex(cos(a1)*r, sin(a1)*r, -a);
    vertex(cos(a2)*r, sin(a2)*r, -a);
    vertex(cos(a2)*r, sin(a2)*r, a);
    endShape(CLOSE);
  }
}


int colors[] = {#ECEAA4, #6D1E0A, #EF402C, #004500, #C7E969, #000000};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}