class Node {
  ArrayList<Node> nodes;
  float cx, cy;
  float x, y, s;
  float velx, vely, ang;
  Node parent;
  Trend select;
  String name;
  Touch touch;
  Node(Node parent, float x, float y, String name) {
    this.parent = parent;
    this.name = name;
    if (parent != null) {
      this.x = parent.x; 
      this.y = parent.y;
      cx = x; 
      cy = y;
      parent.addNode(this);
    } else {
      setPosition(x, y);
    }
    nodes = new ArrayList<Node>();
  }

  void init() {    
    float da = TWO_PI/nodes.size();
    float pa = 0;
    if (parent != null) {
      da = PI*0.6/nodes.size();
      pa = ang-da*(nodes.size()/2.0-0.5);
    }
    float sep = 160;
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n.parent instanceof Trend) 
        n.s = random(10, 20);
      n.setPosition(cos(pa+i*da)*sep, sin(pa+i*da)*sep);
      n.init();
    }
  }

  void update() {
    ang = atan2(y-parent.y, x-parent.x);
  }

  void show() {
  }

  Node getNode(String name) {
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n.name.equals(name)) {
        return n;
      }
    } 
    return null;
  }

  void addNode(Node n) {
    nodes.add(n);
  }

  void setParent(Node parent) {
    this.parent = parent;
  }

  void setPosition(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
    if (parent != null) ang = atan2(y, x);
  }

  void elasticMovement() {
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
        }
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
      float maxDis = pow(500, 5);
      if (dis > maxDis) dis = maxDis;
      tx = map(dis, 0, maxDis, tx+(mouseX-tx)*0.09, tx);
      ty = map(dis, 0, maxDis, ty+(mouseY-ty)*0.09, ty);
    }
    //x += (parent.x+cx-x)*0.12;
    //y += (parent.y+cy-y)*0.12;
    velx += (tx-x)*0.12;
    vely += (ty-y)*0.12;
    velx *= 0.8;
    vely *= 0.8;
    x += velx;
    y += vely;
  }
}

