Rama tronco;
void setup() {
  size(800, 600);
  colorMode(HSB, 256);
  stroke(255);
  strokeWeight(4);
  tronco = new Rama(width/2, height/2+50, width/2, height/2-50);
  for (int i = 0; i < 3; i++) {
    Punto ap = new Punto(tronco.p2.x+random(-40, 40), tronco.p2.y+random(-60)-20); 
    Rama aux = new Rama(tronco.p2, ap);
    tronco.ramas.add(aux);
    for (int j = 0; j < 2;j++) {
      ap = new Punto(aux.p2.x+random(-40, 40), aux.p2.y+random(-60)-20); 
      aux.ramas.add(new Rama(aux.p2, ap));
    }
  }
}

void draw() {
  background((frameCount%1024)/4., 80, 255);
  tronco.act();
  tronco.crecer(1);
  tronco.mover(0,1);
}

void keyPressed() {
  tronco.crecer(3);
  tronco.rotar(width/2, height/2, PI/8);
}
class Rama {
  ArrayList<Rama> ramas;
  float dist;
  Punto p1, p2;
  Rama(float x1, float y1, float x2, float y2) {
    ramas = new ArrayList<Rama>();
    p1 = new Punto(x1, y1);
    p2 = new Punto(x2, y2);
  }
  Rama(Punto a1, Punto a2) {
    ramas = new ArrayList<Rama>();
    p1 = new Punto(a1.x, a1.y);
    p2 = new Punto(a2.x, a2.y);
  }
  void act() {
    dibujar();
    dist = dist(p1.x, p1.y, p2.x, p2.y);
    for (int i = 0; i < ramas.size(); i++) {
      Rama aux = ramas.get(i); 
      aux.act();
    }
  }
  void dibujar() {
    strokeWeight(dist/10);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  void mover(float x, float y) {
    this.p1.x += x;
    this.p1.y += y;
    this.p2.x += x;
    this.p2.y += y;
    for (int i = 0; i < ramas.size(); i++) {
      Rama aux = ramas.get(i); 
      aux.mover(x, y);
    }
  }
  void crecer(float cre) {
    float ang = atan2(p1.y-p2.y, p1.x-p2.x);
    this.p1.x += cos(ang)*(cre/3);
    this.p1.y += sin(ang)*(cre/3);
    this.p2.x -= cos(ang)*(cre/3)*2;
    this.p2.y -= sin(ang)*(cre/3)*2;
    for (int i = 0; i < ramas.size(); i++) {
      ramas.get(i).crecer(p2, cre*0.8);
    }
  }
  void crecer(Punto base, float cre) {
    float ang = atan2(p1.y-p2.y, p1.x-p2.x);
    this.p1.x += cos(ang)*(cre/3);
    this.p1.y += sin(ang)*(cre/3);
    this.p2.x -= cos(ang)*(cre/3)*2;
    this.p2.y -= sin(ang)*(cre/3)*2;
    mover(base.x-p1.x, base.y-p1.y);
    for (int i = 0; i < ramas.size(); i++) {
      ramas.get(i).crecer(p2, cre*0.8);
    }
  }
  void rotar(float cx, float cy, float ang) {
    p1.rotar(cx, cy, ang);
    p2.rotar(cx, cy, ang);
    for (int i = 0; i < ramas.size(); i++) {
      ramas.get(i).rotar(cx, cy, ang);
    }
  }
}

class Punto {
  float x, y;
  Punto(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  void rotar(float cx, float cy, float ang) {
    float dis = dist(cx, cy, x, y);
    float ori = atan2(y-cy, x-cx);
    x = cx + cos(ori+ang) * dis;
    y = cy + sin(ori+ang) * dis;
  }
}

