ArrayList<Node> nodes;
boolean click;
Node select;
Wire wire;

void setup() {
  size(800, 600); 
  nodes = new ArrayList<Node>();
  wire = new Wire(int(random(width)), int(random(height)), int(random(width)), int(random(height)));
}

void draw() {
  drawBackground();
  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
  }
 // wire.x2 = mouseX;
 // wire.y2 = mouseY;
  wire.update();
  click = false;
}

void keyPressed() {
  wire = new Wire(int(random(width)), int(random(height)), int(random(width)), int(random(height)));

  if (select != null && select.edit) {
    String text = select.text;
    if (keyCode == BACKSPACE) {
      if (text.length() > 0) {
        text = text.substring(0, text.length()-1);
      }
    } else if (keyCode == DELETE) {
      text = "";
    } else if (keyCode == ENTER) {
      select.edit = false;
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      text = text + key;
    }
    select.text = text;
  }
}

void mousePressed() {
  click = true;
  if (mouseEvent.getClickCount() == 2) {
    if (select != null && select.on) {
      select.edit = true;
    } else {
      select = new Node(mouseX, mouseY);
      nodes.add(select);
    }
  }
}

void drawBackground() {
  background(200);
  int tt = 20;
  noStroke();
  fill(220);
  int t = 3;
  for (int j = 0; j < height+tt; j+=tt) {
    for (int i = 0; i < width+tt; i+=tt) {
      ellipse(i, j, t, t);
    }
  }
}

class Wire {
  int x1, y1, x2, y2; 
  Wire(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  void update() {
    if (y1 > y2) {
      int ax = x1;
      int ay = y1;
      x1 = x2;
      y1 = y2;
      x2 = ax;
      y2 = ay;
    }
    show();
  }
  void show() {
    stroke(0, 64);
    line(x1, y1, x2, y2);

    stroke(80);
    float hh = abs(y1-y2)/2;
    line(x1, y1, x1, y1+hh);
    line(x1, y1+hh, x2, y2-hh);
    line(x2, y2, x2, y2-hh);
  }
}

class Node {
  boolean edit, moved, remove;
  boolean on, press; 
  int x, y, w, h;
  String text;
  Node(int x, int y) {
    this.x = x;
    this.y = y;
    w = 50;
    h = 20;
    edit = true;
    text = "dsfsdf";
  }
  void update() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      on = true;
    } else {
      on = false;
    }

    if (click) {
      if (on) {
        select = this;
        moved = true;
      } else {
        if (select == this) {
          select = null;
        }
      }
    }
    if (!mousePressed) {
      x -= x%5;
      y -= y%5;
      moved = false;
    }
    if (moved) {
      x += mouseX-pmouseX;
      y += mouseY-pmouseY;
    }
    show();
  }
  void show() {
    textAlign(LEFT, TOP);
    textSize(16);
    w = int(textWidth(text))+6;

    strokeWeight(1);
    if (this == select) {
      strokeWeight(2);
    }
    stroke(160);
    fill(240);
    rect(x, y, w, h, 3);
    fill(140);
    text(text, x+3, y+1);
  }
}

