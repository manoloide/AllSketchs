int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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

  int div = int(random(4, random(8, 120)));
  float ss = height/div;
  float det = random(0.01);
  float des = random(10000);
  float amp = random(1, 8);
  float umbral = 0;//random(0.8)*random(0.4, 1);
  noiseDetail(2);
  noStroke();
  int c1 = color(0);
  int c2 = color(255);
  for (int j = int(-amp); j < div+amp; j++) {
    float y1 = ss*j;
    float y2 = ss*j+ss;
    /*
    c1 = rcol();
     c2 = rcol();
     */
    beginShape();
    fill(c1);
    for (int i = 0; i <= width; i++) {
      float nn = noise(des+i*det, des+y1*det);
      nn = constrain(map(nn, umbral, 1, 0, 1), 0, 1);
      float hh = nn*ss*amp;
      vertex(i, y1+hh);
    }
    fill(c2);
    for (int i = width; i >= 0; i--) {
      float nn = noise(des+i*det, des+y2*det);
      nn = constrain(map(nn, umbral, 1, 0, 1), 0, 1);
      float hh = nn*ss*amp;
      vertex(i, y2+hh);
    }
    endShape(CLOSE);
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#F8F8F8, #F0B8C1, #9FC8E6, #FCC702, #323232};
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