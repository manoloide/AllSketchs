void setup() {
  size(400, 400);
}
void draw() {
  float variacion = map(mouseY, 0, height, 255, 0);
  stroke(variacion,255,variacion);
  line(0,mouseY, width, mouseY);
}

