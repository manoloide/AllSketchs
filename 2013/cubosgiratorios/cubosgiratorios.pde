int piezas[][];
int cant = 4;

void setup() {
  size(600, 600);
  piezas = new int[cant][cant];
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      if (random(2)<1) {
        piezas[i][j] = 0;
      }
      else {
        piezas[i][j] = int(random(5));
      }
    }
  }
  bajar(piezas);
}

void draw() {
  background(0);
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      switch(piezas[i][j]) {
      case 0:
        noFill();
        break;
      case 1: 
        fill(255, 0, 0);
        break;
      case 2: 
        fill(0, 255, 0);
        break;
      case 3:
        fill(0, 0, 255);
        break;
      case 4:
        fill(255, 255, 0);
        break;
      }
      int tam = 400/cant;
      rect(300 + tam*(i-cant/2), 300 + tam*(j-cant/2), tam, tam);
    }
  }
}

void keyPressed() {
  if (key == 'b') {
    bajar(piezas);
  }
  if (keyCode == RIGHT) {
    girarDer(piezas);
    bajar(piezas);
  }
  if (keyCode == LEFT) {
    girarIzq(piezas);
    bajar(piezas);
  }
}

void bajar(int[][] matriz) {
  for (int i = 0; i < cant; i++) {
    for (int j = cant-1; j >= 0; j--) {
      if (matriz[i][j] == 0) {
        boolean otra = false;
        for (int k = j; k >= 1; k--) {
          if (k <= j && matriz[i][k] != 0) {
            otra = true;
          }
          matriz[i][k] = matriz[i][k-1];
        }
        if (matriz[i][j] == 0 && otra) {
          j++;
        }
        matriz[i][0] = 0;
      }
    }
  }
}

void girarDer(int[][] matriz) {
  int aux[][] = new int[cant][cant];
  for (int i = 0; i < cant; i++) {
    int h = cant-1;
    for (int j = 0; j < cant; j++) {
      //aux [h][i] = matriz [i][j]; 
      aux [i][j] = matriz [j][cant-i-1]; 
      h--;
    }
  }
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      matriz[i][j] = aux[i][j];
    }
  }
}

void girarIzq(int[][] matriz) {
  int aux[][] = new int[cant][cant];
  for (int i = 0; i < cant; i++) {
    for (int j = 0; j < cant; j++) {
      aux [i][j] = matriz [cant-j-1][i];
    }
  }
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      matriz[i][j] = aux[i][j];
    }
  }
}

