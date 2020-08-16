class Trend extends Node {
  boolean textRotate;
  float animaTime, animation;
  Trend(Node parent, float x, float y, float s, String name) {
    super(parent, x, y, s, name);
    timeHide = int(60*ui.tiempoTrend);
    textRotate = false;
    vs = 0.04;
    animaTime = 50;
  }

  void update() {
    super.update();

    timeHide = int(60*ui.tiempoTrend);

    if (click && text != null) {
      textView.setTrend(this);
    }

    if (toParent) {
      x += (parent.x-x)*0.2;
      y += (parent.y-y)*0.2;
      s *= 0.8;
    } else {
      if (drag) {
        x = touch.x;
        y = touch.y;
      } else {
        elasticMovement();
      }
    }

    if (view) {
      for (int i = 0; i < nodes.size (); i++) {
        nodes.get(i).update();
      }
    }
    animation = 1;
    if (parent.time < animaTime) {
      animation = map(parent.time, 0, animaTime, 0, 1);
    }
    if (timeLive < animaTime) {
      animation = map(timeLive, 0, animaTime, 0, 1);
    } else {
      if (animation < 0.3) {
        toParent = true;
      }
    }
    animation = constrain(animation, 0, 1);
  }

  void show() {
    if (view) drawSubNodes();

    noStroke();
    fill(0, 33);
    ellipse(x, y, s*2.1, s*2.1);
    fill(0);
    if (view) {
      fill(#BCFF00);
    } else {
      fill(0);
    }
    ellipse(x, y, s, s);
  }

  void showText() {
    float alp = 512*animation-256;
    fill(255, alp);
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

    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n != select) n.showText();
    }
    if (select != null)select.showText();
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

