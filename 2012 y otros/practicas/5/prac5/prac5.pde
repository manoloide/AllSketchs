int contador, posX, posY;
float con2, con3, maxValor;
boolean click = false;

void setup() {
  size(400, 400);
  noFill();
  contador = 0;
  con2 = 0;
  con3 = 0;
}

void draw() {
  background(200);
  if (click) {
    stroke(0, map(contador, 0, maxValor, 255, 0));
    ellipse(posX, posY, contador, contador);
    stroke(0, map(con2, 0, maxValor, 255, 0));
    ellipse(posX, posY, con2, con2);
    stroke(0, map(con3, 0, maxValor, 255, 0));
    ellipse(posX, posY, con3, con3);
    contador++;
    con2 += random(0.4, 0.8);
    con3 += random(0.6, 1);
    if (contador > maxValor && con3 > maxValor && con2 > maxValor) {
      click = false;
    }
  }
}

void mousePressed() {
  if (!click) {
    click = true;
    contador = 0;
    con2 = 0;
    con3 = 0;
    posX = mouseX;
    posY = mouseY;
    maxValor = random(50,100);
  }
}

