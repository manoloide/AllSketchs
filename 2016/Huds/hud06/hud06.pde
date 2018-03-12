ArrayList<PVector> points;
Camera camera;
int seed;
PShader post;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  camera = new Camera();
  seed = int(random(999999999));
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));
  surface.setResizable(true);
  points = new ArrayList<PVector>();
}

void draw() {
  post.set("time", millis()/1000.);
  background(#240615);
  noStroke();
  fill(255, 25);
  camera.update();

  cubeGrid(960);
  points();

  filter(post);
}

void keyPressed() {
  if (keyCode == LEFT) {
    camera.rectMove(1, 0);
  }
  if (keyCode == RIGHT) {
    camera.rectMove(-1, 0);
  }
  if (keyCode == UP) {
    camera.rectMove(0, -1);
  }
  if (keyCode == DOWN) {
    camera.rectMove(0, 1);
  }
  if (key == ' ') {
    points = new ArrayList<PVector>();
  }
}

void mouseDragged() {
  camera.moved();
}

void cubeGrid(float ss) {
  pushMatrix();
  translate(0, ss/2, 0);
  rotateX(PI/2);
  gridQuad(ss, ss, 20, 2);
  stroke(255, 25);
  strokeWeight(1);
  gridSimple(ss, ss, 80);
  strokeWeight(2);
  gridCross(ss, ss, 160, 10);
  popMatrix();

  pushMatrix();
  translate(ss/2, 0, 0);
  rotateY(PI/2);
  stroke(255, 25);
  strokeWeight(1);
  gridSimple(ss, ss, 80);
  popMatrix();

  pushMatrix();
  translate(0, 0, -ss/2);
  rotateZ(PI/2);
  stroke(255, 25);
  strokeWeight(1);
  gridSimple(ss, ss, 160);
  noStroke();
  fill(255, 50);
  gridQuad(ss, ss, 160, 6);
  gridQuad(ss, ss, 80, 4);
  popMatrix();
}

float minPlane = 0;
float maxPlane = 0;
void points() {
  for (int i = points.size(); i < 4; i++) {
    points.add(new PVector(random(-480, 480), 480, random(-480, 480)));
  }


  float det = 0.002;
  float time = frameCount/240.;

  float max = -480;
  float min = 480;

  int sep = 20;
  stroke(255);
  for (int j = -480; j <= 480; j+= sep) {
    for (int i = -480; i <= 480; i+= sep) {
      float y = noise(i*det+time, j*det+time)*960-480;
      point(i, y, j);
      if (max < y) max = y; 
      if (min > y) min = y;
    }
  }

  minPlane += (min-minPlane)*0.06;
  maxPlane += (max-maxPlane)*0.06;
  noFill();
  stroke(255, 40);
  pushMatrix();
  translate(0, minPlane, 0);
  rotateX(PI/2);
  rect(0, 0, 960, 960);
  popMatrix();
  pushMatrix();
  translate(0, maxPlane, 0);
  rotateX(PI/2);
  rect(0, 0, 960, 960);
  popMatrix();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    p.y += ((noise(p.x*det+time, p.z*det+time)*960-480)-p.y)*0.08;
    noStroke();
    fill(255, 200);
    pushMatrix();
    translate(p.x, p.y, p.z);
    box(10);
    popMatrix();

    stroke(255, 80);
    line(p.x, p.y-10, p.z, p.x, -500, p.z);
  }
}

void gridQuad(float w, float h, int cc, int ss) {
  float mw = w/2;
  float mh = h/2;
  rectMode(CENTER);
  for (int j = 0; j < h+cc; j+=cc) {
    for (int i = 0; i < w+cc; i+=cc) {
      rect(i-mw, j-mh, ss, ss);
    }
  }
}

void gridCross(float w, float h, int cc, float ss) {
  float mw = w/2;
  float mh = h/2;
  ss *= 0.5;
  for (int j = 0; j < h+cc; j+=cc) {
    for (int i = 0; i < w+cc; i+=cc) {
      line(i-mw-ss, j-mh, i-mw+ss, j-mh);
      line(i-mw, j-mh-ss, i-mw, j-mh+ss);
    }
  }
}

void gridSimple(float w, float h, int cc) {
  float mw = w/2;
  float mh = h/2;
  for (int i = 0; i < w+cc; i+=cc) {
    line(i-mw, -mh, i-mw, mh);
  } 
  for (int i = 0; i < h+cc; i+=cc) {
    line(-mw, i-mh, mw, i-mh);
  }
}

class Camera {
  PVector rot, rotTarget;
  Camera () {
    rot = new PVector(PI/4, PI/4);
    rotTarget = new PVector();
  }
  void update() {

    PVector aux = rotTarget.copy();
    aux.sub(rot);
    aux.mult(0.1);
    rot.add(aux);

    translate(width/2, height/2, -1200);
    rotateX(rot.x);
    rotateY(rot.y);
  }

  void moved() {
    float rate = 0.01;
    rotTarget.x += (pmouseY-mouseY) * rate;
    rotTarget.y += (mouseX-pmouseX) * rate;
  }

  void rectMove(int mx, int my) {

    if (my != 0) {
      println(rotTarget.x%(PI/4));
    }

    rotTarget.x += (PI/4)*my;
    rotTarget.y += (PI/4)*mx;
  }
}