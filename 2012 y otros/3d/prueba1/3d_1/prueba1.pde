float ang = 0;
void setup() {
  size(600, 600, P3D);
  noStroke();
  fill(255, 60, 58);
}

void draw() {
  background(255);
  directionalLight (126, 126, 126, 0, 0, -1);
  ang+= 0.01;
  rotateX(ang);
  rotateY(ang);
  cubo();
  
}

void cubo() {
  for (int z = 0; z < 10; z++) {
    for (int y = 0; y < 10; y++) {
      for (int x = 0; x < 10; x++) {
        pushMatrix();
        translate(30 + x * 60, 30 + y * 60, 300 +z * -60);
        box(30, 30, 30);
        popMatrix();
      }
    }
  }
}

