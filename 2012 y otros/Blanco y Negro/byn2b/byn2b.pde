int cant = 400;
int filas = 8;
float tam;
void setup() {
  size(400, 400);
  noStroke();
  tam = width/filas;
  background(0);
}

void draw() {
  float x, y;
  fill(0, 20);
  rect(0, 0, width, height);
  noFill();
  stroke(255,20);
  for (int i = 0; i < cant; i++) {
    x = int(random(filas));
    y = random(height);
    ellipse(tam/2+(tam*x),y,tam,tam/random(4,20));
  }
  for (int i = 0; i < cant; i++) {
    x = random(height);
    y = int(random(filas));
    ellipse(x,tam/2+(tam*y),tam/random(4,20),tam);
  }
}

