int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
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

void generate() {

  background(0);


  float fov = PI/random(1.02, 1.3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2, 0);
  float mr = HALF_PI*0.12;
  rotateX(random(-mr, mr));
  rotateY(random(-mr, mr));
  rotateZ(random(TWO_PI));

  float ss = width*random(0.2, 0.8);

  float hh = width;
  float h2 = ss*0.006;
  noStroke();

  ambientLight(60, 60, 60);
  pointLight(200, 200, 200, 0, 0, hh*0.5);

  pointLight(80, 80, 80, 0, 0, hh);

  rectMode(CENTER);
  fill(getColor());

  rect(0, 0, ss, ss);
  rect(-ss, 0, ss, ss);
  rect(ss, 0, ss, ss);
  rect(0, ss, ss, ss);
  rect(0, -ss, ss, ss);

  fill(getColor());
  rect(0, 0, ss*0.6, ss*0.6);
  ellipse(-ss, 0, ss*0.2, ss*0.2);
  ellipse(ss, 0, ss*0.2, ss*0.2);
  ellipse(0, ss, ss*0.2, ss*0.2);
  ellipse(0, -ss, ss*0.2, ss*0.2);


  fill(getColor());

  box(-ss*1.5, -ss*1.5, hh*0.5, ss*1.4, ss*1.4, hh);
  box(+ss*1.5, -ss*1.5, hh*0.5, ss*1.4, ss*1.4, hh);
  box(+ss*1.5, +ss*1.5, hh*0.5, ss*1.4, ss*1.4, hh);
  box(-ss*1.5, +ss*1.5, hh*0.5, ss*1.4, ss*1.4, hh);

  box(-ss*2.5, -ss*0.0, hh*0.5, ss*1.4, ss*2, hh);
  box(+ss*2.5, -ss*0.0, hh*0.5, ss*1.4, ss*2, hh);
  box(+ss*0.0, -ss*2.5, hh*0.5, ss*2, ss*1.4, hh);
  box(-ss*0.0, +ss*2.5, hh*0.5, ss*2, ss*1.4, hh);

  box(-ss*0.54, -ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*0.54, -ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*0.54, +ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(-ss*0.54, +ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);

  box(-ss*0.54, -ss*1.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*0.54, -ss*1.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*0.54, +ss*1.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(-ss*0.54, +ss*1.54, hh*0.5, ss*0.1, ss*0.1, hh);

  box(-ss*1.54, -ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*1.54, -ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(+ss*1.54, +ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);
  box(-ss*1.54, +ss*0.54, hh*0.5, ss*0.1, ss*0.1, hh);

  float dd = ss*0.06;
  int cc = 80;
  for (int i = 0; i < cc; i++) {
    float hhh = dd*i-h2;
    fill(getColor());
    box(-ss*2.5, -ss*0.0, hhh, ss*2, ss*2, h2);
    box(+ss*2.5, -ss*0.0, hhh, ss*2, ss*2, h2);
    box(+ss*0.0, -ss*2.5, hhh, ss*2, ss*2, h2);
    box(-ss*0.0, +ss*2.5, hhh, ss*2, ss*2, h2);


    box(-ss*1.5, -ss*1.5, hhh, ss*2, ss*2, h2);
    box(+ss*1.5, -ss*1.5, hhh, ss*2, ss*2, h2);
    box(+ss*1.5, +ss*1.5, hhh, ss*2, ss*2, h2);
    box(-ss*1.5, +ss*1.5, hhh, ss*2, ss*2, h2);
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void box(float x, float y, float z, float w, float h, float d) {
  pushMatrix();
  translate(x, y, z);
  box(w, h, d);
  popMatrix();
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#272928, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3};
//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
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
