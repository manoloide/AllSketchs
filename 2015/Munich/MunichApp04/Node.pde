class Node {
  ArrayList<Node> nodes;
  boolean click, drag, view;
  float cx, cy;
  float x, y, s;
  float maxDist;
  float velx, vely, ang;
  int timeHide, time;
  Node parent, select;
  String name, text;
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
    view = false;
    maxDist = 400;
    nodes = new ArrayList<Node>();
  }

  void init() {    
    float da = TWO_PI/nodes.size();
    float pa = 0;
    if (parent != null) {
      da = PI*0.6/nodes.size();
      pa = ang-da*(nodes.size()/2.0-0.5);
    }
    for (int i = 0; i < nodes.size (); i++) {
      float sep = 180+random(20);
      Node n = nodes.get(i);
      if (n.parent instanceof Trend) 
        n.s = 20-random(4);
      n.setPosition(cos(pa+i*da)*sep, sin(pa+i*da)*sep);
      n.init();
    }
  }

  void update() {
    click = false;
    if (touch == null) {
      touch = touchManager.click(x, y, s/2);
      if (touch != null) {
        click();
      }
    }
    if (touch != null) {
      if (touch.release) {
        release();
      }
    }

    if (parent == null) ang = atan2(y, x);
    else ang = atan2(y-parent.y, x-parent.x);

    if (drag) {
      float d = 0;
      if (parent != null) d = dist(x, y, cx+parent.x, cy+parent.y);
      if (d > maxDist) {
        release();
      }
    }
    if (view && !drag && select == null) {
      if (time > 0) time--;
      if (time <= 0) {
        view = false;
      }
    }
  }

  void show() {
  }

  void click() {
    if (parent != null) parent.select = this;
    click = true;
    drag = true;
    if (!view) {
      view = true;
      for (int i = 0; i < nodes.size (); i++) {
        Node n = nodes.get(i);
        n.x = x+random(-1, 1);
        n.y = y+random(-1, 1);
      }
    }
  }

  void release() {
    if (parent != null && parent.select == this) {
      parent.select = null;
    }
    drag = false;
    touch = null;
    resetTime();
  }

  void resetTime() {
    time = timeHide;
    if (parent != null) parent.resetTime();
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
        if (n != this && dis < n.s*1.4) {
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
    //remplazar por multi touch con un vector
    force = new PVector(0, 0);
    for (int i = 0; i < touchManager.touchs.size (); i++) {
      Touch t = touchManager.touchs.get(i);
      float dis = dist(tx, ty, t.x, t.y);
      dis = pow(dis, 5);
      float maxDis = pow(400, 5);
      if (dis < maxDis) {
        force.x += map(dis, 0, maxDis, (t.x-tx)*0.07, 0);
        force.y += map(dis, 0, maxDis, (t.y-ty)*0.07, 0);
      }
    }
    tx += force.x;
    ty += force.y;
    /*
    if (mousePressed) {
     float dis = dist(tx, ty, mouseX, mouseY);
     dis = pow(dis, 5);
     float maxDis = pow(400, 5);
     if (dis > maxDis) dis = maxDis;
     tx = map(dis, 0, maxDis, tx+(mouseX-tx)*0.07, tx);
     ty = map(dis, 0, maxDis, ty+(mouseY-ty)*0.07, ty);
     }
     */
    //x += (parent.x+cx-x)*0.12;
    //y += (parent.y+cy-y)*0.12;
    velx += (tx-x)*0.06;
    vely += (ty-y)*0.06;
    velx *= 0.82;
    vely *= 0.82;
    x += velx;
    y += vely;
  }
}

