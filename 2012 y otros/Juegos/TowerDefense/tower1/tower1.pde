ArrayList torres, recorrido, bichos;
int tam = 40;
int mapa[][];

void setup() {
  size(400, 400);
  mapa = cargar("n1.nvl");
  torres = new ArrayList();
  recorrido = new ArrayList();
  calcularRecorrido();

  bichos = new ArrayList();
  bichos.add(new Bicho());
  noStroke();
}

void draw() {
  background(130, 200, 2);
  // 0 nada // 1 camino // 2 piedra // 3 torre // 4 comienzo // 5 fin;
  for (int j = 0; j < height/tam; j++) {
    for (int i = 0; i < width/tam; i++) {
      if (mapa[i][j] == 1 || mapa[i][j] == 4 ) {
        fill(90, 60, 8);
        rect(tam * i, tam *j, tam, tam);
      }
      else if (mapa[i][j] == 5) {
        fill(200, 2, 110);
        rect(tam * i, tam *j, tam, tam);
      }else if (mapa[i][j] == 2){
         fill(180);
         rect(tam * i,tam * j, tam, tam);
      }
    }
  }
  for (int i = 0; i < torres.size(); i++) {
    Torre aux = (Torre) torres.get(i);
    aux.act();
  }
  for (int i = 0; i < bichos.size();i++) {
    Bicho aux = (Bicho) bichos.get(i);
    aux.act();
  }
  //dibujarRecorrido();
}

void mousePressed() {
  int posX = int(mouseX/tam);
  int posY = int(mouseY/tam);
  if (mapa[posX][posY] == 0) {
    mapa[posX][posY] = 3;
    torres.add(new Torre(posX*tam+tam/2, posY*tam+tam/2));
  }
}
