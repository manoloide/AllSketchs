//constantes
color verde = color(54, 255, 45);
color naranja = color(200, 100, 30);
color rojo = color (255, 43, 65); 
//1-10 vegetales; 11-20 hervivoro; 21-30; carnivoro);
int[][] mapa, ant;

void setup() {
  size(400, 400);
  noStroke();
  mapa = new int[width/10][height/10];  
  for (int i = 0; i < 1; i++) {
    mapa[int(random(width/10))][int(random(height/10))] = 1;
  }
}

void draw() {
  background(80);
  for (int j = 0; j < height/10; j++) {
    for (int i = 0; i < width/10; i++) {
      int val = mapa[i][j];
      //vegetal
      if (val > 0 && val <= 10) {
        fill(red(verde)-val*7, green(verde)-val*6, blue(verde)-val*5);
        rect(i*10, j*10, 10, 10); 
        if (val > 5) {
          int op = int(random(10));
          if (op == 0 && j > 0) {
            if (mapa[i][j-1] > 10 || mapa[i][j-1] == 0) {
              mapa[i][j-1] = 1;
            }
          }
          if (op == 1 && j < height/10-1) {
            if (mapa[i][j+1] > 10 || mapa[i][j+1] == 0) {
              mapa[i][j+1] = 1;
            }
          }
          if (op == 2 && i > 0) {
            if (mapa[i-1][j] > 10 || mapa[i-1][j] == 0) {
              mapa[i-1][j] = 1;
            }
          }
          if (op == 3 && i < width/10-1) {
            if (mapa[i+1][j] > 10 || mapa[i+1][j] == 0) {
              mapa[i+1][j] = 1;
            }
          }
        }
        if (val < 10) {
          mapa[i][j]++;
        }
      }
    }
  }
  
  delay(500);
}

