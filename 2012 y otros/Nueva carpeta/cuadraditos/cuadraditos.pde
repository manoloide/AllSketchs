int cuadrados[][];
int tam = 20;

void setup() {
  size(600, 600);
  colorMode(HSB);
  noStroke();
  cuadrados = new int[width/tam][height/tam];
}

void draw() {
  for (int j = 0; j < height/tam; j++) {
    for (int i = 0; i < width/tam; i++) {
      fill(cuadrados[i][j], 200, 255);
      rect(i*tam, j*tam, tam, tam);
      cuadrados[i][j]++;
      cuadrados[i][j] %= 256;
    }
  }
}

void mouseMoved() {
  int x = int(map(mouseX, 0, width, 0, width/tam));
  int y = int(map(mouseY, 0, height, 0, height/tam));
  cuadrados[x][y] += 4;
  cuadrados[x][y] %= 256;
}

