ArrayList<Particula> particulas;

void setup() {
  size(800, 600);
  noStroke();
  background(0);
  particulas = new ArrayList<Particula>();
}

void draw() {
  fill(0, 30);
  rect(0, 0, width, height);
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    aux.act() ;
    if (aux.eliminar) {
      particulas.remove(i--);
    }
  }
  if(frameCount%60 == 0){
     println(particulas.size() + " " + frameRate); 
  }
  //particulas.add(new Particula(mouseX, mouseY));
}

void mousePressed() {
  particulas.add(new Particula(mouseX, mouseY, 14));
}

class Particula {
  color col;
  boolean eliminar;
  int x, y, tiempo, a, tam;
  float xa, ya, xx, yy;
  Particula(int x, int y, int tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    col = color(random(255), random(255), random(255));
    a = int(random(50, 100));
    xx = 0;
    yy = 0;
    xa = random(-5, 5);
    ya = random(-3, -0.5);
    eliminar = false;
    tiempo = int(random(40, 80));
  }

  void act() {
    xa *= 0.99;
    xx += xa;
    ya += 0.15;
    yy += ya;
    if (yy > a) {
      ya = ya *-1;
    }
    tiempo--;
    if (tiempo < 0) {
      eliminar = true;
      if (tam > 2) {
        int v = int(random(2, 6));
        for (int i = 0; i < v; i++) {
          particulas.add(new Particula(int(x+xx), int(y+yy), tam - int(random(2,6))));
        }
      }
    }
    dibujar();
  }

  void dibujar() {
    fill(col);
    ellipse((int)x+xx, (int)y+yy, tam, tam);
  }
}

