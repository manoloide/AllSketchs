int fps = 30;
float seconds = 8;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

Trazo trazo;

float cx, cy;

void setup() {
  size(640, 640, P2D);
  smooth(8);
  if (!export) pixelDensity(2);
  frameRate(fps);
  noiseDetail(1);
  cx = width/2;
  cy = height/2;

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

  if (export && cycle >= 2) {
    if (cycle > 2) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {
  //println(seed);

  randomSeed(seed);
  noiseSeed(seed);

  background(255);
  stroke(0);

  cx += (trazo.x-cx)*0.08;
  cy += (trazo.y-cy)*0.08;
  translate(width/2-cx, height/2-cy);
  trazo.update();
  trazo.show();
}

void keyPressed() {

  seed = int(random(9999999));
  generate();
}

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  println(seed);
  trazo = new Trazo();
}

class Trazo {
  ArrayList<PVector> points;
  float x, y;
  float det, des, loop;
  Trazo() {
    points = new ArrayList<PVector>();
    points.add(new PVector(cx, cy));
    det = random(0.1, 1)*2;
    des = random(2000);
    loop = 1;
  }

  void update() {
    PVector p = points.get(points.size()-1).copy();
    float ang = noise(time*det*2+des)*TWO_PI*2;
    ang = cnoise(time*TWO_PI, det, des)*TWO_PI*4;
    float vel = map(cos(time*TWO_PI), 1, -1, 1, 5)*1.4;
    p.add(cos(ang)*vel, sin(ang)*vel);
    points.add(p);
    x = p.x;
    y = p.y;
  }

  void show() {
    PVector p = points.get(points.size()-1);
    noFill();
    beginShape();
    float d, a, xx, yy, ax, ay;
    ax = ay = 0;
    for (int i = 0; i < points.size(); i++) {
      p = points.get(i);
      ax = p.x;
      ay = p.y;
      vertex(p.x, p.y);
    }
    endShape();

    if (points.size() > 1000) points.remove(0);
  }
}

float cnoise(float v, float det, float des) {
  return noise(des+cos(v)*det, des+sin(v)*det);
}