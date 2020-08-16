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
  noiseSeed(seed);

  background(0);

  float des = random(10000);
  float det = random(0.06, 0.012)*0.4;
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 50000; i++) {
    float x = random(width);
    float y = random(height);
    float s = noise(des+x*det, des+y*det)*120*map(y, 0, height, 0.8, 1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.02) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  noiseDetail(2);
  des = random(1000);
  det = random(0.001, 0.008);
  float pwr = random(0.1, 0.2)*10;
  noiseDetail(int(random(1, 6)));
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x;
    float y = p.y;
    float s = p.z*0.2;

    int c1 = lerpColor(getColor(pow(noise(des+x*det, des+y*det, 00), pwr)*colors.length), color(random(256)), random(1));
    int c2 = lerpColor(getColor(pow(noise(des+x*det, des+y*det, 10), pwr)*colors.length), color(random(256)), random(1));
    int c3 = lerpColor(getColor(pow(noise(des+x*det, des+y*det, 50), pwr)*colors.length), color(random(256)), random(1));
    int c4 = lerpColor(getColor(pow(noise(des+x*det, des+y*det, 90), pwr)*colors.length), color(random(256)), random(1));

    int col = c1;
    if (random(1) < 0.5) {
      if (random(1) < 0.5) col = c1;
      else col = c2;
    } else {
      if (random(1) < 0.5) col = c3;
      else col = c4;
    }
    pushMatrix();
    translate(x, y);
    fill(col);
    rotate(noise(des+x*det, des+y*det)*TAU*2);
    stroke(0, 20);
    ellipse(0, 0, s*0.4, s*random(4, 6));
    rotate(-HALF_PI*0.3);
    ellipse(0, 0, s*0.4, s*random(4, 6));
    rotate(HALF_PI*0.6);
    ellipse(0, 0, s*0.4, s*random(4, 6));
    if (random(1) < 0.02) {
      fill(rcol());
      ellipse(0, 0, s*0.4, s*0.4);
    }
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
