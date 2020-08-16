class Cell extends Node {
  boolean open;
  Cell(float x, float y, String name) {
    super(null, x, y, name);
    this.x = x; 
    this.y = y;
    this.name = name;
    s = 80;
    nodes = new ArrayList<Node>();
  }

  void update() {
    if (mousePressed || true) {
      s += (512-s)*random(0.4, 0.9)*0.18;
    } else {
      s += (192-s)*random(0.4, 0.9)*0.18;
    }
    elasticMovement();
    show();

    for (int i = 0; i < nodes.size (); i++) {
      nodes.get(i).update();
    }
  }

  void show() {
    noStroke();
    fill(255, 33);
    ellipse(x, y, s, s);

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

    {
      noStroke();
      fill(255);
      rectMode(CENTER);
      float xx = x+map(s, 192, 512, 0, -s*0.5);
      float yy = y+map(s, 192, 512, 0, -s*0.25);
      rect(xx, yy, 80, 80);
    }

    if (select != null && select.text != null) {
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
}

