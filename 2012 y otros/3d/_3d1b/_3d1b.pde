float x, y, z, angX, angY;

float vel = 2;

void setup() {
  size(600, 600, P3D);
  fill(255, 20);
  stroke(255);
}

void draw() {
  background(0);
  translate(width/2+x, height/2+y, z);
  rotateY(angY);
  for (int k = 0; k < 500; k+=50) {
    for (int j = -250; j < 500; j+=50) {
      for (int i = 0; i < 500; i+=50) {
        pushMatrix();
        translate(i,j,k);
        box(50, 50, 50);
        popMatrix();
      }
    }
  }
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
    angY -= 0.02;
  }
  if (key == 'q') {
    angY += 0.02;
  }
}

