class Plataforma {
  int x, y, w, h;
  float vel;
  Punto p1, p2, obj;
  Plataforma(int x, int y, int w, int h, int px1, int py1, int px2, int py2) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
    vel = 1;
    p1 = new Punto(px1, py1);
    p2 = new Punto(px2, py2);
    obj = new Punto(px1, py1);
  }
  void act() {
    println(obj.x,obj.y, p1.x, p1.y, p2.x, p2.y);
    if (obj.x != x) {
      if (obj.x < x) {
        println("izquierda");
        x -= vel;
      }
      else {
        println("derecha");
        x += vel;
      }
    }
    if (obj.y != y) {
      if (obj.y < y) {
        y -= vel;
      }
      else {
        y += vel;
      }
    }
    
    if (dist(x, y, obj.x, obj.y) < vel) {
      if (obj.x == p1.x && obj.y == p1.y) {
        obj.x = p2.x;
        obj.y = p2.y;
      }
      else if (obj.y == p2.y && obj.y == p2.y) {
        obj.x = p1.x;
        obj.y = p1.y;
      } //<>//
    }
    dibujar();
  }
  void dibujar() {
    fill(245, 134, 0);
    rect(x-w/2, y-h/2, w, h);
  }
  boolean colisiona(Jugador ju) {
    if (colisionRect(ju.x, ju.y, ju.tam, ju.tam, x, y, w, h)) {
      return true;
    }
    return false;
  }
}


class Punto {
  int x, y; 
  Punto(int x, int y) {
    this.x = x; 
    this.y = y;
  }
}
