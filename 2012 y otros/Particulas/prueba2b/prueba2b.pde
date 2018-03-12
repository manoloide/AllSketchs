Particula p;

void setup() {
  // badas
  size(600, 600);
  colorMode(HSB);
  noStroke();
  smooth();
  background(0);
  // definir constantes de color
  color VERDE = color(80, 120, 120);
  // definir particulas
  p = new Particula(width/2, height/2, VERDE);
}
void draw() {
  fill(0);
  rect(0, 0, width, height); 
  p.act();
}

