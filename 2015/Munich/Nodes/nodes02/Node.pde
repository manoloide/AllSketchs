class Node {
  ArrayList<Node> nodes;
  boolean drag;
  float x, y, s; 
  Node parent;
  Node(Node parent, float x, float y, float s) {
    this.parent = parent;
    this.x = x;
    this.y = y;
    this.s = s;
    nodes = new ArrayList<Node>();
    if (parent != null) {
      println("dadsa");
      parent.addNode(this);
    }
  }

  Node(Node parent, float s) {
    this.parent = parent;
    this.s = s;
    x = parent.x+random(5);
    y = parent.y+random(5);
    nodes = new ArrayList<Node>();
    if (parent != null) {
      parent.addNode(this);
    }
  }

  void update() {
    if (mouseClicked) {
      if (dist(mouseX, mouseY, x, y) < s*0.5) {
        drag = true;
      }
    }
    if (!mousePressed) {
      drag = false;
    }
    if (drag) {
      x = mouseX;
      y = mouseY;
    } else {
      PVector force = new PVector(0, 0);
      if (parent != null) {
        Node n = parent;
        float dis, des, dx, dy;
        dis = dist(x, y, n.x, n.y);
        if (n != this) {
          if (dis < n.s*1.1) {
            des = dis*0.1;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          } else if (dis > n.s*1.2) {
            des = dis*0.3;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(-dx, -dy, 0);
          }
        }
        for (int i = 0; i < parent.nodes.size (); i++) {
          n = parent.nodes.get(i);
          dis = dist(x, y, n.x, n.y);
          if (n != this && dis < n.s*1.4) {
            des = dis*0.5;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          }
        }
      }
      x -= force.x;
      y -= force.y;
    }

    for (int i = 0; i < nodes.size (); i++) {
      nodes.get(i).update();
    }

    show();
  }

  void show() {
    noStroke();
    fill(0, 120);
    ellipse(x, y, s, s);
  }

  void addNode(Node n) {
    nodes.add(n);
  }
}

