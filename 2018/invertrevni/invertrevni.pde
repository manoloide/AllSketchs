int seed = int(random(999999));

void setup() {
  size(760, 760, P2D); 
  generate();
}

void draw() {

  float time = millis()*0.001;

  background(0); 
  blendMode(EXCLUSION);

  noiseSeed(seed);
  randomSeed(seed);

  for (int j = 0; j < 6; j++) {
    float des = random(1000);
    float det = random(0.1)*random(1);
    float vel = random(-5, 5)*random(1)*random(1);
    float max = random(random(0.1, 0.5), random(0.5, 0.9));
    boolean hor = (random(1) < 0.5);
    int cc = (hor)? width : height;
    int count = 0;
    for (int i = 0; i < cc; i++) {
      float noi = noise(des+i*det, time*vel);
      if (noi > max) {
        count ++;
      }
      if (noi <= max || i == cc-1) {
        fill(255);
        if (hor) rect(i-count, 0, count, height);
        else rect(0, i-count, width, count);
        count = 0;
      }
    }
  }
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999));
}