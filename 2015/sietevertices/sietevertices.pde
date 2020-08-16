import peasy.*;

PeasyCam cam;

ArrayList<Node> nodes;
float distance = 24;

void setup() {
  size(800, 600, P3D);

  generate();

  noStroke();
  fill(255);

  cam = new PeasyCam(this, 600);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(20000);
}

void draw() {
  //randomSeed(10);
  background(0);
  lights();
  stroke(30);
  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.updateMovement();
  }

  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
    n.showFill();
  }
}

void keyPressed() {
  generate();
}

void generate() {
  nodes = new ArrayList<Node>();
  Node n = new Node(random(-100, 100), random(-100, 100), random(-100, 100));
  nodes.add(n);
  for (int i = 0; i < 7; i++) {
    Node an = new Node(random(-100, 100), random(-100, 100), random(-100, 100));
    nodes.add(an);
    an.connect(n);
  }

  ArrayList<Node> aux = new ArrayList<Node>();
  for (int i = 0; i < 7; i++) {
    Node an = nodes.get(i+1);
    aux.add(an);
    int ant = (7+i-1)%7+1;
    an.connect(nodes.get(ant));
  }

  int itte = 4;

  while (itte > 0) {
    itte--;
    ArrayList<Node> aux2 = new ArrayList<Node>();
    for (int i = 0; i < aux.size (); i++) {
      Node an = aux.get((aux.size ()+i-1)%aux.size ());
      Node nn = aux.get(i);
      PVector dir = nn.dir();
      for (int j = 0; j < 3; j++) {
        Node a = new Node(nn.pos.x+dir.x, nn.pos.y+dir.y, nn.pos.z+dir.z);
        nodes.add(a);
        aux2.add(a);
        nn.connect(a);
        if (j == 0) {
          an.connect(a);
        }
      }
    }

    aux.clear();

    for (int i = 0; i < aux2.size (); i++) {
      Node an = aux2.get(i);
      int ant = (aux2.size()+i-1)%aux2.size();
      an.connect(aux2.get(ant));
      aux.add(an);
    }

    for (int j = 0; j < 30; j++) {
      for (int i = 0; i < nodes.size (); i++) {
        Node aa = nodes.get(i);
        aa.updateMovement();
      }

      for (int i = 0; i < nodes.size (); i++) {
        Node aa = nodes.get(i);
        aa.update();
      }
    }
  }
}

class Node {
  ArrayList<Node> brothers;
  color col;
  PVector pos, des;
  Node(float x, float y, float z) {
    pos = new PVector(x, y, z);
    brothers = new ArrayList<Node>();
    des = new PVector();

    col = color(random(256), random(256), random(256));
  }

  void updateMovement() {
    des = new PVector();
    for (int i = 0; i < brothers.size (); i++) {
      Node n = brothers.get(i);
      float dis = pos.dist(n.pos);
      float vel = (dis-distance)*0.1;
      PVector vec = new PVector(n.pos.x, n.pos.y, n.pos.z);
      vec.sub(pos);
      vec.normalize();
      vec.mult(vel); 
      des.add(vec);
    }
    /*
    float det = 0.5;
     float amp = 2;
     des.add(new PVector((noise(pos.x*det)-0.5)*amp, (noise(pos.y*det)-0.5)*amp, (noise(pos.z*det)-0.5)*amp));
     */
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (brothers.contains(n)) continue;
      float dis = pos.dist(n.pos);
      if (dis < distance*1.4) {
        float vel = (dis-distance*1.4)*0.2;
        PVector vec = new PVector(n.pos.x, n.pos.y, n.pos.z);
        vec.sub(pos);
        vec.normalize();
        vec.mult(vel); 
        des.add(vec);
      }
    }
  }

  void update() {
    pos.add(des);
  }

  void showFill() {
    for (int i = 0; i < brothers.size (); i++) {
      Node b = brothers.get(i);
      for (int j = 0; j < b.brothers.size (); j++) {
        Node a = b.brothers.get(j);
        if (brothers.contains(a)) {
          beginShape();
          fill(col);
          vertex(pos.x, pos.y, pos.z);
          fill(a.col);
          vertex(a.pos.x, a.pos.y, a.pos.z);
          fill(b.col);
          vertex(b.pos.x, b.pos.y, b.pos.z);
          endShape(CLOSE);
        }
      }
    }
  }

  void showStroke() {
    stroke(220);
    for (int i = 0; i < brothers.size (); i++) {
      Node b = brothers.get(i);
      line(pos.x, pos.y, pos.z, b.pos.x, b.pos.y, b.pos.z);
    }
  }

  PVector dir() {
    PVector dir = new PVector();
    for (int i = 0; i < brothers.size (); i++) {
      PVector aux = new PVector(pos.x, pos.y, pos.z);
      aux.sub(brothers.get(i).pos);
      dir.add(aux);
    }
    dir.normalize();
    return dir;
  }

  void connect(Node n) {
    if (!brothers.contains(n)) {
      brothers.add(n);
      n.connect(this);
    }
  }
}

