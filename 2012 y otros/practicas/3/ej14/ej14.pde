void setup() {
  size(600, 600);
  noLoop();
}
void draw() {
  float ang = random(2*PI);
  float dis = random(100);
  point(mouseX + cos(ang) * dis, mouseY + sin(ang) * dis);
}
void mousePressed() {
  loop();
}
void mouseReleased() {
  noLoop();
}

