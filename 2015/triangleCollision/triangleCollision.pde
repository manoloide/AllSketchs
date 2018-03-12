float x1, y1, x2, y2, x3, y3;

void setup() {
  size(600, 600);
  generate();
}

void draw() {
  background(240);

  noFill();
  stroke(0, 6);
  for (int i = 6; i > 0; i--) {
    strokeWeight(i);
    triangle(x1, y1, x2, y2, x3, y3);
  }
  noStroke();
  fill(220);
  if (pointInTriangle(mouseX, mouseY, x1, y1, x2, y2, x3, y3)) fill(255, 128, 0);
  triangle(x1, y1, x2, y2, x3, y3);
  fill(30);
  ellipse(x1, y1, 5, 5);
  text("p1", x1+8, y1);
  ellipse(x2, y2, 5, 5);
  text("p2", x2+8, y2);
  ellipse(x3, y3, 5, 5);
  text("p3", x3+8, y3);
}

void keyPressed() {
  generate();
}

void generate() {
  x1 = random(width);
  y1 = random(height);
  x2 = random(width);
  y2 = random(height);
  x3 = random(width);
  y3 = random(height);
}

boolean pointInTriangle(float px, float py, float p0x, float p0y, float p1x, float p1y, float p2x, float p2y) {
  float s = (p0y * p2x - p0x * p2y + (p2y - p0y) * px + (p0x - p2x) * py);
  float t = (p0x * p1y - p0y * p1x + (p0y - p1y) * px + (p1x - p0x) * py);

  if (s <= 0 || t <= 0)
    return false;

  float A = (-p1y * p2x + p0y * (-p1x + p2x) + p0x * (p1y - p2y) + p1x * p2y);
  return (s + t) < A;
}

