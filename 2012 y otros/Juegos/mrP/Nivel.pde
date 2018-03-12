class Nivel {
  ArrayList comidas, enemigos, tiros, piedras;
  int[][] mapa;
  String[] todo;
  Meta m;

  Nivel(String name) {
    int lar = int(height/10); 
    todo = loadStrings(name);
    cargar();
  }
  void cargar() {
    int lar = int(height/10);
    mapa = new int[lar][lar];
    comidas = new ArrayList();
    enemigos = new ArrayList();
    piedras = new ArrayList();
    tiros = new ArrayList();
    for (int j = 0; j < lar; j++) {
      String linea = todo[j];
      for (int i = 0; i < lar; i++) {
        mapa[i][j] = int(str(linea.charAt(i)));
        if (mapa[i][j] == 2) {
          comidas.add(new Comida(i*10+5, j*10+5));
        }
        if (mapa[i][j] == 3) {
          enemigos.add(new Enemigo(i*10+5, j*10+5));
        }
        if (mapa[i][j] == 4) {
          piedras.add(new Piedra(i*10+5, j*10+5));
        }
        if (mapa[i][j] == 5) {
          j1 = new Jugador(i*10, j*10);
        }
        if (mapa[i][j] == 6) {
          m = new Meta(i*10, j*10);
        }
      }
    }
  }

  void act() {
    noStroke();
    fill(100, 255, 127);
    for (int j = 0; j < height/10; j++) {
      for (int i = 0; i < height/10; i++) {
        if (mapa[i][j] == 1) {
          rect(10*i, 10*j, 10, 10);
        }
      }
    }
    //act comida
    for (int i = 0; i < comidas.size(); i++) {
      Comida aux = (Comida) comidas.get(i);
      aux.act();
      if (colCubos(aux.x, aux.y, aux.tam, j1.x, j1.y, j1.tam)) {
        int crece = 2;
        j1.tam += crece;
        if (comer()) {
          comidas.remove(i);
          i--;
        }
        else {
          n1.cargar();
        }
      }
    }
    //act enmigos
    for (int i = 0; i < enemigos.size(); i++) {
      Enemigo aux = (Enemigo) enemigos.get(i);
      aux.act();
      if (aux.tiempo == 0) {
        tiros.add(new Tiro(aux.x, aux.y, j1.x, j1.y));
      }
    }
    //act meta;
    m.draw();
    if (colCubos(m.x, m.y, m.tam, j1.x, j1.y, j1.tam)) {
      niv++;
      if (niv > cant_niv) {
        niv = 1;
      }
      n1 = new Nivel("niveles/nivel"+niv+".nvl");
      n1.act();
    }

    //act tiros
    for (int i = 0; i < tiros.size(); i++) {
      Tiro aux = (Tiro) tiros.get(i);
      aux.act();
      float tama = j1.tam / 2;
      //colisones con jugador;
      if (aux.x >= j1.x - tama && aux.x <= j1.x + tama && aux.y >= j1.y - tama && aux.y <= j1.y + tama) {
        j1.tam -= 2;
        if (j1.tam < 2) {
          cargar();
          break;
        }
        tiros.remove(i);
        i--;
      }

      //colisiones con piedras
      for (int j = 0; j < piedras.size(); j++) {
        Piedra p = (Piedra) piedras.get(j);
        if (aux.x >= p.x - 5 && aux.x <= p.x + 5 && aux.y >= p.y - 5 && aux.y <= p.y + 5) {
          tiros.remove(i);
          i--;
          break;
        }
      }
      //llegada a un borde;
      if (dist(aux.x, aux.y, aux.dx, aux.dy) < 1) {
        tiros.remove(i);
        i--;
      }
    }
    //act piedras
    for (int i = 0; i < piedras.size(); i++) {
      Piedra aux = (Piedra) piedras.get(i);
      aux.act();
    }
  }
}

