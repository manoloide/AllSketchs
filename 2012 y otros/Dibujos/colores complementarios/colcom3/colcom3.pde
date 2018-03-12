int col;
void setup() {
  size(600, 600); 
  colorMode(HSB);
  smooth();
  noStroke();
  iniciar();
}

void draw() {
  //limpiar...
  fill((col+128)%256, 215, 255, 2);
  rect(0, 0, width, height);
  //dibujar puntos...
  for (int i = 0; i < random(9); i++) {
    float grosor = random(4, 10);
    fill(color(col, 200, random(100, 180)));
    ellipse(random(width), random(height), grosor, grosor);
  }
  //dibujar puntero
  float grosor = random(20,100);
  fill(color(col,200,random(100,180)));
  ellipse(mouseX,mouseY,grosor,grosor);
  //cambio de color
  col += int(random(-1, 2));
  col = col%256;
}

void keyPressed() {
  if (key == 'r') {
    iniciar();
  }
}

void iniciar() {
  col = int(random(256));
  background((col+128)%256, 215, 255);
}

