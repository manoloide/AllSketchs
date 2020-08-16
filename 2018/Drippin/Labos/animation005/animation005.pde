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


  float det = random(0.02)*random(1)*random(0.5, 1);
  float des = random(100000);
  float dir = random(TWO_PI);
  float vel = random(6)*random(1);

  background(0);
  for (int j = 0; j <= height; j+=gridSize) {
    for (int i = 0; i <= width; i+=gridSize) {
      noStroke();
      fill(255, 30);
      rect(i, j, 2, 2);
    }
  }
  
  
}

void keyPressed() {
  generate();
}
void generate() {
  seed = int(random(99999999));
}