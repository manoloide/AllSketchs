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
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float des = random(10000);
    float det = random(0.1)*random(0.1, 1);
    ArrayList<PVector> ps = new ArrayList<PVector>();
    for (int j = 0; j < 10000; j++) {
      float ang = noise(des+x*det, des+y*det)*TWO_PI*20;
      ps.add(new PVector(x, y));
      x += cos(ang);
      y += sin(ang);
    }
    int col = getColor(random(colors.length));
    stroke(0, 30);
    noFill();
    beginShape();
    for (int j = 0; j < ps.size(); j++) {
      PVector p = ps.get(j);
      vertex(p.x+1, p.y+1);
    }
    endShape();

    translate(0, 0, 1);
    noStroke();
    int cc = int(random(-2, 4));
    for (int j = 0; j < cc; j++) {
      PVector p = ps.get(int(random(ps.size())));
      float ss = random(80);
      fill(0, 20);
      ellipse(p.x+1, p.y+1, ss, ss);
      noStroke();
      fill(col);
      ellipse(p.x, p.y, ss, ss);
    }
    noFill();
    stroke(col);
    beginShape();
    for (int j = 0; j < ps.size(); j++) {
      PVector p = ps.get(j);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
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