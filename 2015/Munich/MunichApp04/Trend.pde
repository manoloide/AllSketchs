class Trend extends Node {
  boolean textRotate;
  Trend(Node parent, float x, float y, String name) {
    super(parent, x, y, name);
    this.name = name;
    s = 36;
    timeHide = 60*2;
    textRotate = true;
  }

  void update() {
    super.update();
    if (click && text != null) {
      textView.setTrend(this);
    }
    if (drag) {
      x = touch.x;
      y = touch.y;
    } else {
      elasticMovement();
    }

    for (int i = 0; i < nodes.size (); i++) {
      nodes.get(i).update();
    }
  }

  void show() {

    if (view) drawSubNodes();

    noStroke();
    fill(0, 33);
    ellipse(x, y, s*2.1, s*2.1);
    fill((view)?#BCFF00:0);
    ellipse(x, y, s, s);

    fill(255);
    if (parent instanceof Cell) textFont(fontMedium);
    else textFont(fontMedium2);
    float des = (s*0.5+5);
    float da = 0;
    if (ang > -HALF_PI && ang <= HALF_PI) {
      textAlign(LEFT, BASELINE);
    } else {
      textAlign(RIGHT, BASELINE);
      des *= -1;
      da = PI;
    }
    if (textRotate) {
      pushMatrix();
      float dx = cos(ang+da)*des;
      float dy = sin(ang+da)*des;
      translate(x+dx, y+dy);
      rotate(ang+da);
      text(name, 0, 0);
      popMatrix();
    } else {
      text(name, x+des, y);
    }
    textAlign(LEFT, BASELINE);
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

