int puntas = int(random(3, 10));
int niveles = int(random(2, 8));
int tamano = int(random(120, 200));
int conta; 

void setup() {
  size(600, 600);
  background(0);
  frameRate(20);
  noStroke();
  fill(255, 60);
  fractal(width/2, height/2, random(TWO_PI), puntas, tamano, niveles);
  conta = (int) random(2,20);
}

void draw() {
  if (frameCount%conta <= random(6)) {
    conta = (int) random(10,30);
    fill(0, 200);
    rect(0, 0, width, height);
    puntas = int(random(3, 10));
    niveles = int(random(3, 5));
    tamano = int(random(80, 240));
    fill(255, 60);
    fractal(width/2+random(-5, 5), height/2+random(-5, 5), random(TWO_PI), puntas, tamano, niveles);
  }
  else {
    fill(255, 6);
    rect(0, 0, width, height);
  }
  /*
  saveFrame("####.png");
  if (frameCount > 10*30) {
    exit();
  }
  */
}

void keyPressed() {
  //saveFrame("####.png");
}


void fractal(float x, float y, float ang, int puntas, float tam, float nivel) {
  if (nivel == 0)return;
  float dang = TWO_PI/puntas;
  beginShape();
  for (int i = 0; i < puntas; i++) {
    float nang = ang+dang*i;
    float nx = x + cos(nang)*tam/2;
    float ny = y + sin(nang)*tam/2;
    vertex(nx, ny);
  }
  endShape(CLOSE);
  for (int i = 0; i < puntas; i++) {
    float nang = ang+dang*i+dang/2;
    float nx = x + cos(nang)*tam/2;
    float ny = y + sin(nang)*tam/2;
    fractal(nx, ny, nang, puntas, tamano/2, nivel-1);
  }
}

