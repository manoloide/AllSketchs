int seed = int(random(999999));

void setup() {
  size(3250, 3250, P3D);
  smooth(2);
  pixelDensity(2);
  generate();
  saveImage();
  
  exit();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

int back;
void generate() {
  back = rcol();
  background(back);


  float fov = PI/random(2.6, 3.6);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);
  translate(width/2, height/2);
  //lights();
  float s = width*2;
  noStroke();
  float des = random(10000);
  float det = random(0.01);
  float det2 = random(0.005)*random(0.3, 1);
  float des1 = random(10000000);
  float des2 = random(10000000);
  float des3 = random(10000000);
  int cc = int(random(20, 200));
  float pwr = random(1, 2);
  if (random(1) < 0.5) pwr = random(0.5, 1);
  for (int i = 0; i < cc; i++) {
    float xx = random(-s, s);
    float yy = random(-s, s);
    float zz = random(-s*1.2, 0);
    float noi = noise(des+xx*det, des+yy*det, des+zz*det);
    if (noi < 0.4) continue;
    else noi = pow(map(noi, 0.4, 1, 0, 1), pwr);
    pushMatrix();
    translate(xx, yy, zz);
    rotateX(noise(des1+xx*det2, des1+yy*det2, des1+zz*det2)*TAU*2);
    rotateY(noise(des2+xx*det2, des2+yy*det2, des2+zz*det2)*TAU*2);
    rotateZ(noise(des3+xx*det2, des3+yy*det2, des3+zz*det2)*TAU*2);
    float ss = width*1.2*noi*random(0.8, 1);
    float hh = ss*1.2;
    cono(ss, hh);
    popMatrix();
  }
}

void cono(float s, float h) {
  float r = s*0.5;
  float mh = h*0.5;
  int res = int(max(4, r*PI*2));
  float da = TAU/res;
  int c1 = rcol();
  while (c1 == back) c1 = rcol();
  int c2 = rcol();
  while (c2 == c1 || c2 == back) c2 = rcol();
  fill(c1);
  for (int i = 0; i < res; i++) {
    float a = da*i;
    beginShape();
    vertex(cos(a)*r, sin(a)*r, -mh);
    vertex(cos(a+da)*r, sin(a+da)*r, -mh);
    vertex(0, 0, +mh);
    endShape(CLOSE);
  }

  fill(c2);
  for (int i = 0; i < res; i++) {
    float a = da*i;
    beginShape();
    vertex(cos(a)*r, sin(a)*r, -mh);
    vertex(cos(a+da)*r, sin(a+da)*r, -mh);
    vertex(0, 0, -mh);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FACC02, #FB0603, #0365BC, #0D6305, #000000, #FFFFFF};
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