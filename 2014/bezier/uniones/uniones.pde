ArrayList<Punto> puntos;

void setup() {
  size(600, 800);
  generar();
}

void draw() {
}

void keyPressed() {
  thread("generar");
}

void generar() {
  background(#EDEBDF);
  puntos = new ArrayList<Punto>();
  for (int i = 0; i < 1000; i++) {
    float tam = 300;
    boolean agregar = false;
    while (!agregar && tam >= 10) {
      Punto aux = new Punto(random(width), random(height), tam);
      agregar = true;
      for (int j = 0; j < puntos.size(); j++) {
        Punto com = puntos.get(j);
        if (dist(com.x, com.y, aux.x, aux.y) < (aux.tam+com.tam)/2) {
          agregar = false;
          break;
        }
      }
      if (agregar) {
        aux.dibujar();
        puntos.add(aux);
      }
      tam *= 0.95;
    }
  }
  int cant = 3;
  for (int i = 0; i < puntos.size(); i++) {
    ArrayList<Punto> cercanos = new ArrayList<Punto>();
    Punto p1 = puntos.get(i);
    for (int j = 0; j < puntos.size(); j++) {
      if (i == j) continue;
      Punto p2 = puntos.get(j);
      if (cercanos.size() == 0) {
        cercanos.add(p2);
        continue;
      }
      int cc = cercanos.size(); 
      if (cc > cant) cc = cant;
      float dis = dist(p1.x, p1.y, p2.x, p2.y);
      boolean agrego = false;
      for (int k = 0; k < cc; k++) {
        Punto cer = cercanos.get(k);
        float dis2 = dist(p1.x, p1.y, cer.x, cer.y);
        if (dis < dis2) {
          agrego = true;
          cercanos.add(k, p2);
          if (cercanos.size() > cant) {
            cercanos.remove(cant);
          }
          break;
        }
      }
      if (!agrego && cercanos.size() < cant) {
        cercanos.add(p2);
      }
    }
    for (int j = 0; j < cercanos.size(); j++) {
     Punto p2 = cercanos.get(j); 
     strokeWeight((p1.tam+p2.tam)/50);
     stroke(255, 180);
     noFill();
     float ang = atan2(p2.y-p1.y, p2.x-p1.x);
     float dis = dist(p1.x, p1.y, p2.x, p2.y);
     float d = 0.8;
     float d1 = random(d);
     float d2 = random(d);
     float a = PI/4;
     float a1 = random(-a, a);
     float a2 = random(-a, a);
     bezier(p1.x, p1.y, p1.x+cos(ang+a1)*dis*d1, p1.y+sin(ang+a1)*dis*d1, p2.x+cos(-ang+a2)*dis*d2, p2.y+sin(-ang+a2)*dis*d2, p2.x, p2.y);
     strokeWeight(1);
     }
    /*
     for (int j = 0; j < 1; j++) {
     Punto p2 = puntos.get(j);
     strokeWeight(min(p1.tam, p2.tam)/20);
     stroke(#D80255, 180);
     noFill();
     float ang = atan2(p2.y-p1.y, p2.x-p1.x);
     float dis = dist(p1.x, p1.y, p2.x, p2.y);
     float d = 0.8;
     float d1 = random(d);
     float d2 = random(d);
     float a = PI/4;
     float a1 = random(-a, a);
     float a2 = random(-a, a);
     bezier(p1.x, p1.y, p1.x+cos(ang+a1)*dis*d1, p1.y+sin(ang+a1)*dis*d1, p2.x+cos(-ang+a2)*dis*d2, p2.y+sin(-ang+a2)*dis*d2, p2.x, p2.y);
     strokeWeight(1);
     }
     */
  }
  /*
  for (int j = 0; j < puntos.size(); j++) {
   Punto aux = puntos.get(j);
   aux.dibujar();
   }*/
  /*
  strokeWeight(2);
   stroke(0, 80);
   noFill();
   float ang = atan2(p2.y-p1.y, p2.x-p1.x);
   float dis = dist(p1.x, p1.y, p2.x, p2.y);
   float d = 0.8;
   float d1 = random(d);
   float d2 = random(d);
   float a = PI/4;
   float a1 = random(-a, a);
   float a2 = random(-a, a);
   bezier(p1.x, p1.y, p1.x+cos(ang+a1)*dis*d1, p1.y+sin(ang+a1)*dis*d1, p2.x+cos(-ang+a2)*dis*d2, p2.y+sin(-ang+a2)*dis*d2, p2.x, p2.y);
   strokeWeight(1);
   */
}

class Punto {
  float x, y, tam;
  Punto(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
  }
  void dibujar() {
    noStroke();     
    fill(#D80255);
    ellipse(x, y, tam, tam);
    stroke(250, 40);
    line(x-tam/10, y, x+tam/10, y);
    line(x, y-tam/10, x, y+tam/10);
  }
}
