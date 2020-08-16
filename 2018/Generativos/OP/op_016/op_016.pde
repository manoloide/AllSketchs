int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {

  randomSeed(seed);
  background(255);

  float ss = 5;
  int cw = int(width/ss);
  int ch = int(height/ss);
  
  
  //carne ||
  //verdura |||
  //pollo |
  //humita ||
  //roque ||
  //jyq |||
  
  
  
  
  
  noStroke();
  fill(0);
  float det = random(0.01);
  float des = random(1000);
  noiseDetail(2);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float x = i*ss;
      float y = j*ss;
      float n = pow(noise(des+x*det, des+y*det), 2);
      float amp = 1.41*n;//random(1.41);
      ellipse(i*ss, j*ss, ss*amp, ss*amp);
    }
  }
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
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
