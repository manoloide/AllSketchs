boolean mapa[][];
int tam = 80;

void setup() {
  size(400, 400);  
  noCursor();

  mapa = generarMapa(width/tam, height/tam);
}

void draw() {
  background(0);
  fill(255);
  for (int j = 0;j < height/tam; j++) {
    for (int i = 0;i < width/tam; i++) {
      if (mapa[i][j]) {
        rect(i*tam, j*tam, tam, tam);
      }
    }
  }
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 5, 5);
  if (mapa[int(mouseX/tam)][int(mouseY/tam)]) {
      mapa = generarMapa(width/tam, height/tam);
    fill(0, 120);
    rect(0, 0, width, height);
  }
}

boolean[][] generarMapa(int w, int h) {
  boolean aux[][] = new boolean[w][h];
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      if (random(2) < 1) {
        aux[i][j] = true;
      }
      else {
        aux[i][j] = false;
      }
    }
  }
  return aux;
}

