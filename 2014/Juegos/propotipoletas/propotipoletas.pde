ArrayList<Ficha> fichas;

void setup() {
  size(600, 600);
  colorMode(HSB, 256);
  reset();
  noStroke();
}


void draw() {
  background(0);
  for (int i = 0; i < fichas.size(); i++) {
    Ficha aux = fichas.get(i);
    aux.act();
    if (aux.eliminar) fichas.remove(i--);
  }
}

void reset(){
  fichas = new ArrayList<Ficha>();
  for (int j = 0; j < height/60; j++) {
    for (int i = 0; i < width/60; i++) {
      fichas.add(new Ficha(i*60, j*60));
    }
  } 
}

class Ficha {
  boolean eliminar;
  char valor;
  int x, y, t; 
  float h, s, b;
  Ficha(int x, int y) {
    this.x = x; 
    this.y = y;
    generar();
  }
  void act() {
    b--;
    if (b < 0) {
      eliminar = true;
    }
    if (keyPressed && key == valor) {
      generar();
      b = 255;
    }
    dibujar();
  }
  void dibujar() {
    fill(getColor());
    rect(x, y, 60, 60);
    fill(256-h, 256-s, 256-b);
    textSize(40);
    textAlign(CENTER, TOP);
    text(str(valor), x, y, 60, 60);
  }
  void generar() {
    h = random(256);
    s = random(256);
    b = 256;
    valor = char(int((random(97, 123))));
  }
  color getColor() {
    return color(h, s, b);
  }
}
