ArrayList<Node> base;
boolean mouseClicked;
void setup() {
  size(640, 640);
  base = new ArrayList<Node>();
  for (int i = 0; i < 0; i++) {
    base.add(new Node(null, random(width), random(height)));
  }
}

void draw() {
  println(frameRate, base.size());
  background(255);
  for (int i = 0; i < base.size (); i++) {
    Node n = base.get(i);
    n.update();
  }
  if (mousePressed) {
    base.add(new Node(null, mouseX, mouseY));
  }
  mouseClicked = false;
}

void mousePressed() {
  mouseClicked = true;
}

