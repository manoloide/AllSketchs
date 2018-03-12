final int tam = 20;
PImage c1;

void setup() {
  cargarImg();
  size(400, 400);
  noStroke();
  for (int y = 0; y < width/tam; y++) {
    for (int x = 0; x < height/tam; x++) {
      fill(random(256));
      rect(x*tam, y*tam, x*tam+tam, y*tam+tam);
      image(c1,x*tam, y*tam);
    }
  }
}
//carga todas las imagenes.
void cargarImg(){
  c1 = loadImage("imagenes/c2.png");
}

