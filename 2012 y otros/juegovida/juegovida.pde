PFont font;
boolean[][] viejo, nuevo;
scrollH s1, s2, s3, s4;
Boton b1;

int nace, sol, sup;

void setup() {
  size(400, 430);
  frameRate(60);

  font = loadFont("font.vlw");
  textFont(font);

  s1 = new scrollH(10, 410, 82.5, 10, 0, 6, 0, "nace");
  s2 = new scrollH(102.5, 410, 82.5, 10, 0, 6, 2, "min");
  s3 = new scrollH(195, 410, 82.5, 10, 0, 6, 3, "max");
  s4 = new scrollH(287.5, 410, 82.5, 10, 10, 60, 30, "act");
  b1 = new Boton(380, 410, 10, 10, false, "p");

  viejo = new boolean[width][height-30];

  for (int j = 0; j < height-30; j++) {
    for (int i = 0; i < width; i++) {
      viejo[i][j] = false;
    }
  }
  nuevo = viejo;
  nuevo[195][200] = true;
  nuevo[196][200] = true;
  nuevo[196][201] = true;
  nuevo[200][201] = true;
  nuevo[201][201] = true;
  nuevo[202][201] = true;
  nuevo[201][199] = true;
}

void draw() {
  background(255);
  mouse();
  dibujar();
  menu();
  if (!b1.val){
    viejo = nuevo;
    act();
  }
}

int contarVecinos(int x, int y) {
  int vecinos = 0;
  for (int j = y-1; j <= y+1; j++) {
    for (int i = x-1; i <= x+1; i++) {
      if (i >= 0 && i < width && j >= 0 && j < height-30) {
        if (viejo[i][j] &&(x!=i || y!=j)) {
          vecinos++;
        }
      }
    }
  }
  return vecinos;
}

void act() {
  int cant;
  for (int j = 0; j < height-30; j++) {
    for (int i = 0; i < width; i++) {
      cant = contarVecinos(i, j);
      nuevo[i][j] = false;
      if (viejo[i][j]) {
        if (cant >= sol && sol <= sup) {
          nuevo[i][j] = true;
        }
      }
      else {
        if (cant == nace) {
          nuevo[i][j] = true;
        }
      }
    }
  }
}

void dibujar() {
  stroke(255, 20, 20);
  for (int j = 0; j < height-30; j++) {
    for (int i = 0; i < width; i++) {
      if (nuevo[i][j]) {
        point(i, j);
      }
    }
  }
}

void menu() {
  noStroke();
  fill(60);
  rect(0, 400, width, 30);
  s1.act();
  s2.act();
  s3.act();
  s4.act();
  b1.act();
  nace = int(s1.val);
  sol = int(s2.val);
  sup = int(s3.val);
  frameRate(s4.val);
}
void mouse(){
  if (mousePressed && mouseY < 400){
      nuevo[mouseX][mouseY] = true;
  }
}
