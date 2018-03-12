ArrayList particulas;

void setup() {
  // badas
  size(600, 600);
  colorMode(HSB);
  noStroke();
  smooth();
  background(0);
  // definir constantes de color
  color VERDE = color(80, 120, 120);
  color AZUL = color(170, 120, 120);
  // definir particulas
  particulas = new ArrayList();
  for (int j = 0; j < height/10; j++) {
    for (int i = 0; i < width/10; i++){
      if (i % 2 != j % 2) {
        particulas.add(new Particula(width/10 * i, height/10 * j, AZUL));
      } 
      else {
        particulas.add(new Particula(width/10 * i, height/10 * j, VERDE));
      }
    }
  }
  fill(VERDE);
  rect(0, 0, width/2, height);
  fill(AZUL);
  rect(width/2, 0, width/2, height);
}
void draw() {
  fill(0);
  rect(0, 0, width, height); 
  for (int i = 0; i < particulas.size(); i++) {
    Particula pro = (Particula) particulas.get(i);
    pro.act();
  }
}

