ArrayList<Forma> formas;
void setup() {
  size(400, 400);
  formas = new ArrayList<Forma>();
  for (int j = 0; j < 5; j++) {
    for (int i = 0; i < 5; i++) {
      formas.add(new Forma(i*width/5, j*height/5, width/5, height/5, 8));
    }
  }
}
void draw() {
  frame.setTitle("FPS: "+frameRate);
  background(#0A0A0A);
  for (int i = 0; i < formas.size(); i++) {
    Forma aux = formas.get(i);
    aux.act();
  }
}
class Punto {
  float x, y, ox, oy;
  int tiempo_reposo;
  Punto(float x, float y, float ox, float oy) {
    this.x = x; 
    this.y = y;
    this.ox = ox; 
    this.oy = oy;
  }
  void act() {
    float dis = dist(x, y, ox, oy);
    tiempo_reposo--; 
    if (dis < 1) {
      if (tiempo_reposo < 0) tiempo_reposo = 60;
    }
    float ang = atan2(oy-y, ox-x);
    x += cos(ang)*dis/4;
    y += sin(ang)*dis/4;
  }
}
class Forma {
  ArrayList<Punto> puntos;
  boolean eliminar;
  float x, y, w, h;
  Forma(float x, float y, float w, float h, int cant) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    puntos = new ArrayList<Punto>();
    for (int i = 0; i < cant; i++) {
      float xx = random(x, x+w);
      float yy = random(y, y+h);
      float ox = random(x, x+w);
      float oy = random(y, y+h);
      puntos.add(new Punto(xx, yy, ox, oy));
    }
  }
  void act() {
    for (int i = 0; i < puntos.size(); i++) {
      Punto aux = puntos.get(i);
      aux.act();
      if (aux.tiempo_reposo == 0) {
        aux.ox = random(x, x+w);
        aux.oy = random(y, y+h);
      }
    }
    dibujar();
  }
  void dibujar() {
    stroke(255);
    for (int i = 0; i < puntos.size(); i++) {
      Punto p1 = puntos.get(i); 
      Punto p2 = puntos.get((i+1)%puntos.size());
      line(p1.x, p1.y, p2.x, p2.y);
    }
  }
}
