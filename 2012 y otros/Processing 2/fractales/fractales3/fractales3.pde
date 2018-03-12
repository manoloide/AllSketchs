int puntas = int(random(3, 10));
int niveles = int(random(2, 8));
int tamano = int(random(120, 200));

void setup() {
  size(600, 600);
  background(0);
  noStroke();
  fill(255,60);
  fractal(width/2, height/2, random(TWO_PI), puntas, tamano, niveles);
}

void draw() {
}

void keyPressed(){
   saveFrame("####.png"); 
}

void mousePressed() {
  background(0);
  puntas = int(random(3, 10));
  niveles = int(random(3, 6));
  tamano = int(random(120, 180));
  fractal(width/2, height/2, random(TWO_PI), puntas, tamano, niveles);
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

