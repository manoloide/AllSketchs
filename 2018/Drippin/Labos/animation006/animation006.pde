float gridSize = 5;
int seed = 8;//int(random(99999999));

boolean save = true;

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
  if (save) time = frameCount/25.;

  randomSeed(seed);
  noiseSeed(seed);

  float amp = random(0.4, 0.6);

  background(0);

  float tt = time*random(20)*random(1)*random(1);

  for (int j = 0; j <= height; j+=gridSize) {
    for (int i = 0; i <= width; i+=gridSize) {
      noStroke();
      if (noise(random(100), tt) > amp) {
        fill(240);
      } else {
        fill(0);
      }
      rect(i, j, 2, 2);
    }
  }

  if (save) {
    saveFrame("export3/frame####.png");
    if (time >= 60) exit();
  }
}

void keyPressed() {
  generate();
}
void generate() {
  seed = int(random(99999999));
}