class Trend extends Node {
  boolean drag;
  boolean textRotate;
  String name, text;
  Trend(Node parent, float x, float y, String name) {
    super(parent, x, y, name);
    this.name = name;
    textRotate = false;
    s = random(36, 52);
  }

  void update() {
    super.update();
    if (touch == null) {
      drag = false;
      touch = touchManager.click(x, y, s/2);
      if (touch != null) parent.select = this;
    }

    if (touch != null) {
      drag = true;
      if (touch.release) {
        if (parent.select == this) {
          parent.select = null;
        }
        touch = null;
      }
    }
    if (drag) {
      x = mouseX;
      y = mouseY;
    } else {
      elasticMovement();
    }

    for (int i = 0; i < nodes.size (); i++) {
      nodes.get(i).update();
    }
  }

  void show() {

    noStroke();
    fill(0, 33);
    ellipse(x, y, s*2.1, s*2.1);
    fill(0);
    ellipse(x, y, s, s);

    if (drag) drawSubNodes();

    fill(255);
    if (textRotate) {
      pushMatrix();
      float dx = cos(ang)*(s*0.5+5);
      float dy = sin(ang)*(s*0.5+5);
      translate(x+dx, y+dy);
      rotate(ang);
      text(name, 0, 0);
      popMatrix();
    } else {
      text(name, x+s*0.5+5, y);
    }
  }

  void drawSubNodes() {
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      strokeWeight(2);
      stroke(0, 255, 0);
      line(x, y, n.x, n.y);
    }

    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n != select) n.show();
    }
    if (select != null)select.show();
  }
}

