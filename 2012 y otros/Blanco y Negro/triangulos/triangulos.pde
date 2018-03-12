float x, y;

void setup() {
  size(screen.width, screen.height);
  smooth();
  noStroke();
  fill(255, 10);
  x = width/2;
  y = height/2;
}

void draw() {
  float col = map(dist(mouseX, mouseY, x, y),0,width,0,255);
  fill(col, 20);
  triangulo(x, y, dist(mouseX, mouseY, x, y), map(mouseX, 0, width, -TWO_PI, TWO_PI));
}

void mousePressed() {
  x = mouseX;
  y = mouseY;
}

void triangulo(float x, float y, float rad, float ang) {
  float p1x, p1y, p2x, p2y, p3x, p3y;
  float prob = TWO_PI/3;

  p1x = x + cos(ang) * rad;
  p1y = y + sin(ang) * rad;
  p2x = x + cos(ang+prob) * rad;
  p2y = y + sin(ang+prob) * rad;
  p3x = x + cos(ang+prob*2) * rad;
  p3y = y + sin(ang+prob*2) * rad;

  beginShape();
  vertex(p1x, p1y);
  vertex(p2x, p2y);
  vertex(p3x, p3y);
  endShape(CLOSE);
}

