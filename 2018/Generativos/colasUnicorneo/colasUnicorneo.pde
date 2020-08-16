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
  //generate();
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
  noStroke();
  for (int k = 0; k < 80; k++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.3);
    float ic = random(colors.length);
    float dc = random(0.02);
    float ang = random(TAU);
    float vel = 0.02;
    while (s > 0.5) { 
      ang += random(-0.1, 0.1);
      x += cos(ang)*s*vel;
      y += sin(ang)*s*vel;
      ic += dc;
      fill(getColor(ic), 250);
      ellipse(x, y, s, s);
      if (random(100) < 0.2) {
        float c1 = random(colors.length);
        float c2 = c1+random(colors.length)*random(1)*0.5;
        circle(x, y, s*1.2, s*1.3, c1, c2);
      }
      s *= 0.99;
    }

    int cc = int(random(-2, 4));
    for (int i = 0; i < cc; i++) {
      float xx = random(width);
      float yy = random(height);
      float ss = width*random(0.001, 0.02);
      float c1 = random(colors.length);
      float c2 = c1+random(2)*random(1);
      float amp = random(0.05, 0.4);
      fill(getColor(c1));
      ellipse(xx, yy, ss*amp, ss*amp);
      circle(xx, yy, ss*1, ss*0.9, c1, c2);
    }
  }
}

void circle(float x, float y, float s1, float s2, float c1, float c2) {
  int res = int(max(8, PI*max(s1, s2))); 
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float rot = random(TAU);
  for (int i = 0; i < res; i++) {
    float a1 = rot+map(i, 0, res, 0, TAU);
    float a2 = rot+map(i+1, 0, res, 0, TAU);
    float vc1 = map(abs(cos(map(i, 0, res, 0, TAU))), 0, 1, c1, c2);
    float vc2 = map(abs(cos(map(i+1, 0, res, 0, TAU))), 0, 1, c1, c2);
    beginShape();
    fill(getColor(vc1));
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
    fill(getColor(vc2));
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FF4B00, #FFC500, #00DEB5, #3030D0, #FF97D6};
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