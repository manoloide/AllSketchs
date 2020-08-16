int fps = 30;
float seconds = 4;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

void setup() {
  size(640, 640, P2D);
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
  scale(1.2+cos(time*TAU)*0.2);


  int cc = 30;
  float ss = width*1./cc;

  rectMode(CENTER);
  noStroke();
  float des = 100;
  float det = 0.005;
  rectMode(CENTER);
  strokeWeight(2);
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = (i-cc*0.5+0.5)*ss;
      float y = (j-cc*0.5+0.5)*ss;
      float d = dist(x, y, 0, 0);
      float md = cos(d*0.02+PI*time);
      float se = ss*noise(des+x*det, des+y*det, cos(PI*time))*0.6*md;
      boolean inv = (i+j)%2 == 0;
      float sr = pow(cos((x+y)*0.5+cos(time*PI)*PI), 1.2)*ss*0.6;
      fill((inv)?0:255);
      rect(x, y, ss, ss);
      fill((inv)?255:0);
      rect(x, y, sr, sr);
      fill((inv)?0:255);
      ellipse(x+0.5, y+0.5, se, se);
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
