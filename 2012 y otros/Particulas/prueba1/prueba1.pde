ArrayList particulas;

void setup() {
  // badas
  size(600, 600);
  colorMode(HSB);
  noStroke();
  background(0);
  // definir constantes de color
  color VERDE = color(80, 120, 120);
  color AZUL = color(170, 120, 120);
  // definir particulas
  particulas = new ArrayList();
  for (int i = 0; i < 50; i++) {
    if (i % 2 == 0) {
      particulas.add(new Particula(random(width), random(height), AZUL));
    } 
    else {
      particulas.add(new Particula(random(width), random(height), VERDE));
    }
  }
  //fill(VERDE);
  //rect(0, 0, width/2, height);
  //fill(AZUL);
  //rect(width/2, 0, width/2, height);
}
void draw() {
  fill(0);
  rect(0, 0, width, height); 
  for (int i = 0; i < particulas.size(); i++) {
    Particula pro = (Particula) particulas.get(i);
    pro.act();
  }
}

