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

  seed = int(random(999999));
  background(rcol());
  lights();
  translate(width/2, height/2);
  for (int i = 0; i < 100; i++) {
    float x = random(width)-width*0.5;
    float y = random(height)-height*0.5;
    float z = random(height);
    float s = random(10, 80);
    float dz = s*random(0.8);
    float r = s*random(10, 100);
    float ang = random(TWO_PI);
    float da = PI*random(0.01, 0.05);
    noStroke();
    int cc = int(random(40, 280));
    for (int j = 0; j < cc; j++) {
      pushMatrix();
      translate(x+cos(ang+da*j)*r, y+dz*(j-cc*0.5), z+sin(ang+da*j)*r);
      fill(rcol());
      box(s*0.25, s, s*0.25);
      popMatrix();
    }
  }

  for (int i = 0; i < 100; i++) {

    float x = random(width)-width*0.5;
    float y = random(height)-height*0.5;
    float z = random(height);
    pushMatrix();
    translate(x, y, z);
    fill(rcol());
    sphere(random(1, 20));
    popMatrix();
  }
}

//https://coolors.co/220760-552684-aa203c-f47d3d-e2e54b
//int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
int colors[] = {#220760, #552684, #AA203C, #F47D3D, #E2E54B, #5EEDDA};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}