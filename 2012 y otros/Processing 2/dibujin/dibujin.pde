PGraphics p;
boolean press;

void setup() {
  size(600, 600);
  p = createGraphics(600, 600);
}

void draw() {
  background(255);
  p.beginDraw();
  if (press) {
    p.line(mouseX, mouseY, pmouseX, pmouseY);
  }
  p.endDraw();
  image(p, 0, 0);
}

void mousePressed() {
  press = true;
}

void mouseReleased() {
  press = false;
}

