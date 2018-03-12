

//ENTIDADES
class Entidad implements Comparable {
  boolean eliminar, recolectar;
  int x, y, vel, fx, fy, cuadro, nt, rx, ry, time;
  int dir;
  ArrayList<Nodo> camino;
  Nivel nivel;
  Jugador jugador;
  Entidad(int x, int y, Nivel nivel) {
    this.x = x;
    this.y = y;
    this.nivel = nivel;
    jugador = nivel.jugador; 
    nt = nivel.tam;
    eliminar = false;
    recolectar = false;
    camino = new ArrayList<Nodo>();
  }
  void act(int x, int y) {
  }
  void calcularCamino(int fx, int fy) {
    recolectar = false;
    if (fx < 0 || fx >= nivel.w || fy < 0 || fy >= nivel.h) {
      return;
    }
    this.fx = fx; 
    this.fy = fy;
    AEstrella ae = new AEstrella(nivel, this);
    camino = ae.camino;
    //fijarse si se quiere recolectar
    if (nivel.mapa[fx][fy].ocupado) {
      int dis = 0;
      if (camino.size() == 0) {
        dis = int(dist(fx, fy, x/nt, y/nt));
      }
      else {
        Nodo aux = camino.get(0);
        dis = int(dist(fx, fy, aux.x, aux.y));
      }
      //se puede recolectar
      if (dis == 1) {
        rx = fx;
        ry = fy;
        recolectar = true;
      }
    }
  }
  int compareTo(Object o) { 
    int res = 0; 
    Entidad e =  (Entidad) o;

    if (y < e.y) { 
      res = -1;
    }
    else if (y > e.y) { 
      res = 1;
    }
    else {
      if ( x < e.x) {
        res = -1;
      }
      else if (x > e.x) {
        res = 1;
      }
    }

    return res;
  }
}

class Humano extends Entidad {
  Humano(int x, int y, Nivel nivel) {
    super(x, y, nivel);
  }
  void act(int px, int py) {
    if (camino.size() > 0) {
      if (x%nt == 0 && y%nt == 0) {
        int xp = x/nt;
        int yp = y/nt;
        if (xp == fx && yp == fy) {
          vel = 0;
          Nodo prox = camino.get(camino.size()-1);
          if (xp == prox.x && yp == prox.y) {
            camino.remove(camino.size()-1);
          }
          if (recolectar) {
            if (yp < ry) {
              dir = 0;
            }
            if (xp < rx) {
              dir = 1;
            }
            if (yp > ry) {
              dir = 2;
            }
            if (xp > rx) {
              dir = 3;
            }
          }
        } 
        else {
          vel = 1;
          Nodo prox = camino.get(camino.size()-1);
          if (xp == prox.x && yp == prox.y) {
            camino.remove(camino.size()-1);
            if (camino.size() > 0) {
              prox = camino.get(camino.size()-1);
            }
          }
          if (camino.size() > 0) {
            if (yp < prox.y) {
              dir = 0;
            }
            if (xp < prox.x) {
              dir = 1;
            }
            if (yp > prox.y) {
              dir = 2;
            }
            if (xp > prox.x) {
              dir = 3;
            }
          }
        }
      }
      //animacion
      if (frameCount%8 == 0) {
        cuadro = (cuadro + 1) % 4;
      }
      //mover
      if (dir == 0 ) {
        y += vel;
      }
      else if (dir == 1) {
        x += vel;
      }
      else if (dir == 2) {
        y -= vel;
      }
      else if (dir == 3) {
        x -= vel;
      }
    }
    else {
      cuadro = 0;
      if (recolectar) {
        switch(nivel.mapa[rx][ry].c.tipo) {
        case 0: 
          nivel.particulas.add(0, new PPixel(sprites[0][1], rx*nt+20, ry*nt+20));
          break;
        case 1: 
          nivel.particulas.add(0, new PPixel(sprites[1][1], rx*nt+20, ry*nt+20));
          break;
        case 2:
          nivel.particulas.add(0, new PPixel(sprites[2][1], rx*nt+20, ry*nt+20));
          break;
        }
        if (time == 0) {
          nivel.mapa[rx][ry].c.vida--;
          switch(nivel.mapa[rx][ry].c.tipo) {
          case 0: 
            jugador.madera++;
            break;
          case 1: 
            jugador.piedra++;
            break;
          case 2:
            jugador.comida++;
            break;
          }
          if (nivel.mapa[rx][ry].c.vida <= 0) {
            recolectar = false;
          }
          nivel.particulas.add(new PTexto("+1", rx*nt+20, ry*nt+10));
          time = 30;
        }
        time--;
      }
    }

    /* dibuja la buqeuda de camino
     if (ae != null) {
     ae.draw(px, py, tam);
     }
     */
    /* dibuja el camino
     fill(255, 0, 0, 100);
     for (int i = 0; i < camino.size(); i++) {
     Nodo aux = camino.get(i);
     rect(aux.x * tam +px, aux.y * tam +py, tam, tam);
     }*/
    image(sprites[dir][2+cuadro], x+px, y+py);
  }
}

class Oso extends Entidad {
  Oso(int x, int y, Nivel nivel) {
    super(x, y, nivel);
  }
  void act(int px, int py) {
    if (x%nt == 0 && y%nt == 0) {
      if (vel == 1) {
        if (random(1) < 0.05) {
          vel = (vel == 0)? 1 : 0;
        }
        if (random(1) < 0.08) {
          dir = int(random(4));
        }
      }
      else {
        if (random(1) < 0.005) {
          vel = (vel == 0)? 1 : 0;
        }
        if (random(1) < 0.002) {
          dir = int(random(4));
        }
      }
    }
    if (dir == 0 && y+vel+nt < nivel.h*nt && !nivel.mapa[int(x/nt)][int((y+vel+nt-0.01)/nt)].ocupado) {
      y += vel;
    }
    else if (dir == 1 && x+vel+nt < nivel.w*nt && !nivel.mapa[int((x+vel+nt-0.01)/nt)][int(y/nt)].ocupado) {
      x += vel;
    }
    else if (dir == 2 && y-vel >= 0 && !nivel.mapa[int(x/nt)][int((y-vel)/nt)].ocupado) {
      y -= vel;
    }
    else if (dir == 3 && x-vel >= 0 && !nivel.mapa[int((x-vel)/nt)][int(y/nt)].ocupado) {
      x -= vel;
    }
    image(sprites[dir][6], x+px, y+py);
  }
}


//pathfinding 

class Nodo {
  int x, y;
  int f, g, h;
  Nodo padre, fin;
  Nodo(int x, int y, Nodo padre, Nodo fin) {
    this.x = x;
    this.y = y;
    this.padre = padre;
    this.fin = fin;
    if (fin != null) {
      h = int((abs(x-fin.x)+abs(y-fin.y))*10);
    }
    else {
      h = 0;
    }
    if (padre == null) {
      g = 0;
    }
    else {
      g = padre.g + 10;
    }
    f = g + h;
  }
}

class AEstrella {
  boolean sepuede;
  Nivel nivel;
  Tile mapa[][];
  Entidad entidad;
  Nodo inicio, fin, select;
  int nt;
  ArrayList<Nodo> abierta, cerrada, camino, nodos;
  AEstrella(Nivel nivel, Entidad entidad) {
    this.nivel = nivel;
    mapa = nivel.mapa;
    this.entidad = entidad;
    nt = nivel.tam;
    iniciar();
  }
  void iniciar() {
    sepuede = false;
    //inicializar nodos;
    fin = new Nodo(entidad.fx, entidad.fy, null, null);
    inicio = new Nodo(entidad.x/nt, entidad.y/nt, null, fin);
    if (iguales(inicio, fin)) {
      camino = new ArrayList<Nodo>();
      return;
    }
    //listas
    abierta = new ArrayList<Nodo>();
    cerrada = new ArrayList<Nodo>();
    nodos = new ArrayList<Nodo>();

    cerrada.add(inicio);
    //agregar a lista abierta los vecinos del nodo inicial
    abierta = vecinos(inicio);
    while (objetivo ()) {
      buscar();
    }
    //genera el camino si se puede llegar.
    if (sepuede) {
      camino = camino();
    }
    //buscar el punto mas cercano si no se puede llegar.
    else {
      if (cerrada.size() == 1) {
        //se queda en el lugar;
        camino = new ArrayList<Nodo>();
      }
      else {
        Nodo nuevoObjetivo = masCerca();
        entidad.fx = nuevoObjetivo.x;
        entidad.fy = nuevoObjetivo.y;
        iniciar();
      }
    }
  }
  //agrega los vecinos del nodo a la lista abierta;
  ArrayList<Nodo> vecinos(Nodo nodo) {
    ArrayList<Nodo> vecinos = new ArrayList<Nodo>();
    int x = nodo.x;
    int y = nodo.y;
    if (x + 1 < nivel.w && !mapa[x+1][y].ocupado) {
      vecinos.add(new Nodo(x+1, y, nodo, fin));
    } 
    if (y + 1 < nivel.h && !mapa[x][y+1].ocupado) {
      vecinos.add(new Nodo(x, y+1, nodo, fin));
    }
    if (x - 1 >= 0 && !mapa[x-1][y].ocupado) {
      vecinos.add(new Nodo(x-1, y, nodo, fin));
    }
    if (y - 1 >= 0 && !mapa[x][y-1].ocupado) {
      vecinos.add(new Nodo(x, y-1, nodo, fin));
    }
    return vecinos;
  }
  //pasa el nodo con menor f a la lista cerrada
  void fMenor() {
    Nodo minNodo = abierta.get(0);
    int ind = 0;
    for ( int i = 1; i < abierta.size(); i++) {
      if (abierta.get(i).f < minNodo.f) {
        minNodo = abierta.get(i);
        ind = i;
      }
    }
    cerrada.add(minNodo);
    abierta.remove(ind);
  }
  //comprueba si un nodo esta en una lista
  boolean enLista(Nodo nodo, ArrayList<Nodo> lista) {
    for (int i = 0; i < lista.size();i++) {
      //nodo == lista.get(i)
      if (iguales(nodo, lista.get(i))) {
        return true;
      }
    }
    return false;
  }
  //
  void ruta() {
    for (int i = 0; i < nodos.size(); i++) {
      Nodo aux = nodos.get(i);
      if (enLista(aux, cerrada)) {
        continue;
      }
      else if (!enLista(aux, abierta)) {
        abierta.add(aux);
      }
      else {
        if (select.g+10 < aux.g) {
          for (int j = 0; j < abierta.size(); j++) {
            Nodo n = abierta.get(j); 
            if (iguales(aux, n)) {
              abierta.remove(j);
              abierta.add(aux);
              break;
            }
          }
        }
      }
    }
  }
  //analiza el ultimo elemento de la lista cerrada
  void buscar() {
    fMenor();
    select = cerrada.get(cerrada.size()-1);
    nodos = vecinos(select);
    ruta();
  }
  //comprueva si el objetivo esta en la lista abierta
  boolean objetivo() {
    if (abierta.size() == 0) return false;
    for (int i = 0; i < abierta.size(); i++) {
      Nodo aux = abierta.get(i);
      if (iguales(aux, fin)) {
        sepuede = true;
        return false;
      }
    }
    return true;
  }
  //
  ArrayList<Nodo> camino() {
    Nodo objetivo = null;
    for (int i = 0; i < abierta.size(); i++) {
      Nodo aux = abierta.get(i);
      if (iguales(aux, fin)) {
        objetivo = aux;
      }
    }
    ArrayList<Nodo> camino = new ArrayList<Nodo>();
    while ( objetivo.padre != null) {
      camino.add(objetivo);
      objetivo = objetivo.padre;
    }
    return camino;
  }
  boolean iguales(Nodo n1, Nodo n2) {
    return (n1.x == n2.x && n1.y == n2.y);
  }
  Nodo masCerca() {
    Nodo minNodo = cerrada.get(0);
    for ( int i = 1; i < cerrada.size(); i++) {
      if (cerrada.get(i).h < minNodo.h) {
        minNodo = cerrada.get(i);
      }
    }
    return minNodo;
  }
  void draw(int px, int py, int tam) {
    fill(255, 0, 0, 80);
    for (int i = 0; i < camino.size(); i++) {
      Nodo aux = camino.get(i);
      rect(aux.x * tam +px, aux.y * tam +py, tam, tam);
    }
    fill(0, 255, 0, 80);
    for (int i = 0; i < abierta.size(); i++) {
      Nodo aux = abierta.get(i);
      rect(aux.x * tam +px, aux.y * tam +py, tam, tam);
    }
    fill(0, 0, 255, 80);
    for (int i = 0; i < cerrada.size(); i++) {
      Nodo aux = cerrada.get(i);
      rect(aux.x * tam +px, aux.y * tam +py, tam, tam);
    }
  }
}

