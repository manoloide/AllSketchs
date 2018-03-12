Nivel n1;
Selector s1;
PFont font;
Pulsador p1, p2;

void setup() {
  size(600, 400);
  frameRate(60);
  noStroke();
  colorMode(HSB, 256);

  font = loadFont("font.vlw");
  textFont(font);

  s1 = new Selector(410, 10, 180, 20, 9, 0, "s1");
  p1 = new Pulsador(410, 380, 10, 10, "S");
  p2 = new Pulsador(430, 380, 10, 10, "L");

  n1 = new Nivel();
  n1.cargar();
}

void draw() {
  //fondo
  background(0);
  stroke(40);
  for (int i = 1; i < height/10; i++) {
    line(i*10, 0, i*10, height);
    line(0, i*10, height, i*10);
  }
  //opciones
  if (mousePressed && mouseX > 10 && mouseX < 390 && mouseY > 10 &&  mouseY < 390) {
    if (s1.val == 5) {
      if (mouseX > 20 && mouseY > 20) {
        for (int j2 = 0; j2 < height/10; j2++) {
          for (int i2 = 0; i2 < height/10; i2++) {
            if (n1.mapa[i2][j2] == 5) {
              n1.mapa[i2-1][j2-1] = 0;
              n1.mapa[i2-1][j2] = 0;
              n1.mapa[i2][j2-1] = 0;
              n1.mapa[i2][j2] = 0;
              
            }
          }
        }
        n1.mapa[mouseX/10][mouseY/10] = 5;
      } 
    }
    else {
      if (s1.val == 6) {
        if (mouseX > 20 && mouseY > 20) {
          for (int j2 = 0; j2 < height/10; j2++) {
            for (int i2 = 0; i2 < height/10; i2++) {
              if (n1.mapa[i2][j2] == 6) {
                n1.mapa[i2-1][j2-1] = 0;
                n1.mapa[i2-1][j2] = 0;
                n1.mapa[i2][j2-1] = 0;
                n1.mapa[i2][j2] = 0;
              }
            }
          }
          n1.mapa[mouseX/10][mouseY/10] = 6;
        }
      }
      else {
        n1.mapa[mouseX/10][mouseY/10] = s1.val;
      }
    }
  }
  //
  n1.draw();
  //menu
  menu();
}

