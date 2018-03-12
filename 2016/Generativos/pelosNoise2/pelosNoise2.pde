int seed = 0;
int fps = 30;
int frame = 0;
int seg = 8;


void setup() {
  size(960, 960);
  frameRate(fps);
  generate();
}

void draw() {
  frame++;
  generate();
  saveFrame("export/####.png");
  if (frame > 2) exit();
}

void generate() {
  noiseSeed(seed);
  randomSeed(seed);

  background(250);
  stroke(0, 120);
  int sep = 2;
  float det = 0.003;
  float da = map(frame, 0, 60, 0, TWO_PI);
  float z = cos(da/4)*1;
  //da = 0;
  for (int j = -10; j < height+10; j+=sep) {
    for (int i = -10; i < width+10; i+=sep) {
      float x = i+sep*random(-0.5, 0.5);
      float y = j+sep*random(-0.5, 0.5);
      float n = noise(x*det, y*det, z);
      float a = n*TWO_PI+da;
      float d = map(n, 0, 1, 2, 30);
      line(x, y, x+cos(a)*d, y+sin(a)*d);
    }
  }
}  
