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
  randomSeed(seed);

  noStroke();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5)*random(1);
    fill(rcol());
    ellipse(x, y, s, s);
  }

  for (int k = 0; k < 3; k++) {

    for (int i = 0; i < 5; i++) {
      float x = random(width);
      float y = random(height);
      float s = width*random(0.1, 0.6)*random(1);
      noStroke();
      arc2(x, y, s, s*1.6, 0, TWO_PI, color(0), 20, 0);
      int col = rcol();
      fill(col);
      ellipse(x, y, s, s);
      arc2(x, y, s*0.4, s, 0, TWO_PI, color(0), 0, 30);
      arc2(x, y, s*0.0, s, 0, TWO_PI, color(0), 0, 80);
      arc2(x, y, s*0.8, s, 0, TWO_PI, color(col), 0, 90);
    }

    noFill();
    float des = random(100000);
    float det = random(0.001, 0.008);
    noiseDetail(2);
    int sub = 1000;
    for (int i = 0; i < sub; i++) {
      float x = width/2; 
      float y = height/2;
      float ang = map(i, 0, sub, 0, TWO_PI);
      float vel = 2;
      stroke(getColor(map(ang, 0, TWO_PI, 0, colors.length*2)));
      beginShape();
      for (int j = 0; j < 2000; j++) {
        float a = noise(des+x*det, des+y*det)*TWO_PI*10+ang;
        vertex(x, y);
        x += cos(a)*vel;
        y += sin(a)*vel;
      }
      endShape();
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#C8F67B, #5BA7F4, #72D7E9, #9CC4F9, #E6B2FA, #B8B5FE, #99C5FC, #F2B19F, #C82E47, #F9CD58, #F06F13, #9A46DF, #3427CA};
int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
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