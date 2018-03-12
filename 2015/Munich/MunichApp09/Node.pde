class Node {
  ArrayList<Node> nodes;
  boolean active, click, drag, view, closeAll, toParent;
  boolean textRotate;
  float cx, cy, cs;
  float x, y, s;
  float vs;
  float maxDist;
  float velx, vely, ang;
  int id;
  int timeHide, time, timeLive;
  Node parent, select;
  String name, text;
  Touch touch;
  Node(Node parent, float x, float y, float s, String name) {
    this.name = name;
    this.cs = s;
    s = 0;
    if (parent != null) {
      setParent(parent);
      this.x = parent.x; 
      this.y = parent.y;
      cx = x; 
      cy = y;
      parent.addNode(this);
    } else {
      setPosition(x, y);
    }
    view = false;
    maxDist = ui.distanciaDragueo;
    vs = 0.08;
    nodes = new ArrayList<Node>();
  }

  void init() {    
    float da = TWO_PI/nodes.size();
    float pa = da*0.25;
    if (parent != null) {
      da = PI*0.6/nodes.size();
      if (textRotate) da *= 0.82;
      pa = ang-da*((nodes.size()/2.0)-0.5);
      if (textRotate && nodes.size()%2 == 1) pa += (ang <= -HALF_PI || ang > HALF_PI)? da*-0.25 : da*0.25;
      if (parent instanceof Cell) {
        cs += (nodes.size()-3)*6;
      }
    }
    float sep = map(nodes.size(), 1, 8, 90, 170);
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      n.setPosition(cos(pa+i*da)*sep, sin(pa+i*da)*sep);
      if (textRotate) n.textRotate = true;
      n.init();
    }
  }

  void update() {
    maxDist = ui.distanciaDragueo;

    click = false;
    if (touch == null && active) {
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

    float ds = 1;
    if (this instanceof Trend) {
      if (view) ds += 0.3;
      if (drag ) ds += 0.2;
    }
    s += (cs*ds-s)*vs;

    calculateAngle();

    if (drag) {
      float d = 0;
      if (parent != null) d = dist(x, y, cx+parent.x, cy+parent.y);
      if (d > maxDist) {
        release();
      }
    }
    if (view && !drag && checkNodesOpen()) {
      if (time > 0) time--;
      if (time <= 0) {
        if(parent == null) soundManager.closeCell.trigger();
        view = false;
      }
    }
    timeLive++;
  }

  void show() {
  }

  void showText() {
  }

  void click() {
    if (parent != null) parent.select = this;
    click = true;
    drag = true;
    if (!view || true) {
      if (!view) {
        if (parent == null) soundManager.openCell.trigger();
        if (parent instanceof Cell) soundManager.openNode.trigger();
        if (parent instanceof Trend)soundManager.openSubnode.trigger();
      }
      view = true;
      for (int i = 0; i < nodes.size (); i++) {
        Node n = nodes.get(i);
        if (!n.active) {
          if (n.s < 1) {
            n.x = x+random(-1, 1);
            n.y = y+random(-1, 1);
          }
          n.s = 0;
          n.timeLive = 0;
          n.toParent = false;
          n.active = true;
        }
      }
      if (parent instanceof Cell) addJsonTouch(name);
    }
    resetTime();
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
    calculateAngle();
  }

  void calculateAngle() {
    ang = atan2(cy, cx);
  }

  boolean checkNodesOpen() {
    closeAll = true;
    if (textView.select == this) {
      closeAll = false;
    } else {
      for (int i = 0; i < nodes.size (); i++) {
        if (nodes.get(i).view) {
          closeAll = false;
          break;
        }
      }
    }
    return closeAll;
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
    if (toParent) {
      tx = parent.x;
      ty =  parent.y;
    }

    force = new PVector(0, 0);
    for (int i = 0; i < touchManager.touchs.size (); i++) {
      Touch t = touchManager.touchs.get(i);
      float dis = dist(tx, ty, t.x, t.y);
      dis = pow(dis, 5);
      float maxDis = pow(400, 5);
      if (dis < maxDis) {
        force.x += map(dis, 0, maxDis, (t.x-tx)*ui.atraccionTouch, 0);
        force.y += map(dis, 0, maxDis, (t.y-ty)*ui.atraccionTouch, 0);
      }
    }
    tx += force.x;
    ty += force.y; 

    velx += (tx-x)*0.04;
    vely += (ty-y)*0.04;
    velx *= 0.82;
    vely *= 0.82;
    x += velx;
    y += vely;
  }
}

