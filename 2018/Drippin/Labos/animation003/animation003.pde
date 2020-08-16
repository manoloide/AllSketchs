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

  float des1 = int(random(10000));
  float det1 = random(0.5)*random(1);
  float des2 = int(random(10000));
  float det2 = random(0.1)*random(1);
  float tt = time*random(-20, 20)*random(0.2, 1)*random(1);
  float amp = random(0.4, 0.6);
  noStroke();
  fill(250);
  int count = 0;
  rectMode(CORNER);
  for (int i = 0; i <= width; i++) {
    float d = i*100./width;
    float noi = noise(tt+des1+(det1*d)*noise(des2+det2*d));
    if (noi > amp) {
      count++;
    }
    if (count > 0 && (i == width || noi <= amp)) {
      rect(i-count, 0, count, height);
      count = 0;
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