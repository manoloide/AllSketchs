ArrayList<Circle> circles;
void setup() {
  size(600, 600);
  circles = new ArrayList<Circle>();
}

void draw() {
  background(240); 

  for (int i = 0; i < circles.size (); i++) {
    Circle c = circles.get(i);
    c.update();
    for (int j = i+1; j < circles.size (); j++) { 
      Circle c2 = circles.get(j);
      if (dist(c.x, c.y, c2.x, c2.y) < 160) {
        stroke(80);
        line(c.x, c.y, c2.x, c2.y);
      }
    }
  }
}

void mousePressed() {
  circles.add(new Circle(mouseX, mouseY));
}

