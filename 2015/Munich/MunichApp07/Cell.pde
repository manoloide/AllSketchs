class Cell extends Node {
  String title;
  Cell(float x, float y, float s, String name) {
    super(null, x, y, s, name);
    timeHide = int(60*ui.tiempoCell);
    title = name.replace(" ", "\n");
    vs = 0.1;
    active = true;
  }
  //192, 512, 600
  void update() {

    timeHide = int(60*ui.tiempoCell);
    if (view) {
      if (closeAll) cs = 512;
      else cs = 770;

      for (int i = 0; i < nodes.size (); i++) {
        nodes.get(i).update();
      }
      super.update();
    } else {
      cs = 192; 
      super.update(); 
      for (int i = 0; i < nodes.size (); i++) {
        nodes.get(i).update();
      }
    }

    elasticMovement();
  }

  void show() {
    /*
    noStroke();
     fill(colorWhite, 33);
     ellipse(x, y, s, s);
     */
    pushStyle();
    imageMode(CENTER);
    image(icell, x, y, s, s);
    popStyle();

    if (view) {
      for (int i = 0; i < nodes.size (); i++) {
        Node n1 = nodes.get(i);
        Node n2 = nodes.get((i+1)%nodes.size());
        strokeWeight(1);
        stroke(colorWhite);
        line(n1.x, n1.y, n2.x, n2.y);
      }
      for (int i = 0; i < nodes.size (); i++) {
        Node n = nodes.get(i);
        if (n != select) n.show();
      }
      if (select != null) select.show();
    }
  }

  void showText() { 
    if (view) {
      for (int i = 0; i < nodes.size (); i++) {
        Node n = nodes.get(i);
        if (n != select) n.showText();
      }
      if (select != null) select.showText();
    }
    //if(click) soundManager.openCell.trigger();

    float ww = 109;
    float hh = 100;
    float d = s*0.5+60;
    if (s < 512) d = map(s, 192, 512, 0, d);
    float xx = x+cos(PI*1.25)*d;
    float yy = y+cos(PI*1.25)*d;
    if (s > 192) {
      float alp = map(s, 192, 512, 0, 255);
      tint(255, alp);
      image(icell2, xx-96, yy-96);
      noTint();
    }
    noStroke();
    fill(colorWhite);
    rect(xx-ww/2+1, yy-hh/2, 20, 1);
    rect(xx-ww/2+1, yy+hh/2-2, 20, 1);
    textFont(fontCell);
    textLeading(24);
    textAlign(LEFT, BASELINE);
    text(title, xx-ww/2, yy-15);
  }
}

