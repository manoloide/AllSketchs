int tama[] = {
  100, 80, 50, 40, 20, 10
};
int ti = 0, tam = tama[ti], ch, cv, x, y;
boolean laberinto[][];

void setup() {
  size(400, 400);
  noStroke();
  x = 1;
  y = 1;
  ch = width/tam;
  cv = height/tam;
  laberinto = generarLaberinto(ch, cv);
}

void draw() {
  for (int j = 0; j < cv; j++) {
    for (int i = 0; i < ch; i++) {
      if (laberinto[i][j]) {
        fill(200);
      }
      else {
        fill(0);
      }
      rect(i*tam, j*tam, tam, tam);
    }
  }
  fill(255, 0, 0);
  ellipse(x*tam+tam/2, y*tam+tam/2, tam-2, tam-2);
}

void keyPressed() {
  if (keyCode == UP) {
    if ( y-1 > 0 && laberinto[x][y-1]) {
      y -= 1;
    }
  } 
  else if (keyCode == DOWN) {
    if ( y < cv-2 && laberinto[x][y+1]) {
      y += 1;
    }
  }
  else    if (keyCode == LEFT) {
    if ( x-1 > 0 && laberinto[x-1][y]) {
      x -= 1;
    }
  } 
  else if (keyCode == RIGHT) {
    if ( x < ch-2 && laberinto[x+1][y]) {
      x += 1;
    }
  }
  if (key == 'r') {
    x = 1;
    y = 1;
    laberinto = generarLaberinto(ch, cv);
  }
  if ( x == ch-2 && y == cv-2) {
    x = 1;
    y = 1;
    if (ti < tama.length-1) {
      ti++;
    }
    tam = tama[ti];
    ch = width/tam;
    cv = height/tam;
    laberinto = generarLaberinto(ch, cv);
  }
}

boolean[][] generarLaberinto(int ch, int cv) {
  boolean[][] lab = new boolean[ch][cv];
  for (int i = 0; i < ch*cv; i++) {
    lab[int(random(1, ch-1))][int(random(1, cv-1))] = true;
  }
  lab[1][1] = true;
  lab[ch-2][cv-2] = true;
  return lab;
}

