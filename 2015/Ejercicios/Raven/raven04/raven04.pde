ArrayList<Node> nodes; 

void setup() {
  size(960, 960, P3D);
  generate();
}

void draw() {
  background(250);

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
  if (key == 's') saveImage();
  generate();
}

void generate() {
  nodes = new ArrayList<Node>();

  int cc = 12; 
  int ss = 50; 

  int tt = cc*ss;
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        Node n = new Node(i*ss-tt/2, j*ss-tt/2, k*ss-tt/2);
        nodes.add(n);
        if (i > 0) n.add(nodes.get((i-1)+j*cc+k*cc*cc));
        if (j > 0) n.add(nodes.get(i+(j-1)*cc+k*cc*cc));
        if (k > 0) n.add(nodes.get(i+j*cc+(k-1)*cc*cc));
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Node {
  ArrayList<Node> brothers;
  float vel, elastic, centerDistance;
  PVector position, target;
  PVector velocity, force;
  Node(float x, float y, float z) {
    position = new PVector();
    target = new PVector(x, y, z);
    brothers = new ArrayList<Node>();
    velocity = new PVector();
    force = new PVector();
    vel = random(0.6, 0.82);
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

