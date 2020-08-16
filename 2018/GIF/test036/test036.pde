int fps = 30;
float seconds = 30;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

void setup() {
  size(640, 640, FX2D);
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
  
  background(40);


  int cc = 15;
  float ss = width*1./cc;

  float dt = 100*(0.02+cos(time*TAU));
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = ss*(i+0.5);
      float yy = ss*(j+0.5);
      float dd = dist(width/2, height/2, xx, yy)*0.1;
      float nd = dd/(width*0.71);
      float s = ss*(0.2+cos(time)*0.08+cos(dd+dt)*0.4)*0.4;
      rect(xx, yy, s, s);
    }
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
