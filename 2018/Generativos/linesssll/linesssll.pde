int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
  background(rcol());

  noiseDetail(1);
  for (int l = 0; l < 3; l++) {
    noStroke();
    fill(rcol(), 10);
    rect(0, 0, width, height);
    float des = random(10000);
    float det = random(0.002);
    noFill();
    strokeCap(SQUARE);
    float x, y, ang;
    for (int i = 0; i < 30; i++) {
      x = random(-100, width+100);
      y = random(-100, height+100);
      stroke(getColor(random(colors.length)));
      stroke(rcol());
      for (int k = 0; k < 20; k++) {
        strokeWeight(random(2, 14));
        beginShape();
        for (int j = 0; j < 200; j++) {
          ang = noise(des+x*det, des+y*det)*TWO_PI*2;
          vertex(x, y);
          x += cos(ang);
          y += sin(ang);
        }
        endShape();
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
//int colors[] = {#434E20, #E8AF36, #F56546, #446E9A, #F6EDDD};
int colors[] = {#434E20, #E8AF36, #F56546, #446E9A, #F6EDDD, #DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D, #EFEFEF, #4F4F4F, #000000, #0258F1, #FF7101};
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