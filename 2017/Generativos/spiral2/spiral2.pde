int seed = int(random(999999));

void setup() {
  size(920, 920, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
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
  background(0);

  noStroke();
  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(0.1, 0.8)*width*random(0.1, 1);
    fill(getColor(random(colors.length)));
    cir(x, y, s, random(TWO_PI), random(TWO_PI*4));
  }
}

void cir(float x, float y, float s, float ia, float ea) {
  int div = 32;
  int sub = 32;
  float da = TWO_PI/sub;
  float da2 = TWO_PI/sub*random(0.2);
  float dc = int(random(1, 10))*colors.length*1./sub;
  float dc2 = random(colors.length)*random(0.4);
  for (int j = 0; j < div; j++) {
    float des1 = da2*j;
    float des2 = da2*(j+1);
    for (int i = 0; i < sub; i++) {
      float a1 = da*i;
      float a2 = da*(i+1);
      float d1 = map(j, 0, div, 0, s);
      float d2 = map(j+1, 0, div, 0, s);

      fill(getColor(dc*i+dc2*j));
      //stroke(getColor(dc*i+dc2*j));
      beginShape();
      vertex(x+cos(a1+des1)*d1, y+sin(a1+des1)*d1);
      vertex(x+cos(a1+des2)*d2, y+sin(a1+des2)*d2);
      vertex(x+cos(a2+des2)*d2, y+sin(a2+des2)*d2);
      vertex(x+cos(a2+des1)*d1, y+sin(a2+des1)*d1);
      endShape(CLOSE);
      beginShape();
      fill(0, 0);
      vertex(x+cos(a1+des1)*d1, y+sin(a1+des1)*d1);
      vertex(x+cos(a1+des2)*d2, y+sin(a1+des2)*d2);
      fill(0, 16);
      vertex(x+cos(a2+des2)*d2, y+sin(a2+des2)*d2);
      fill(0, 30);
      vertex(x+cos(a2+des1)*d1, y+sin(a2+des1)*d1);
      endShape(CLOSE);
    }
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#EAA104, #F9BBD1, #51D17C, #47A1BC, #EA2525};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}