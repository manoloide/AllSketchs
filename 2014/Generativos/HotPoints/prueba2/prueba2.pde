ArrayList<HotPoint> puntos;

void setup() {
  size(800, 600);
  smooth(8);
  puntos = new ArrayList<HotPoint>();
  puntos.add(new HotPoint(width/3, height/3));
  puntos.add(new HotPoint(width/3*2, height/3));
  puntos.add(new HotPoint(width/3, height/3*2));
  puntos.add(new HotPoint(width/3*2, height/3*2));
  for (int i = 0; i < puntos.size(); i++) {
    HotPoint aux = puntos.get(i);
    aux.setDist(dist(width/3, height/3, width/2, height/2));
  }
  background(255);
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####");
    return;
  }
  for (int i = 0; i < 1; i++) {
    thread("generar");
  }
}

void generar() {
  stroke(0, 80);
  fill(200, 40);
  float x = random(width);
  float y = random(height);
  HotPoint cer = null;
  for (int i = 0; i < puntos.size(); i++) {
    HotPoint aux = puntos.get(i);
    if (cer == null) { 
      cer = aux;
      break;
    }
    float d1 = dist(aux.x, aux.y, x, y);
    float d2 = dist(cer.x, cer.y, x, y);
    if (d1 < d2) cer = aux;
  }
  if (cer != null) {
  }
  int cant = 40;
  float ang = random(TWO_PI);
  float da = random(-0.01, 0.01);
  float rot = random(TWO_PI);
  for (int i = 0; i < cant; i++) {
    resetMatrix();
    translate(x, y);
    rotate(rot);
    int tam = cant-i;
    rect(-tam/2, -tam/2, tam, tam);
    ang += da;
    x += cos(ang);
    y += sin(ang);
    //delay(50);
  }
}

class HotPoint {
  boolean eliminar; 
  float x, y, dis; 
  HotPoint(float x, float y) {
    this.x = this.x;
    this.y = this.y;
  }
  void setDist(float dis) {
    this.dis = dis;
  }
}
