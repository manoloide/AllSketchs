float det, des;
float time;
int seed = int(random(999999));


void setup() {
  size(960, 540, P2D);
  smooth(4);
  pixelDensity(2);
  noiseDetail(3);

  generate();
}

void draw() {

  time = millis()*0.001;

  generate();
}

void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    seed = int(random(10000));
    generate();
  }
}

void generate() {

  time = millis()*0.001;

  noiseSeed(seed);
  randomSeed(seed);
  background(255);

  float des = random(10000);
  float det = random(0.001, 0.01);

  noiseDetail(int(random(4)));
  float res = random(120);
  float tt = time*random(1)*random(0.2, 1);
  float ang = random(TAU)+tt*random(-0.1, 0.1);

  float x, y, a;
  noFill();
  for (int i = 0; i < 200; i++) {
    x = (noise(i, tt)*1.2-0.1)*width; 
    y = (noise(tt, i)*1.2-0.1)*height; 
    int col = rcol();

    stroke(col, 20);
    beginShape();
    vertex(x, y);
    for (int j = 0; j < 800; j++) {
      a = ang+noise(des+x*det, des+y*det, tt)*TAU*res;
      x += cos(a);
      y += sin(a);
      vertex(x, y);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

int colors[] = {#000000}; 
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