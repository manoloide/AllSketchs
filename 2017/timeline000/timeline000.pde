boolean view;
float x, y, s;

PFont font;
Timeline timeline;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  font = createFont("Supply-Regular.otf", 28, true);
  textFont(font);
  timeline = new Timeline();
}

void draw() {
  timeline.update();
  background(80);

  view = timeline.getBoolean("view");
  x = timeline.getFloat("x");
  y = timeline.getFloat("y");
  s = timeline.getFloat("dim");

  noStroke();
  fill(220);
  if (view) ellipse(x, y, s, s);

  timeline.show();
}

void keyPressed() {
  timeline.keyPressed();
}

void keyReleased() {
  timeline.keyReleased();
}

void mousePressed() {
  timeline.mousePressed();
}

void mouseDragged() {
  timeline.mouseDragged();
}

void mouseReleased() {
  timeline.mouseReleased();
}

void mouseWheel(MouseEvent event) {
  timeline.mouseWheel(event);
}

