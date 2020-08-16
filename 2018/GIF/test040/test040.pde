int fps = 15;
float seconds = 8;
boolean export = true;

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

  lights();

  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  translate(width*0.5, height*0.5);

  int cc = 30;
  float ss = (width*0.8)/cc;
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float vx = (i-cc*0.5)/cc;
      float vy = (j-cc*0.5)/cc;
      pushMatrix();
      translate((i+0.5-cc*0.5)*ss, (j+0.5-cc*0.5)*ss);
      rotateX((time+vx*map(cos(time*TAU), -1, 1, 1, 3))*TAU);
      rotateY((time+vy*map(cos(time*2*TAU), -1, 1, 1, 9))*TAU);
      fill((cos(time*2*TAU+vx*40)*0.5+0.5)*255, (cos(time*TAU+PI+vx*20)*0.5+0.5)*255, (cos(time*TAU+0.7+vx*5+vy*3)*0.5+0.5)*255);
      ellipse(0, 0, ss, ss);
      popMatrix();
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
