int fps = 15;
float seconds = 8;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  if (!export) pixelDensity(2);
  frameRate(fps);

  generate();
}

void draw() {
  if (export) {
    time = map((frameCount-1)%frames, 0, frames, 0, 1);
    cycle = int((frameCount-1)/frames);
  } else {
    time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);
    cycle = int((millis()/1000.)/seconds);
  }

  //println(cycle, time, seed);

  render();

  if (export) {
    if (cycle > 0) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {
  //println(seed);

  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  translate(width*0.5, height*0.5);

  rotateX(time*TAU);
  //rotateY(time*HALF_PI*2);
  rotateZ(time*TAU);

  int cc = 4;
  float dt = 1./cc;
  noFill();
  for (int i = 0; i < cc; i++) {
    float v = (i+1./(cc-1));
    float nt = pow((time+dt*i)%1, 1.2);//pow(((time+dt*i)%1), 0.99);
    rotateX(nt*PI);
    rotateY(nt*PI);
    rotateZ(nt*PI);
    stroke(255, 80);
    box(nt*width);
  }
}

void keyPressed() {

  seed = int(random(9999999));
  generate();
}

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  println("seed:", seed);
}
