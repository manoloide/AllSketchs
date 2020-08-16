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
  randomSeed(seed);
  background(rcol());

  for (int j = 0; j < 5; j++) {
    float cx = width*random(0.3, 0.7);
    float cy = height*random(0.3, 0.7);

    int div = int(random(2, 10));
    int seg = int(random(20, 20));
    float r = width*0.9;
    float a = random(TWO_PI);

    int cc = div*seg;
    float da = TWO_PI/cc;

    float amp = TWO_PI/(cc)*0.5;

    noStroke();
    fill(0);
    if (j%2 == 0) fill(255);
    fill(rcol());
    int c1 = rcol();
    int c2 = rcol();
    c2 = lerpColor(c1, c2, 0.2);
    //c1 = c2 = color(0);
    float ap = random(0.1, 0.9);
    for (int i = 0; i < cc; i++) {
      float aa = sin(map(i%seg, 0, seg, 0, PI))*ap;
      float a1 = a+da*i-amp*aa;
      float a2 = a+da*i+amp*aa;
      beginShape();
      fill(c1);
      vertex(cx, cy);
      fill(c2);
      vertex(cx+cos(a1)*r, cy+sin(a1)*r);
      vertex(cx+cos(a2)*r, cy+sin(a2)*r);
      endShape(CLOSE);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


//int colors[] = {#af54ff, #e2a126, #fce380, #84b4ce, #490528};
//int colors[] = {#386398, #0AA899, #F0594F, #F48482, #FDBC3C};
//int colors[] = {#E95D27, #347C64, #E44232, #E4D9BD};
int colors[] = {#434E20, #E8AF36, #F56546, #446E9A, #F6EDDD};
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