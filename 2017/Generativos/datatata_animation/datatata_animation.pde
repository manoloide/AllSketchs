int seed = 4;//int(random(999999));

void setup() {
  size(960, 540, P3D);
  smooth(8);
  frameRate(30);
  pixelDensity(2);
}

void draw() {
  if (frameCount%120 == 0) generate();
  render();
  if (frameCount > 30*60) exit();
  if(false) saveFrame("export/f####.png");
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
  seed = int(random(999999));
}

void render() {
  //lights();
  randomSeed(seed);
  background(0);//getColor(random(colors.length*2)));

  pushMatrix();
  float fov = PI/random(1.1, 2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);


  translate(width/2, height/2);

  for (int k = 0; k < 4; k++) {
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));

    int cc = 200; 
    float r = height*random(1, 2);
    float rr = r*random(0.8, 1);
    float da = TWO_PI/cc;
    noStroke();
    strokeWeight(2);
    noFill();

    float ang, xx, yy;
    for (int i = 0; i < cc; i++) {
      ang = da*i;
      xx = cos(ang)*r; 
      yy = sin(ang)*r;
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
  popMatrix();
}

void circle(float s, float a) {
  float r = s*0.5;
  int res = 360; 
  float da = TWO_PI/res;
  float ang = frameCount*random(-0.05, 0.05);
  float max = random(0.6, 1);
  float a1, a2;
  for (int i = 0; i < res; i++) {
    a1 = ang+da*i;
    a2 = ang+da*(i+1);
    //fill(int(random(2))*255);
    fill(255);
    if (random(1) < max) continue;
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