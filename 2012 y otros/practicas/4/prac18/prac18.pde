float x, y;
int estado, col;

void setup() {
  size(400, 400);
  noStroke();
  smooth();
  colorMode(HSB);
  x = 0;
  y = 0;
  estado = 1;
  col = int(random(256));
}

void draw() {
  if (estado == 1) {
    x++;
    if (x == 360) {
      col = int(random(256));
      estado = 2;
    }
  }
  else if (estado == 2) {
    y++;
    if (y == 360) {
      col = int(random(256));
      estado = 3;
    }
  }
  else if (estado == 3) {
    x--;
    if (x == 0) {
      col = int(random(256));
      estado = 4;
    }
  }
  else if (estado == 4) {
    y--;
    if (y == 0) {
      col = int(random(256));
      estado = 1;
    }
  }
  fill(col,255,255);
  rect(x, y, 40, 40);
}

