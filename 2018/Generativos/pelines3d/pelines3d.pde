import peasy.PeasyCam;
int seed = int(random(9999999));

PeasyCam cam;
void setup() {
  size(960, 540, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
}

void draw() {

  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  
  blendMode(ADD);

  int cc = 8; 
  float ss = width*1./cc;
  float det = random(0.001);
  stroke(255, 80);
  translate(-ss*cc*0.5, -ss*cc*0.5, -ss*cc*0.5);
  float des1 = random(10000);
  float des2 = random(10000);
  /*
  float rr = ss*0.2;
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        float xx = ss*i;
        float yy = ss*j;
        float zz = ss+k;
        float a1 = noise(des1+xx*det, des1+yy*det, des1+zz*det)*TAU*4;
        float a2 = noise(des2+xx*det, des2+yy*det, des2+zz*det)*TAU*4;
        pushMatrix();
        translate(ss*i, ss*j, ss*k); 
        point(0, 0, 0);
        line(0, 0, 0, cos(a1)*cos(a2)*rr, cos(a1)*sin(a2)*rr, sin(a1)*rr);
        popMatrix();
      }
    }
  }
  */

  noFill();
  stroke(250, 20, 0, 80);
  float vel = 10;
  float detColor = random(0.001);
  for (int i = 0; i < 500; i++) {
    float xx = int(random(cc))*ss;
    float yy = int(random(cc))*ss;
    float zz = int(random(cc))*ss; 
    beginShape();
    vertex(xx, yy, zz);
    for (int j = 0; j < 100; j++) {
      float a1 = noise(des1+xx*det, des1+yy*det, des1+zz*det)*TAU*4;
      float a2 = noise(des2+xx*det, des2+yy*det, des2+zz*det)*TAU*4;
      xx += cos(a1)*cos(a2)*vel;
      yy += cos(a1)*sin(a2)*vel;
      zz += sin(a1)*vel;
      stroke(getColor(noise(xx*detColor, yy*detColor, zz*detColor)*colors.length*2));
      vertex(xx, yy, zz);
    }
    endShape();
  }
}

void keyPressed() {
  seed = int(random(9999999));
}
int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
