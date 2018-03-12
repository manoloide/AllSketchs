class Punto {
  float x, y;
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
}

class Torre {
  ArrayList disparos;
  float x, y, rango, dano, recarga, carga;
  Torre(int nx, int ny) {
    x = nx;
    y = ny;
    rango = 200;
    dano = 1;
    recarga = 500;
    disparos = new ArrayList();
    //disparos
    carga = 0;
  }
  void act() {
    disparar();
    //actDisparos();
    for (int i = 0; i < disparos.size(); i++) {
      Disparo aux = (Disparo) disparos.get(i);
      aux.act();
      if (dist(aux.x, aux.y, aux.dx, aux.dy) < 1) {
        disparos.remove(i);
        i--;
      }
    }
    draw();
  }

  void disparar() {
    if (carga == 0) {
      Bicho aux = null;
      boolean encontro = false;
      float dis = -1;
      for (int i = 0; i < bichos.size(); i++) {
        aux = (Bicho) bichos.get(i);
        dis = dist(aux.x, aux.y, x, y); 
        if (dis < rango) {
          encontro = true;
          break;
        }
      }
      if (encontro) {
        Punto dest = aux.calcularPosicion(dis, 2);
        if (dest != null && dist(dest.x, dest.y, x, y)<rango) { 
          disparos.add(new Disparo(x, y, dest.x, dest.y));
          carga = recarga;
        }
      }
    }
    if (carga != 0) {
      carga -= frameRate;
      if (carga < 0) {
        carga = 0;
      }
    }
  }
  void draw() {
    fill(220);
    ellipse(x, y, 30, 30);
  }
}

class Bicho {
  float x, y, vida, velocidad, ang;
  int des;
  Punto destino;

  Bicho() {
    des = 0;
    destino = (Punto) recorrido.get(des);
    x = destino.x;
    y = destino.y;
    velocidad = 1;
  }
  void act() {
    if (dist(x, y, destino.x, destino.y)<velocidad) {
      des++;
      if (des >= recorrido.size()) {
        des = 0;
        destino =(Punto) recorrido.get(des);
        x = destino.x+1;
        y = destino.y+1;
      }
      else {
        destino =(Punto) recorrido.get(des);
      }
      ang = atan2(destino.y-y, destino.x-x);
    }
    x += cos(ang)*velocidad;
    y += sin(ang)*velocidad;
    draw();
  }
  //////////////////////////////////////////////////////////////////
  //devolver posicion dada la distancia y la velocidad de la bala.//
  //////////////////////////////////////////////////////////////////
  Punto calcularPosicion(float bdis, float bvel) {
    int veces = int(bdis/bvel);
    //copia de la variables
    float px = x;
    float py = y;
    int pdes = des;
    float pang = ang;
    Punto pdestino = destino;
    for (int i = 0; i < veces; i++) {
      //hacer recorrido
      if (dist(px, py, pdestino.x, pdestino.y)<velocidad) {
        pdes++;
        if (pdes >= recorrido.size()) {
          return null;
        }
        else {
          pdestino =(Punto) recorrido.get(pdes);
        }
        pang = atan2(pdestino.y-py, pdestino.x-px);
      }
      px += cos(pang)*velocidad;
      py += sin(pang)*velocidad;
    }
    return new Punto(px, py);
  }
  void draw() {
    fill(255, 0, 0);
    ellipse(x, y, 10, 10);
  }
}

class Disparo {
  float x, y, dx, dy, ang;
  Disparo(float nx, float ny, float ndx, float ndy) {
    x = nx;
    y = ny;
    dx = ndx;
    dy = ndy;
    ang = atan2(dy-y, dx-x);
  }
  void act() {
    x += cos(ang)*2;
    y += sin(ang)*2;
    draw();
  }

  void draw() {
    fill(255, 230, 20);
    ellipse(x, y, 5, 5);
  }
}
