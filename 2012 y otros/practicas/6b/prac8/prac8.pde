int cant = 10;

void setup() {
  size(400, 400);
  noStroke();
  smooth();
  rectMode(CENTER);
}

void draw() {
  float ancho = width;
  float alto = height;
  for (int i = 0; i < cant; i++) {
    fill(map(i,0,cant-1,0,255));
    rect(width/2,height/2,ancho,alto);
    fill(map(i,0,cant-1,255,0));
    ellipse(width/2,height/2,ancho,alto);
    ancho = ancho/sqrt(2);
    alto = alto/sqrt(2);
  }
}

