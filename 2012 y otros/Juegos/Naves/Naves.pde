Nave n;

void setup() {
  size(600, 600);
  smooth();
  n = new Nave(width/2, height/2);
}
void draw() {
  fondo(); 
  n.act();
}
//enventos del treclado 
void keyPressed() {
  if (keyCode == UP) {
    n.prendido = true;
  }
}
void keyReleased() {
  if (keyCode == UP) {
    n.prendido = false;
  }
}

