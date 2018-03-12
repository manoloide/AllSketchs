int fps = 30;
float seconds = 6;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 8056208; 
void render() {

  randomSeed(seed);
  noiseSeed(seed);

  background(10);
  translate(width/2, height/2);

  ArrayList<PVector> points = new ArrayList<PVector>();
  points.add(new PVector(0, 0, 0));
  int cc = 10; 
  float sep = 300;

  float dd = 0.6;
  for (int i = 1; i < cc; i++) {
    PVector ant = points.get(i-1);
    float a1 = random(-PI*dd, PI*dd)-HALF_PI;
    float a2 = random(-PI*dd, PI*dd);
    float x = sin(a1)*sin(a2)*sep;
    float y = sin(a1)*cos(a2)*sep;
    float z = cos(a1)*sep;
    PVector nex = ant.copy().add(x, y, z);
    points.add(nex);
  }

  int sel1 = int(time*(cc-1));
  if (sel1 >= cc) sel1 = cc-1;
  int sel2 = sel1+1;
  if (sel2 >= cc) sel2 = cc-1;

  float tt = (time*(cc-1))%1;
  tt = Easing.ExpoInOut(tt, 0, 1, 1);
  PVector des = points.get(sel1).copy();
  des.lerp(points.get(sel2), tt);

  translate(-des.x, -des.y, -des.z);

  stroke(255);
  fill(255);
  strokeWeight(2);
  PVector last = points.get(int(points.size()-1));
  for (int i = 1; i < points.size(); i++) {
    PVector p1 = points.get(i-1);
    PVector p2 = points.get(i);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);

    pushMatrix();
    translate(-last.x, -last.y, -last.z);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    popMatrix();

    pushMatrix();
    translate(last.x, last.y, last.z);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    popMatrix();
  }

  noStroke() ;
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    pushMatrix();
    translate(p.x, p.y, p.z); 
    sphere(10);
    popMatrix();

    pushMatrix();
    translate(-last.x, -last.y, -last.z);
    translate(p.x, p.y, p.z); 
    sphere(10);
    popMatrix();

    pushMatrix();
    translate(last.x, last.y, last.z);
    translate(p.x, p.y, p.z); 
    sphere(10);
    popMatrix();
  }
}  