int[][] tablero;
boolean[][] pres;
int val = 20;
PFont fuente;

void setup() {
  size(400, 400);
  //fuente
  fuente = loadFont("font.vlw");
  textFont(fuente, 12);
  //matrices
  tablero = new int[width/val][height/val];
  pres = new boolean[width/val][height/val];
  reiniciar();
}

void draw() {
  background(0);
  fill(127);
  //dibujar numeros
  for (int j = 0; j < height/val; j++) {
    for (int i = 0; i < width/val; i++) {
      text(tablero[i][j], (i*val)+7, (j*val)+15);
    }
  }
  //dibujar cuadrados 
  for (int j = 0; j < height/val; j++) {
    for (int i = 0; i < width/val; i++) {
      if (!pres[i][j]) {
        rect(i*val, j*val, val, val);
      }
    }
  }
}

void mousePressed() {
  int x = mouseX/val;
  int y = mouseY/val;
  if (tablero[x][y]==-1) {
    reiniciar();
  }
  else {
    verificar(x, y);
  }
}

void verificar(int x, int y) {
  if (pres[x][y] == false) {
    pres[x][y] = true;
    if (tablero[x][y]==0) {
      if (x-1 >= 0) {
        verificar(x-1, y);
      } 
      if (x+1 < width/val) {
        verificar(x+1, y);
      }
      if (y-1 >= 0) {
        verificar(x, y-1);
      } 
      if (y+1 < height/val) {
        verificar(x, y+1);
      }
    }
  }
}

void reiniciar() {
  //llenar matrices
  for (int j = 0; j < height/val; j++) {
    for (int i = 0; i < width/val; i++) {
      tablero[i][j] = 0;
      pres[i][j] = false;
    }
  }
  //pone las minas
  int v = 0;
  while (width/val > v) {
    int x = int(random(width/val));
    int y = int(random(height/val));
    if (tablero[x][y] == 0) {
      tablero[x][y] = -1;
      v++;
      for (int i = x-1; i <= x+1; i++) {
        for (int j = y-1; j <= y+1; j++) {
          if (i >= 0 && i < width/val && j >= 0 && j < height/val && (x != i || y != j)) {
            if (tablero[i][j] != -1) {
              tablero[i][j]++;
            }
          }
        }
      }
    }
  }
}

