int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
    seed = int(random(999999));
  randomSeed(seed);
  background(getColor());
  translate(width*0.5, height*0.5);
  rotateX(random(-0.4, 0.4));
  rotateY(random(-0.4, 0.4));
  rotateZ(random(-0.4, 0.4));
  int cc = int(random(20, 100));
  float des = width*1.2;
  float ss = des*2/cc;
  float ck = int(random(1, random(1, 40)));
  stroke(0, 20);
  for (int k = 0; k < ck; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        float xx = map(i, 0, cc, -des, des);
        float yy = map(j, 0, cc, -des, des);
        pushMatrix();
        translate(xx, yy, k*5);
        fill(getColor());
        float s = map(k, 0, ck, ss, 0);
        ellipse(0, 0, s, s);
        popMatrix();
      }
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};
int colors[] = {#AECDEC, #D098F9, #3A3569, #FFC300, #FD3537};
//int colors[] = {#F97EB2, #EFDB01, #018FD8, #6EB201, #F92F23, #F9F6FA, #783391};
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