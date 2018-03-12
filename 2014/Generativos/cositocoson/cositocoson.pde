void setup() {
  size(800, 600);
  background(255);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####");
    return;
  }  
  thread("generar");
}

class Punto {
  float x, y;
  Punto(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}

void generar() {
  strokeWeight(0.8);
  for (int i = 0; i < 20; i++) {
    recursion(new Punto(random(width), random(height)), int(random(6, 12)));
  }
  int cant = int(random(20));
  for (int i = 0; i < cant; i++) {
    float tam = random(20, 200);
    float x = random(width);
    float y = random(height);
    strokeWeight(tam/3);
    noFill();
    stroke(255, 60);
    ellipse(x-1, y-1, tam, tam);
    stroke(0, 60);
    ellipse(x, y, tam, tam);
  }
  cant = int(random(20, 100));
  strokeWeight(2);
  for (int i = 0; i < cant; i++) {
    float tam = random(2, 60)/2;
    float x = random(width);
    float y = random(height);
    float ang = random(PI);
    line(x+cos(ang)*tam, y+sin(ang)*tam, x-cos(ang)*tam, y-sin(ang)*tam);
    ang += PI/2;
    line(x+cos(ang)*tam, y+sin(ang)*tam, x-cos(ang)*tam, y-sin(ang)*tam);
  }
  noStroke();
  fill(#1F982C, 20);
  //rect(0, 0, width, height);
}

void recursion(Punto p, int n) {
  if (n <= 0) return;
  n -= int(random(1, 3));
  int cant = int(random(n*0.2, n*0.8));
  for (int i = 0; i < cant; i++) {
    float dis = random(8, 16);
    float ang = random(TWO_PI);
    float x = p.x + cos(ang)*dis;
    float y = p.y + sin(ang)*dis;
    int d = 80;
    stroke(255, 80);
    line(p.x-1, p.y-1, x-1, y-1);
    stroke(0, 80);
    line(p.x, p.y, x, y);
    recursion(new Punto(x, y), n);
  }
}
