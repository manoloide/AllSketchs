int contador, posX, posY;
boolean click = false;

void setup() {
  size(400, 400);
  contador = 0;
}

void draw() {
  if (click) {
    ellipse(posX, posY, contador, contador);
    contador++;
    if (contador > 100) {
      contador = 0;
      click = false;
    }
  }
}

void mousePressed() {
  if (!click) {
    click = true;
    posX = mouseX;
    posY = mouseY;
  }
}

