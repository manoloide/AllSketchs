//carga el mapa de un archivo...
int[][] cargar(String nombre) {
  String[] archivo = loadStrings(nombre);
  int larX = int(width/tam);
  int larY = int(height/tam);
  int[][]aux = new int[larX][larY];
  for (int j = 0; j < larY; j++) {
    String linea = archivo[j];
    for (int i = 0; i < larX; i++) {
      aux[i][j] = int(str(linea.charAt(i)));
    }
  }
  return aux;
}

void dibujarRecorrido() {
  strokeWeight(4);
  stroke(0);
  Punto aux1 = (Punto) recorrido.get(0);
  for (int i = 1; i < recorrido.size();i++) {
    Punto aux2 = (Punto) recorrido.get(i);
    line(aux1.x, aux1.y, aux2.x, aux2.y);
    aux1 = aux2;
  }
  noStroke();
}

void calcularRecorrido() {
  int posX = -1;
  int posY = -1;
  for (int j = 0; j < height/tam; j++) {
    for (int i = 0; i < width/tam; i++) {
      if (mapa[i][j] == 4) {
        posX = i;
        posY = j;
      }
    }
  }
  int dir = -1;
  while (mapa[posX][posY] != 5) {
    //arriba(0)
    if (posY > 0 && dir != 2 && (mapa[posX][posY-1] == 1 || mapa[posX][posY-1] == 5)) {
      if (dir != 0) {
        recorrido.add(new Punto(posX*tam + tam/2, posY*tam + tam/2));
        dir = 0;
      }
      posY -= 1;
    }
    //derecha(1)
    if (posX < width/tam && dir != 3 && (mapa[posX+1][posY] == 1 || mapa[posX+1][posY] == 5)) {
      if (dir != 1) {
        recorrido.add(new Punto(posX*tam + tam/2, posY*tam + tam/2));
        dir = 1;
      }
      posX += 1;
    }
    //abajo(2)
    if (posY < height/tam && dir != 0&& (mapa[posX][posY+1] == 1 || mapa[posX][posY+1] == 5)) {
      if (dir != 2) {
        recorrido.add(new Punto(posX*tam + tam/2, posY*tam + tam/2));
        dir = 2;
      }
      posY += 1;
    }
    //izquierda(3)
    if (posX > 0 && dir != 1 && (mapa[posX-1][posY] == 1 || mapa[posX-1][posY] == 5)) {
      if (dir != 3) {
        recorrido.add(new Punto(posX*tam + tam/2, posY*tam + tam/2));
        dir = 3;
      }
      posX -= 1;
    }
  }
  recorrido.add(new Punto(posX*tam + tam/2, posY*tam + tam/2));
}
