ArrayList particulas;

void setup() {
  // badas
  size(600, 600);
  colorMode(HSB);
  noStroke();
  smooth();
  background(0);
  // definir constantes de color
  color VERDE = color(80, 120, 120);
  color AZUL = color(170, 120, 120);
  // definir particulas
  particulas = new ArrayList();
  for (int j = 0; j < height/10; j++) {
    for (int i = 0; i < width/10; i++){
      if (i % 2 != j % 2) {
        particulas.add(new Particula(width/10 * i, height/10 * j, AZUL));
      } 
      else {
        particulas.add(new Particula(width/10 * i, height/10 * j, VERDE));
      }
    }
  }
  fill(VERDE);
  rect(0, 0, width/2, height);
  fill(AZUL);
  rect(width/2, 0, width/2, height);
}
void draw() {
  fill(0);
  rect(0, 0, width, height); 
  for (int i = 0; i < particulas.size(); i++) {
    Particula pro = (Particula) particulas.get(i);
    pro.act();
  }
}

class Particula {
  float x, y, cx, cy;
  color col;
  Particula(float nx, float ny, color nc) {
    x = nx;
    y = ny;
    cx = x;
    cy = y;
    col = nc;
  }

  void act() {
    mouse();

    volver(); 

    draw();
  }

  void mouse() {
    float dis = dist(x, y, mouseX, mouseY);
    if (dis < 100) {
      float ang = atan2(mouseY-y, mouseX-x);
      float vel = (100 - dis)/10;
      x -= cos(ang)*vel;
      y -= sin(ang)*vel;
    }
  }
  void volver() {
    float dis = dist(x, y, cx, cy);
    if (dis > 1) {
      float ang = atan2(cy-y, cx-x);
      float vel = 1;
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
  }

  void draw() {
    noStroke();
    fill(col);
    ellipse(x, y, 10, 10);
  }
}

