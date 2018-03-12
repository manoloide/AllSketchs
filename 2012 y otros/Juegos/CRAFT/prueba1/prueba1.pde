color NADA = color(0, 0, 0);
color TIERRA = color(103, 82, 24);
color PIEDRA = color(188, 188, 186);
color HIERRO = color(222, 222, 222);
color ESMERALDA = color(2, 162, 72);

int PROPORCION = 20;

Jugador j;
Mapa m;

void setup() {
  size(600, 600);
  smooth();
  m = new Mapa();
  j = new Jugador(width/2, height/2);
}
void draw() {
  m.draw();
  j.act();
}
void mousePressed() {
  if (mouseButton == RIGHT) {
    j.actDestino();
  }
  if (mouseButton == LEFT) {
    j.picando = true;
  }
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    j.picando = false;
  }
}

