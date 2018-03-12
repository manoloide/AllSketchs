ArrayList<Particula> particulas;
ArrayList<Generador> generadores;

void setup() {
  size(600, 600);
  smooth();
  particulas = new ArrayList();
  generadores = new ArrayList();
  for (int i = 0; i < random(5,12); i++) {
    generadores.add(new Generador(random(width), random(height)));
  }
  background(0);
}

void draw() {
  noStroke();
  fill(0, 1);
  rect(0, 0, width, height);
  for (int i = 0; i < generadores.size(); i++) {
    generadores.get(i).act();
  }
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    aux.act();
    if (aux.borrar) {
      particulas.remove(i--);
    }
  }
}


color colorComplementario(color col) {
  pushStyle();
  colorMode(HSB);
  float h, s, b, a; 
  h = (hue(col)+128)%256;
  s = saturation(col);
  b = brightness(col);
  a = alpha(col);
  color nue = color(h, s, b, a);
  popStyle();
  return nue;
}

color nuevoColor() {
  pushStyle();
  colorMode(HSB);
  int r, g, b; 
  r = int(random(256));
  g = int(random(256-r, 256));
  int inter = (r+g)/2;
  b = int(random(inter-64, inter+64));
  popStyle();
  return color(r, g, b);
}

class Generador {
  float x, y, tam;
  int cant;
  color col;

  Generador(float x, float y) {
    this.x = x;
    this.y = y;
    cant = int(random(5, 18));
    tam = cant*5;
    col = nuevoColor();
  }

  void act() {
    if (frameCount%60 == 0) {
      particulas.add(new Particula(this, generadores.get(int(random(generadores.size())))));
    }
    dibujar();
  }

  void dibujar() {
    noStroke();
    fill(col);
    ellipse(x, y, tam, tam);
  }
}

class Particula {
  boolean borrar = false;
  Generador padre, destino;
  float x, y, tam, ang, vel;
  color col;
  Particula(float x, float y) {
    this.x = x;
    this.y = y;
    tam = 4;
    ang = random(TWO_PI);
    vel = random(1, 4);
  }

  Particula(Generador padre, Generador destino) {
    this.padre = padre;
    this.destino = destino;
    this.x = padre.x;
    this.y = padre.y;
    this.col = padre.col;
    tam = 4;
    ang = atan2(destino.y-y, destino.x-x);
    vel = random(1, 4);
  }

  void act() {
    mover();
    dibujar();
  }

  void mover() {
    ang = atan2(destino.y-y, destino.x-x);
    ang += radians(random(-10, 10));
    x += cos(ang)*vel;
    y += sin(ang)*vel;

    if (dist(destino.x, destino.y, x, y) < destino.tam/2) {
      borrar = true;
    }
  }

  void dibujar() {
    noStroke();
    fill(col);
    ellipse(x, y, tam, tam);
  }

  void setCol(color col) {
    this.col = col;
  }
}

