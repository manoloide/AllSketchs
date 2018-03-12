class Cell extends Node {
  boolean textRotate;
  String title;
  Cell(float x, float y, String name) {
    super(null, x, y, name);
    this.x = x; 
    this.y = y;
    this.name = name;
    s = 192;
    timeHide = 60*10;
    title = name.replace(" ", "\n");
  }

  void update() {
    if (view) {
      s += (512-s)*random(0.4, 0.9)*0.18;    
      for (int i = 0; i < nodes.size (); i++) {
        nodes.get(i).update();
      }
      super.update();
    } else {
      s += (192-s)*random(0.4, 0.9)*0.18;  
      super.update(); 
      for (int i = 0; i < nodes.size (); i++) {
        nodes.get(i).update();
      }
    }

    elasticMovement();
    show();
  }

  void show() {
    noStroke();
    fill(255, 33);
    ellipse(x, y, s, s);

    if (view) {
      for (int i = 0; i < nodes.size (); i++) {
        Node n1 = nodes.get(i);
        Node n2 = nodes.get((i+1)%nodes.size());
        strokeWeight(1);
        stroke(255);
        line(n1.x, n1.y, n2.x, n2.y);
      }
      for (int i = 0; i < nodes.size (); i++) {
        Node n = nodes.get(i);
        if (n != select) n.show();
      }
      if (select != null)select.show();
    }
    //cartelito
    { 
      float ww = 109;
      float hh = 100;
      float xx = x+map(s, 192, 512, 0, -s*0.5);
      float yy = y+map(s, 192, 512, 0, -s*0.25);
      fill(255);
      rect(xx-ww/2, yy-hh/2, ww, 2);
      rect(xx-ww/2, yy+hh/2-2, ww, 2);
      textFont(fontTitle);
      textLeading(20);
      text(title, xx-ww/2, yy-11);
    }
  }
}

