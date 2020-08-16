class Trend extends Node {
  PImage imgText;
  float animaTime, animation, animationColor;
  Trend(Node parent, float x, float y, float s, String name) {
    super(parent, x, y, s, name);
    timeHide = int(60*ui.tiempoTrend);
    vs = 0.04;
    animaTime = 50;

    createText();
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
        x = touch.cx;
        y = touch.cy;
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
        active = false;
        toParent = true;
      }
    }
    animation = constrain(animation, 0, 1);
  }

  void show() {
    if (view) drawSubNodes();

    noStroke();
    fill(colorBlack, 33);
    ellipse(x, y, s*2.1, s*2.1);
    fill(colorBlack);
    if (view) {
      /*
      float ani = (time < 20)? time/20. : (timeHide-time)/20.;
       color col = lerpColor(colorBlack, colorGreen, ani);
       fill(col);
       */
      fill(colorGreen);
    } else {
      fill(colorBlack);
    }
    ellipse(x, y, s, s);
  }

  void showText() {  
    float alp = 512*animation-256;
    tint(255, alp); 
    float des = (s*0.5+5);
    float da = 0;
    float angle = ang;
    if (parent instanceof Trend) angle = parent.ang;
    if (angle <= -HALF_PI || angle > HALF_PI) {
      des *= -1;
      des -= imgText.width;
      da = PI;
    }
    if (textRotate) {     
      pushMatrix();
      float dx = cos(ang+da)*des;
      float dy = sin(ang+da)*des;
      translate(x+dx, y+dy);
      rotate(ang+da);
      image(imgText, 0, 0);
      popMatrix();
    } else {
      image(imgText, x+des, y-imgText.height/2);
    }
    noTint();
    /*
    float alp = 512*animation-256;
     fill(colorWhite, alp);
     if (parent instanceof Cell) textFont(fontMedium);
     else textFont(fontMedium2);
     float des = (s*0.5+5);
     float da = 0;
     float angle = ang;
     if (parent instanceof Trend) angle = parent.ang;
     if (angle > -HALF_PI && angle <= HALF_PI) {
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
     
     */

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
      stroke(colorGreen);
      line(x, y, n.x, n.y);
    }

    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n != select) n.show();
    }
    if (select != null)select.show();
  }

  void createText() {
    if (parent instanceof Cell) textFont(fontMedium);
    else textFont(fontMedium2);
    int ww = int(textWidth(name)+2);
    int hh = 12;
    if (parent instanceof Cell) hh = 17;
    PGraphics aux = createGraphics(ww, hh);
    aux.beginDraw();
    if (parent instanceof Cell) aux.textFont(fontMedium);
    else aux.textFont(fontMedium2);
    //aux.background(255, 0, 0);
    aux.fill(255);
    aux.textAlign(LEFT, TOP);
    aux.text(name, 0, 0);
    aux.endDraw();
    imgText = aux.get();
  }
}

