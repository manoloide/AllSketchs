class Node {
  boolean drag;
  Cell parent;
  float cx, cy;
  float x, y, s;
  Touch touch;
  String name, text;
  Node(float x, float y, String name) {
    this.name = name;
    setPosition(x, y);
    s = random(36, 52);
  }

  void update() {
    if (touch == null) {
      touch = touchManager.click(x, y, s/2);
      if (touch != null) parent.select = this;
      x += (cx-x)*0.2; 
      y += (cy-y)*0.2;
    }

    if (touch != null) {
      x += (touch.x-x)*0.8; 
      y += (touch.y-y)*0.8;
      if (touch.release) {
        if (parent.select == this) {
          parent.select = null;
        }
        touch = null;
      }
    }
  }

  void show() {
    noStroke();
    fill(0, 33);
    ellipse(x, y, s*2.1, s*2.1);
    fill(0);
    ellipse(x, y, s, s);
    fill(255);
    text(name, x+s*0.5+5, y);
  }

  void setParent(Cell parent) {
    this.parent = parent;
  }

  void setPosition(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
  }
}

