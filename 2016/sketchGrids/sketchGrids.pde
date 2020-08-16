ArrayList<Quad> quads;

void setup() {
  size(1280, 720);
  textFont(createFont("Chivo-Regular", 20, true));
  surface.setResizable(true);
  quads = new ArrayList<Quad>();
}

void draw() {
  background(#F7F6ED);

  grid(20);
  gridBox(80, 20);
  for (int i = 0; i < quads.size(); i++) {
    quads.get(i).update();
  }
  noStroke();
  fill(255);
  rect(0, 0, width, 20);
}

void mousePressed() {
  Quad quad = new Quad();
  quads.add(quad);
  quad.p1 = new PVector(mouseX+10-(mouseX-10)%20, mouseY+10-(mouseY-10)%20);
  quad.p2 = new PVector(mouseX+10-(mouseX-10)%20, mouseY+10-(mouseY-10)%20);
}

void mouseDragged() {
  Quad quad = quads.get(quads.size()-1);
  quad.p2 = new PVector(mouseX+10-(mouseX-10)%20, mouseY+10-(mouseY-10)%20);
}

class Quad {
  int w, h;
  PVector p1, p2;
  Quad() {
    p1 = new PVector();
    p2 = new PVector();
  }
  void update() {
    w = (int)abs(p1.x-p2.x);
    h = (int)abs(p1.y-p2.y);
    if (w > 0 && h > 0)
      show();
  }
  void show() {
    stroke(180, 150);
    fill(255, 80);
    rectMode(CORNERS);
    rect(p1.x, p1.y, p2.x, p2.y);
    PVector c = p1.copy();
    c.add(p2);
    c.mult(0.5);
    textAlign(CENTER, CENTER);
    fill(100);
    text(w+"x"+h, c.x, c.y);
    rectMode(CORNER);
  }
}

void grid(int sep) {
  stroke(0, 20);
  for (int i = 0; i < width; i+=sep) {
    line(i, 0, i, height);
  }
  for (int i = 0; i < height; i+=sep) {
    line(0, i, width, i);
  }
}

void gridBox(int ss, int sep) {
  stroke(0, 20);
  fill(0, 80, 255, 40);
  for (int i = 0; i < width; i+=sep+ss) {
    rect(i, 0, ss, height);
  }
}