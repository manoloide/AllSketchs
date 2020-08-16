float gridSize = 20;
int seed = 1;//int(random(99999999));


void setup() {
  size(960, 540);
  smooth(2);
  pixelDensity(2);
  frameRate(25);
  rectMode(CENTER);
  generate();
}

void draw() {

  if (frameCount%(25*10) == 0) generate();

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  for (int j = 0; j <= height; j+=gridSize) {
    for (int i = 0; i <= width; i+=gridSize) {
      noStroke();
      fill(255, 30);
      rect(i, j, 2, 2);
      float xx = des+i*det+cos(dir)*time*vel;
      float yy = des+j*det+sin(dir)*time*vel;
      float noi = noise(xx, yy)*1.5-0.5;
      if (noi < 0) continue;
      if (noi < 0.5) noi = pow(noi, 1.5);
      else noi = pow(noi, 0.66);
      float ss = noi*gridSize*0.5;
      noFill();
      stroke(255);
      rect(i, j, ss, ss);
    }
  }
}

void keyPressed() {
  generate();
}

float det, des, dir, vel;
void generate() {
  det = random(0.02)*random(1)*random(0.5, 1);
  des = random(100000);
  dir = random(TWO_PI);
  vel = random(6)*random(1);
  seed = int(random(99999999));
}