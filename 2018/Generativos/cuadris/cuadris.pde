int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
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
  background(getColor(random(10)));

  float fov = PI/random(2.2, 3.0);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  float size = 500;

  stroke(0, 20);
  strokeWeight(0.5);

  scale(1.2);

  for (int i = 0; i < 640; i++) {
    pushMatrix();
    rotateX((TAU/4)*int(random(8)));
    rotateY((TAU/4)*int(random(8)));
    rotateZ((TAU/4)*int(random(8)));
    translate(random(-size, size), random(-size, size), random(-size, size));
    float w = random(10, 80);
    float h = random(10, 80);
    float d = random(10, 80);
    fill(getColor());
    boxGrid(w, h, d, int(random(4, 19)), int(random(4, 19)), int(random(4, 19)), 0.2);
    popMatrix();
  }
  for (int i = 0; i < 640; i++) {
    pushMatrix();
    rotateX((TAU/4)*int(random(8)));
    rotateY((TAU/4)*int(random(8)));
    rotateZ((TAU/4)*int(random(8)));
    translate(random(-size, size), random(-size, size), random(-size, size));
    float w = random(10, 80);
    float h = random(10, 80);
    float d = random(10, 80);
    fill(getColor());
    box(w*20, h*0.02, d*0.02);
    popMatrix();
  }
  for (int i = 0; i < 6400; i++) {
    pushMatrix();
    rotateX((TAU/4)*int(random(8)));
    rotateY((TAU/4)*int(random(8)));
    rotateZ((TAU/4)*int(random(8)));
    translate(random(-size, size), random(-size, size), random(-size, size));
    float w = random(10, 80);
    float h = random(10, 80);
    float d = random(10, 80);
    fill(getColor());
    box(w*0.04, h*0.04, d*0.04);
    popMatrix();
  }
}

void boxGrid(float w, float h, float d, int cw, int ch, int cd, float bb) {
  float sw = w*1./cw;
  float sh = h*1./ch; 
  float sd = d*1./cd;
  float det = random(0.01);
  float des = random(1000);
  int c1 = getColor();
  int c2 = getColor();
  for (int k = 0; k < cd; k++) {
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {

        if ((i+j+k)%2 == 0) fill(c1);
        else fill(c2);

        pushMatrix();
        float dx = -w*0.5+(i+0.5)*sw;
        float dy = -h*0.5+(j+0.5)*sh;
        float dz = -d*0.5+(k+0.5)*sd;
        translate(dx, dy, dz);
        //fill(getColor(noise(des+dx*det, des+dy*det)*colors.length));
        box(sw-bb, sh-bb, sd-bb);
        popMatrix();
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F4D3DE, #E04728, #F7B63D, #3F9686, #313168};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
