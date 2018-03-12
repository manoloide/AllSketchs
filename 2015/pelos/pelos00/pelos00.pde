float time;
int seed;


void setup() {
  size(960, 960);
  generate();
  //println(seed);
  seed = 766541440;
}

void draw() {
  time += 1./120;
  background(250);
  randomSeed(seed);
  noiseSeed(seed);
  float det = 0.006;
  stroke(0, 40);
  for (int i = 0; i < 420000; i++) {
    float x = random(-40, width+40);
    float y = random(-40, height+40);
    float n = noise(x*det, y*det);
    float a = n*TWO_PI+TWO_PI*time;
    float d = map(n, 0, 1, 2, 32+cos(time*TWO_PI+x+y)*10); 
    line(x, y, x+cos(a)*d, y+sin(a)*d);
  }

  saveFrame("####.png");

  if (time > 1) {
    exit();
  }
} 

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999999));
}

