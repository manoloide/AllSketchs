ArrayList ramas, semillas;

void setup() {
  size(400, 600);
  smooth();
  ramas = new ArrayList();
  semillas = new ArrayList();

  semillas.add(new Semilla(200, 500, 100, PI*3/2));
}

void draw() {
  fondo();
  actualizar();
}

void mouseReleased() {  
  for (int i = 0; i < semillas.size();i++) {
    Semilla aux = (Semilla) semillas.get(i);
    if (dist(mouseX, mouseY, aux.x, aux.y) < 5) {
      int cant = int(random(3))+1;
      for (int j = 0; j < cant; j++) {
        float ang = aux.ang + random(-PI/6, PI/6);
        float lar = aux.lar * random(0.7, 0.9);
        float x = aux.x + cos(ang)*lar;
        float y = aux.y + sin(ang)*lar;
        semillas.add(new Semilla(x, y, lar, ang));
        ramas.add(new Rama(aux.x, aux.y, x, y));
      }
      semillas.remove(i);
    }
  }
}

