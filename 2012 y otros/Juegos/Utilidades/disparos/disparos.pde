ArrayList disparos;

int maximoDisparos = 6;
int tiempoCarga = 500;

float cargar = 0;

void setup() {
  size(400, 600);
  disparos = new ArrayList();
}
void draw() {
  background(0);
  for (int i = 0; i < disparos.size(); i++) {
    Disparo aux = (Disparo) disparos.get(i);
    aux.act();
    if (aux.y < 20) {
      disparos.remove(i);
      i--;
    }
  }
  //
  if (cargar != 0) {
    cargar -= frameRate;
    if (cargar < 0) {
      cargar = 0;
    }
  }
}
void mousePressed() {
  if (disparos.size() < maximoDisparos && cargar == 0) {
    disparos.add(new Disparo(mouseX, mouseY));
    cargar = tiempoCarga;
  }
}

class Disparo {
  float x, y;
  Disparo(float nx, float ny) {
    x = nx;
    y = ny;
  } 
  void act() {
    y -= 3;
    draw();
  }  

  void draw() {
    fill(255, 230, 20);
    ellipse(x, y, 5, 5);
  }
}

