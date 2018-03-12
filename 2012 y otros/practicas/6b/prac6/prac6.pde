int cant = 10;

void setup() {
  size(400, 400);
  noFill();
  smooth();
}

void draw() {
  background(255);
  float ancho, alto;
  for (int i = 0; i < cant; i++) {
    ancho = map(i,0,cant-1,width,10);
    alto = map(i,0,cant-1,40,height);
    ellipse(width/2,height/2,ancho,alto);
  }
}

