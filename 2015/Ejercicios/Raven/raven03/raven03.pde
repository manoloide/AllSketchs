
ArrayList<Node> nodes;

void setup() {
  size(960, 960, P3D);
  generate();
}


void draw() {
  background(250);
  smooth(4);
  translate(width/2, height/2, -300);
  float vel = 0.2;
  rotateX(frameCount*0.07*vel);
  rotateY(frameCount*0.012*vel);
  rotateZ(frameCount*0.003*vel);

  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.updateMovement();
  }

  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
  }
}

void keyPressed() {
  if(key == 's') saveImage();
  generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  nodes = new ArrayList<Node>();

  float dd = random(180, 320);
  for (int i = 0; i < 800; i++) {
    float a1 = random(TWO_PI);
    float a2 = random(TWO_PI);
    nodes.add(new Node(cos(a1)*cos(a2)*dd, cos(a1)*sin(a2)*dd, sin(a1)*dd));
  }
}


class Node {
  ArrayList<Node> brothers;
  float vel, elastic, centerDistance;
  int amountBrothers;
  PVector position, target;
  PVector velocity, force;
  Node(float x, float y, float z) {
    position = new PVector();
    target = new PVector(x, y, z);
    brothers = new ArrayList<Node>();
    velocity = new PVector();
    force = new PVector();
    vel = random(0.6, 0.82);
    amountBrothers = 5;
    elastic = random(0.01, 0.014);
    centerDistance = target.mag();
  }

  void updateMovement() {
    force = new PVector();
    if (position.dist(target) > 10) return;
    for (int i = 0; i < brothers.size (); i++) {
      Node n = brothers.get(i);
      if (n == this) continue;
      float dis = target.dist(n.target);
      float distance = 20;
      if (dis < distance) {
        float vel = (dis-distance)*0.1;
        PVector vec = new PVector(n.target.x, n.target.y, n.target.z);
        vec.sub(target);
        vec.normalize();
        vec.mult(vel); 
        force.add(vec);
      }
    }

    PVector targetPos = new PVector(target.x, target.y, target.z);
    targetPos.normalize();
    targetPos.mult(centerDistance);
    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    aux.mult(0.1);
    target.add(aux);
  }

  void update() {

    if (brothers.size() < amountBrothers) {
      searchBrother();
    }

    target.add(force);

    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    velocity.add(aux);
    velocity.mult(vel);
    position.add(velocity);

    show();
    stroke(0, 50);
    showConnections();
  }

  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    box(4);
    popMatrix();
  }

  void searchBrother() {
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n == this) continue;
      boolean add = false;
      for (int j = 0; j < brothers.size (); j++) {
        Node b = brothers.get(j);
        if (n.target.dist(target) < b.target.dist(target)) {
          brothers.add(j, n);
          add = true;
          break;
        }
      }
      if (!add && brothers.size() < amountBrothers) {
        brothers.add(brothers.size(), n);
      }
    }
    while (brothers.size () > amountBrothers) {
      brothers.remove(amountBrothers);
    }
  }

  void showConnections() {
    for (int i = 0; i < brothers.size (); i++) {
      Node n = brothers.get(i); 
      line(position.x, position.y, position.z, n.position.x, n.position.y, n.position.z);
    }
  }
  void add(Node n) {
    if (!brothers.contains(n)) {
      brothers.add(n);
    }
  }
}

