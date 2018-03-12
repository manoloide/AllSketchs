boolean mostrarinfo;
Jugador j1;
Nivel n1;
int cant_niv, niv;

void setup() {
  size(400, 400);
  frameRate(60);
  noStroke();
  colorMode(HSB, 256);
  smooth();

  background(0);
  mostrarinfo = false;
  cant_niv = 5;
  niv = 1;
  j1 = new Jugador(-100, -100);
  n1 = new Nivel("niveles/nivel"+niv+".nvl");
  n1.act();
}

void draw() {
  fill(0,0,0,10);
  rect(0,0,width,height);
  //background(0);
  j1.act();
  n1.act();
  if (mostrarinfo) {
    monitor();
  }
}

void keyPressed() {
  if (keyCode == UP) {
    j1.arriba = true;
    j1.tecla = 1;
  }
  if (keyCode == DOWN) {
    j1.abajo = true;
    j1.tecla = 2;
  }
  if (keyCode == LEFT) {
    j1.izquierda = true;
    j1.tecla = 3;
  }
  if (keyCode == RIGHT) {
    j1.derecha = true;
    j1.tecla = 4;
  }
  if (key == 'r') {
    n1.cargar();
  }
  if (key == 'i') {
    mostrarinfo = !mostrarinfo;
  }
}
void keyReleased() {
  if (keyCode == UP)
    j1.arriba = false;
  if (keyCode == DOWN)
    j1.abajo = false;
  if (keyCode == LEFT)
    j1.izquierda = false;
  if (keyCode == RIGHT)
    j1.derecha = false;

  j1.tecla = 0;
  if (j1.arriba)
    j1.tecla = 1;
  if (j1.abajo)
    j1.tecla = 2;
  if (j1.izquierda)
    j1.tecla = 3;
  if (j1.derecha)
    j1.tecla = 4;
}

