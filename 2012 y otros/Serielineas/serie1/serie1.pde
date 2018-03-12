float ang, lar = 300;

void setup() {
  size(800, 800);
  background(0);
  stroke(255, 20);
}

void draw() {
  ang  += 0.03;
  line(mouseX + cos(ang) * lar, mouseY + sin(ang) * lar, mouseX - cos(ang) * lar, mouseY - sin(ang) * lar);
}
/*
void mousePressed() {
  saveFrame("dib-####.png");
}
*/
