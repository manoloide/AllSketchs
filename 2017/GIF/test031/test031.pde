int fps = 30;
float seconds = 8;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
  background(255);
}

void draw() {
  if (export) time = map((frameCount-1), 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {

  background(40);
  translate(width/2, height/2);
 
  int seed = 10;
  randomSeed(seed);
  int cc = 4; 
  float da = TWO_PI/cc;
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    float dd = width*random(0.1, 0.4);
    float a = da*(i+random(-0.2, 0.2));
    points.add(new PVector(cos(a)*dd, sin(a)*dd));
  }

  drawCurve(points);
}

void drawCurve(ArrayList<PVector> points) {
  beginShape();
  int cc = points.size();
  for (int i = 0; i < cc; i++) {
    PVector ant = points.get((i+cc-1)%cc);
    PVector act = points.get((i+cc+0)%cc);
    PVector sig = points.get((i+cc+1)%cc);

    float a1 = atan2(act.y-ant.y, act.x-ant.x);
    float a2 = atan2(act.y-ant.y, act.x-ant.x);
    float a = (a1+a2)*0.5;
    stroke(0, 255, 20);
    line(act.x, act.y, act.x+cos(a)*20, act.y+sin(a)*20);
    line(act.x, act.y, act.x+cos(a1)*20, act.y+sin(a1)*20);
    line(act.x, act.y, act.x+cos(a2)*20, act.y+sin(a2)*20);
    stroke(255, 120, 0);
    line(ant.x, ant.y, act.x, act.y);
    line(act.x, act.y, sig.x, sig.y);
    fill(255);
    ellipse(act.x, act.y, 5, 5);
  }
  endShape();
}