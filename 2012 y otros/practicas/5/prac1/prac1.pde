int contador = 0;
boolean click = false;

void setup() {
  size(400, 400);
}

void draw() {
  if (click) {
    ellipse(mouseX, mouseY, contador, contador);
    contador++;
    if (contador > 100) {
      contador = 0;
      click = false;
    }
  }
}

void mousePressed() {
  click = true;
}

