int dismax = 100;
int dismin = 1;
int niveles = 2;
int cantmax = 10;
int cantmin = 3;
int cantidades[] = new int[niveles];

void setup() {
  size(600, 600);
  background(0);
  for (int i = 0; i < cantidades.length; i++) {
    cantidades[i] = int(random(cantmin, cantmax));
  }
  fractal(width/2, height/2, random(TWO_PI), 2);
}

void draw() {
}

void keyPressed() {
  saveFrame("######.png");
}

void mousePressed() {
  dismax = int(random(40, 100));
  dismin = int(random(1, 40));
  niveles = int(random(2, 6));
  cantidades = new int[niveles];
  for (int i = 0; i < cantidades.length; i++) {
    cantidades[i] = int(random(cantmin, cantmax));
  }
  background(0);
  fractal(width/2, height/2, random(TWO_PI), niveles);
}
void fractal(float x, float y, float ang, int nivel) {
  if (nivel == 0) return;
  float alfa = map(nivel, niveles, 0, 255, 0);
  float dis = map(nivel, niveles, 0, dismax, dismin);
  int cant = cantidades[nivel-1];
  float dang = TWO_PI/cant;
  for (int i = 0; i < cant; i++) {
    float nang = ang+dang*i;
    float nx = x + cos(nang)*dis;
    float ny = y + sin(nang)*dis;
    stroke(255);
    strokeWeight(alfa/255 * niveles);
    line(x, y, nx, ny);
    fractal(nx, ny, nang, nivel-1);
  }
}

