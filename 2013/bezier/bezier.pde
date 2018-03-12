Nodo p1, p2, p3, p4;

void setup() {
  size(800, 600);
  p1 = new Nodo(200, 200);
  p2 = new Nodo(200, 300);
  p3 = new Nodo(300, 200);
  p4 = new Nodo(300, 300);
}

void draw() {
  background(255);
  p1.act();
  p2.act();
  p3.act();
  p4.act();
  stroke(0);
  noFill();
  bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
  stroke(0, 150, 255);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p3.x, p3.y, p4.x, p4.y);
}

void mousePressed() {
  if (dist(p1.x, p1.y, mouseX, mouseY)<4) {
    p1.sel = true;
  }
  if (dist(p2.x, p2.y, mouseX, mouseY)<4) {
    p2.sel = true;
  }
  if (dist(p3.x, p3.y, mouseX, mouseY)<4) {
    p3.sel = true;
  }
  if (dist(p4.x, p4.y, mouseX, mouseY)<4) {
    p4.sel = true;
  }
}

void mouseReleased() {
  p1.sel = false;
  p2.sel = false;
  p3.sel = false;
  p4.sel = false;
}

class Nodo {
  boolean sel;
  float x, y;
  Nodo(float x, float y) {
    this.x = x;
    this.y = y;
    sel = false;
  }
  void act() {
    if (sel) {
      x = mouseX;
      y = mouseY;
    } 
    dibujar();
  }
  void dibujar() {
    fill(0, 150, 255);
    stroke(0, 150, 255);
    ellipse(x, y, 4, 4);
  }
}

