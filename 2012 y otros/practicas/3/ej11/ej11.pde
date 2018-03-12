float antx = 0;
float anty = 0;

void setup() {
  size(600, 600);
  background(255);
}

void draw() {
}

void mousePressed() {
  line(antx,anty,mouseX,mouseY);
  antx = mouseX;
  anty = mouseY;
}
