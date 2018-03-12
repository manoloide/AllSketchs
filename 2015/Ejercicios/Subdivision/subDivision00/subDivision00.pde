ArrayList<Line> lines;
ArrayList<Node> nodes;


import peasy.*;
PeasyCam cam;

void setup() {
  size(960, 960, P3D);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);

  smooth(4);
  generate();
}

void draw() {
  background(250); 
  translate(width/2, height/2, -300);
  stroke(0, 50);

  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
  }
  for (int i = 0; i < lines.size (); i++) {
    Line l = lines.get(i);
    l.update();
    if (random(100) < 1 && l.getSize() > 50) subdivide(l);
    if (l.remove) lines.remove(i--);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  generate();
}

void generate() {
  lines = new ArrayList<Line>();
  nodes = new ArrayList<Node>();
  float amp = 300;
  Node n1 = new Node(random(-amp, amp), random(-amp, amp), random(-amp, amp));
  Node n2 = new Node(random(-amp, amp), random(-amp, amp), random(-amp, amp));
  lines.add(new Line(n1, n2));
  nodes.add(n1);
  nodes.add(n2);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void subdivide(Line l) {
  PVector an = l.n1.copyTarget();
  PVector dif = l.n2.copyTarget();
  dif.sub(an);
  dif.mult(0.5);
  an.add(dif);
  Node nn = new Node(an);
  nodes.add(nn);
  lines.add(new Line(l.n1, nn));
  lines.add(new Line(nn, l.n2));
  l.remove = true;
}

class Node extends PVector {
  float vel, elastic;
  PVector target;
  PVector velocity;

  Node(PVector v) {
    super();
    init(v.x, v.y, v.z);
  }

  Node(float x, float y, float z) {
    super();
    init(x, y, z);
  }

  void init(float x, float y, float z) {
    target = new PVector(x, y, z);
    velocity = new PVector();
    vel = random(0.6, 0.82);
    elastic = random(0.01, 0.014);
  }

  void update() {

    PVector aux = new PVector(target.x-x, target.y-y, target.z-z);
    velocity.add(aux);
    velocity.mult(vel);

    add(velocity);
  }

  PVector copy() {
    return new PVector(x, y, z);
  }

  PVector copyTarget() {
    return new PVector(target.x, target.y, target.z);
  }
}

class Line {
  boolean remove;
  Node n1, n2;
  Line(Node n1, Node n2) {
    this.n1 = n1;
    this.n2 = n2;
  } 

  void update() {

    show();
  }

  void show() {
    pushMatrix();
    translate(n1.x, n1.y, n1.z);
    box(4);
    popMatrix();
    pushMatrix();
    translate(n2.x, n2.y, n2.z);
    box(4);
    popMatrix();
    line(n1.x, n1.y, n1.z, n2.x, n2.y, n2.z);
  }

  float getSize() {
    return n1.target.dist(n2.target);
  }
}

