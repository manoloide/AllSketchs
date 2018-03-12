class Node {
  ArrayList<Node> nodes;
  boolean drag;
  float x, y, s; 
  Node parent;
  Node(Node parent, float x, float y) {
    this.parent = parent;
    this.x = x;
    this.y = y;
    s = 8;
    if (parent != null)
      parent.addNode(this);
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
      float dis, des;
      float dx, dy;
      float minDis = 25;
      float ideal = 50;
      float ran = 8;
      float maxDis = 100;
      for (int i = 0; i < base.size (); i++) {
        Node n = base.get(i);
        dis = dist(x, y, n.x, n.y);
        if (n != this) {
          if (dis < ideal-ran) {
            des = dis+2;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          } else if (dis > ideal+ran && dis < maxDis) {
            des = (ideal-dis)*50;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          }
        }
      }
      x -= force.x;
      y -= force.y;
    }

    show();
  }

  void show() {
    noStroke();
    fill(0);
    ellipse(x, y, s, s);
  }

  void addNode(Node n) {
    nodes.add(n);
  }
}

