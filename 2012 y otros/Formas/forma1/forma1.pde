void setup(){
  size(400,400);
  Forma f = new Forma();
  f.draw();
}



class Forma {
  Punto puntos[];
  Forma() {
    puntos = new Punto[4];
    for (int i = 0; i < 4; i++) {
      puntos[i] = new Punto(random(width), random(height));
    }
  }

  void draw() {
    beginShape();
    for (int i = 0; i < 4; i++) {    
      vertex(puntos[i].x, puntos[i].y);
    }
    endShape(CLOSE);
  }
}
class Punto {
  float x, y;
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
}

