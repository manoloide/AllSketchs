int[][] luz;
Jugador j1;

void setup() {
  size(400, 400);
  frameRate(60);
  noStroke();
  colorMode(HSB, 256);
  smooth();
  luz = new int[width/10][height/10];
  for (int i = 0; i < height/10; i++){
    for (int j = 0; j < width/10; j++){
       luz[j][i] = 255;   
    }
  }
  background(0);
  j1 = new Jugador(200, 200);
}

void draw() {
  fill(255,100,100);
  rect(0,0,width,height);
  //background(0);
  j1.act();
  
  //luz 
  for (int i = 0; i < height/10; i++){
    for (int j = 0; j < width/10; j++){
       int cx,cy;
       cx = j * 10;
       cy = i * 10;
       float alp = dist(cx+5,cy+5,j1.x,j1.y)*1.5;
       fill(0, alp);
       rect(cx,cy,10,10);
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    j1.arriba = true;
    j1.tecla = 1;
  }
  if (keyCode == DOWN) {
    j1.abajo = true;
    j1.tecla = 2;
  }
  if (keyCode == LEFT) {
    j1.izquierda = true;
    j1.tecla = 3;
  }
  if (keyCode == RIGHT) {
    j1.derecha = true;
    j1.tecla = 4;
  }
}
void keyReleased() {
  if (keyCode == UP)
    j1.arriba = false;
  if (keyCode == DOWN)
    j1.abajo = false;
  if (keyCode == LEFT)
    j1.izquierda = false;
  if (keyCode == RIGHT)
    j1.derecha = false;

  j1.tecla = 0;
  if (j1.arriba)
    j1.tecla = 1;
  if (j1.abajo)
    j1.tecla = 2;
  if (j1.izquierda)
    j1.tecla = 3;
  if (j1.derecha)
    j1.tecla = 4;
}

