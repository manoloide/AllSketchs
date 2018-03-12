ArrayList<PVector> points;
Camera camera;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  camera = new Camera();
  generate();
}

void draw() {
  background(10);
  noStroke();
  fill(255, 25);
  camera.update();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    noStroke();
    fill(255);
    pushMatrix();
    translate(p.x, p.y, p.z);
    box(10);
    popMatrix();
  }
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
    generate();
  }
}

void mouseDragged() {
  camera.moved();
}

void generate() {
  points = new ArrayList<PVector>();
  float ss = 500;
  for (int i = points.size(); i < 10; i++) {
    points.add(new PVector(random(-ss, ss), random(-ss, ss), random(-ss, ss)));
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
    rotTarget.x += (PI/4)*my;
    rotTarget.y += (PI/4)*mx;
  }
}