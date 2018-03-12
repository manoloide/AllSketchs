ArrayList<Pulga>pulgas;

void setup() {
  size(800, 600);
  pulgas = new ArrayList<Pulga>();
  for (int i = 0; i < 40; i++) {
    pulgas.add(new Pulga(random(width), random(height)));
  }
}

void draw() {
  background(255);
  for (int i = 0; i < pulgas.size(); i++) {
    Pulga aux = pulgas.get(i);
    aux.act();
    if (aux.eliminar) {
      pulgas.remove(i--);
    }
  }
}

class Pulga {
  boolean eliminar, viva;
  int tiempo; 
  float x, y, tam;
  Pulga(float x, float y) {
    this.x = x; 
    this.y = y;
    tam = 4;
    tiempo = int(random(60, 1000));
    eliminar = false;
    viva = true;
  }
  void act() {
    tiempo--;
    if (viva) {
      if (tiempo <= 0) saltar();
      float dis = dist(x, y, mouseX, mouseY);
      if (dis < tam) {
        if (random(100) < 10) saltar();
        else if (mousePressed) {
          viva = false;
          tiempo = int(random(60, 260));
        }
      }
    }
    else {
      if(tiempo <= 0){
         eliminar = true; 
      }
    }
    dibujar();
  }
  void saltar() {
    float rang = random(TWO_PI);
    float rdis = random(40, 200);
    x += cos(rang)*rdis;
    y += sin(rang)*rdis;
    tiempo = int(random(60, 1000));
  }
  void dibujar() {
    noStroke();
    if (viva) {
      fill(0);
      ellipse(x, y, tam, tam);
    }
    else {
      fill(255, 0, 0);
      ellipse(x, y, tam*2, tam*2);
    }
  }
}
