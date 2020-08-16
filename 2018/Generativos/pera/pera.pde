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

  int back = rcol();
  randomSeed(seed);
  noiseSeed(seed);
  background(back);

  noStroke();
  int planets = 1200;//int(random(1200));
  float det1 = random(0.01);
  float des1 = random(1000);

  float detc1 = random(0.01)*random(1)*random(1);
  float desc1 = random(1000);
  float detc2 = random(0.01)*random(1)*random(1);
  float desc2 = random(1000);
  float detc3 = random(0.01)*random(1)*random(1);
  float desc3 = random(1000);

  int c1 = rcol();
  int c2 = rcol();
  int c3 = rcol();

  ArrayList<PVector> points = new ArrayList<PVector>();
  noiseDetail(1);
  for (int i = 0; i < planets; i++) {

    if (i == planets/2) {
      int cc = int(random(100));
      float ss = width*1./cc;
      stroke(rcol());
      for (int j = 1; j < cc; j++) {
        line(j*ss, 0, j*ss, height);
        line(0, j*ss, width, j*ss);
      }
      noStroke();
    }

    boolean accent = (random(1) < 0.02);
    float x = random(width+20);
    float y = random(height+20);
    x -= x%5;
    y -= y%5;
    float s = random(800)*random(1)*random(1)*random(0.2, 1);
    s = pow(noise(des1+x*det1, des1+y*det1), 2.2)*820;
    float r = s*0.5;
    int cc = int(max(8, s*PI));
    float da = TAU/cc;
    float fog = map(i, 0, planets, 0, 1);
    int col1 = lerpColor(back, c1, fog);//getColor(noise(desc1+detc1*x, desc1+detc1*y)*2*colors.length), fog);
    int col2 = lerpColor(back, c2, fog);// getColor(noise(desc2+detc2*x, desc2+detc2*y)*2*colors.length), fog);
    int col3 = lerpColor(back, c3, fog);// getColor(noise(desc3+detc3*x, desc3+detc3*y)*2*colors.length), fog);

    float alp = map(i, 0, planets, 0, 255);
    beginShape(TRIANGLES);
    for (int j = 0; j < cc; j++) {
      float ang1 = da*j;
      float ang2 = da*j+da;
      fill(col1, alp*0.8);
      vertex(x, y);
      fill(lerpColor(col2, col3, abs(map(j, 0, cc, 0, 2)-1)), alp);
      vertex(x+cos(ang1)*r, y+sin(ang1)*r);
      fill(lerpColor(col2, col3, abs(map(j+1, 0, cc, 0, 2)-1)), alp);
      //fill(col3);
      vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    }
    endShape();

    for (int j = 0; j < 50; j++) {
    }

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < 1) {
        add = false;
        break;
      }
    }
    if (add)points.add(new PVector(x, y, s));
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
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
