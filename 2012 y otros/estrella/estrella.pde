color c;
void setup() {
  size(400, 400);
  smooth();
  c = color(0, 50);
}
void draw() {
  fill(c);
  noStroke();
  rect(0, 0, width, height);
  stroke(255);
  estrella(200, 200, 150, 3+(mouseY/20), 1+(mouseX));
}

void estrella(float x, float y, float lar, int puntas, float rotacion) {
  float ang = (2 * PI / puntas);
  rotacion = radians(rotacion);
  int saltar = (puntas - 1)  / 2; 
  for (int i = 1; i <= puntas; i++) {
    float p1x = cos(ang*i+rotacion) * lar + x;
    float p1y = sin(ang*i+rotacion) * lar + y;
    float p2x = cos(ang*(i+saltar)+rotacion) * lar + x;
    float p2y = sin(ang*(i+saltar)+rotacion) * lar + y;
    line(p1x, p1y, p2x, p2y);
  }
}

void mousePressed() {
  c = color(random(255), random(255), random(255), 50);
}

