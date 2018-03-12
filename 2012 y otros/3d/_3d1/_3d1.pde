float x, y, z, angX, angY;

float vel = 2;

void setup() {
  size(600, 600, P3D);
  fill(255, 20);
  stroke(255);
  x =width/2;
  y = height/2;
}

void draw() {
  background(0);
  translate(x, y, z);
  rotateY(angY);
  box(50, 50, 50);
  translate(99, 0, 0);
  box(50, 50, 50);
  translate(0, 0,99);
  box(50, 50, 50);
}

void keyPressed() {
  if (keyCode == DOWN) {
    z+= cos(angY+PI) * vel;
    x+= sin(angY+PI) * vel;
  }
  if (keyCode == UP) {
    z+= cos(angY) * vel;
    x+= sin(angY) * vel;
  }

  if (keyCode == RIGHT) {
    z+= cos(angY-PI/2) * vel;
    x+= sin(angY-PI/2) * vel;
  }
  if (keyCode == LEFT) {
    z+= cos(angY+PI/2) * vel;
    x+= sin(angY+PI/2) * vel;
  }
  if (key == 'e') {
    angY += 0.02;
  }
  if (key == 'q') {
    angY -= 0.02;
  }
}

