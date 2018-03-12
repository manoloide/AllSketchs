class Node {
  ArrayList<Node> nodes;
  boolean drag;
  float cx, cy;
  float x, y, s;
  float ang; 
  Node parent;
  float velx, vely, fric;
  Node(Node parent, float x, float y, float s) {
    this.parent = parent;
    this.x = cx = x;
    this.y = cy = y;
    this.s = s;
    nodes = new ArrayList<Node>();
    if (parent != null) {
      setPosition(x, y);
      parent.addNode(this);
    }
  }

  Node(Node parent, float s) {
    this.parent = parent;
    this.s = s;
    x = parent.x;
    y = parent.y;
    nodes = new ArrayList<Node>();
    if (parent != null) {
      parent.addNode(this);
    }
  }

  void init() {
    float da = TWO_PI/nodes.size();
    float pa = 0;
    if (parent != null) {
      da = PI*0.5/nodes.size();
      pa = ang-da*(nodes.size()/2.0-0.5);
      //if (nodes.size()
    }
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      n.setPosition(cos(pa+i*da)*s*1.2, sin(pa+i*da)*s*1.2);
      n.init();
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
            des = dis*0.5;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          }/* else if (dis > n.s*1.4) {
           des = dis*0.3;
           dx = (n.x-x)/des;
           dy = (n.y-y)/des;
           force.add(-dx, -dy, 0);
           }*/
        }
        for (int i = 0; i < parent.nodes.size (); i++) {
          n = parent.nodes.get(i);
          dis = dist(x, y, n.x, n.y);
          if (n != this && dis < n.s*1.2) {
            des = dis*0.2;
            dx = (n.x-x)/des;
            dy = (n.y-y)/des;
            force.add(dx, dy, 0);
          }
        }
      }

      x -= force.x;
      y -= force.y;

      float tx = cx;
      float ty = cy;
      if (parent != null) {
        tx += parent.x;
        ty += parent.y;
      }
      if (mousePressed) {
        float dis = dist(tx, ty, mouseX, mouseY);
        dis = pow(dis, 5);
        float maxDis = pow(400, 5);
        if (dis > maxDis) dis = maxDis;
        tx = map(dis, 0, maxDis, tx+(mouseX-tx)*0.03, tx);
        ty = map(dis, 0, maxDis, ty+(mouseY-ty)*0.03, ty);
      }
      /*
        x += (parent.x+cx-x)*0.12;
       y += (parent.y+cy-y)*0.12;
       */
      velx += (tx-x)*0.12;
      vely += (ty-y)*0.12;
      velx *= 0.8;
      vely *= 0.8;
      x += velx;
      y += vely;
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

  void setPosition(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
    if (parent != null) ang = atan2(y, x);
  }
}

