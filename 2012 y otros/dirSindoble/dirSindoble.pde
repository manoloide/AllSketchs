Jugador j;

void setup() {
  size(400, 600);
  frameRate(60);
  smooth();

  j = new Jugador(width/2, height/2);
}

void draw() {
  j.draw();
}

void keyPressed() {
  if (keyCode == UP) {
    j.tecla[0] = true;
    j.ultimaTecla = 0;
  }
  else if (keyCode == DOWN) {
    j.tecla[1] = true;
    j.ultimaTecla = 1;
  }
  else if (keyCode == LEFT) {
    j.tecla[2] = true;
    j.ultimaTecla = 2;
  }
  else if (keyCode == RIGHT) {
    j.tecla[3] = true;
    j.ultimaTecla = 3;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    j.tecla[0] = false;
  }
  else if (keyCode == DOWN) {
    j.tecla[1] = false;
  }
  else if (keyCode == LEFT) {
    j.tecla[2] = false;
  }
  else if (keyCode == RIGHT) {
    j.tecla[3] = false;
  }
}

class Jugador {
  ArrayList tiros;
  boolean[] tecla;
  float x, y; 
  int ultimaTecla = 0;
  Jugador(float nx, float ny) {
    x = nx;
    y = ny;
    tiros = new ArrayList();
  }
  void mover() {
    int dir = -1;
    if (tecla(ultimaTecla)) {
      dir = ultimaTecla;
    }
    else {
      for (int i = 0; i < 4; i++) {
        if (tecla[i]) {
          dir = i;
          i = 4;
        }
      }
    }
    if (dir == 0){
      
    }
  }
  void draw() {
    triangle(x-10, y+10, x, y-10, x+10, y+10);
  }
}

