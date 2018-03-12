class Cell extends Node {
  Cell(float x, float y, String name) {
    super(null, x, y, name);
    this.x = x; 
    this.y = y;
    this.name = name;
    s = 192;
    timeHide = 60*10;
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
      noStroke();
      fill(255);
      rectMode(CENTER);
      float xx = x+map(s, 192, 512, 0, -s*0.5);
      float yy = y+map(s, 192, 512, 0, -s*0.25);
      rect(xx, yy, 80, 80);
    }

    if (select != null && select.text != null) {
      drawText();
    }
  }

  void drawText() {
    int w = 348;
    int h = 456;
    int xx = width-w-22;
    int yy = 59;
    stroke(0);
    strokeWeight(3);
    line(xx, yy+2, select.x, select.y);
    noStroke();
    fill(0);
    rectMode(CORNER);
    rect(xx, yy, w, h);
    fill(255);
    text(select.name, xx+13, yy+32);
    text(select.text, xx+13, yy+58, w-13*2, w);
  }
}

