class Nivel {
  ArrayList comidas, enemigos, tiros, piedras;
  int w, h, ix, iy, it;
  int[][] mapa;
  Jugador jugador;
  String src;
  JSONObject json;
  Meta m;

  Nivel() {
    nuevo(50, 37, 20, 20, 20);
    src = "";
    iniciar();
  }

  Nivel(String src) {
    this.src = src;
    cargar(src);
  }
  void cargar(String src) {
    this.src = src;
    json = loadJSONObject(src);
    w = json.getInt("width");
    h = json.getInt("height");
    ix = json.getInt("xinicial");
    iy = json.getInt("yinicial");
    it = json.getInt("tinicial");
    mapa = new int[w][h];
    JSONArray a1 = json.getJSONArray("tiles");
    for (int i = 0; i < a1.size(); i++) {
      JSONArray a2 = a1.getJSONArray(i);
      for (int j = 0; j < a2.size(); j++) {
        mapa[j][i] = a2.getInt(j);
      }
    }
    iniciar();
  }
  boolean guardar() {
    actualizar();
    saveJSONObject(json, src);
    return true;
  }
  boolean guardarComo() {
    selectOutput("Guardar como:", "guardarSelecionar");
    return true;
  }
  void actualizar() {
    JSONObject aux = new JSONObject();
    aux.setInt("width", w);
    aux.setInt("height", h);
    aux.setInt("xinicial", ix);
    aux.setInt("yinicial", iy);
    aux.setInt("tinicial", it);
    //cargar la matrix

    JSONArray a1 = new JSONArray();
    for (int j = 0; j < h; j++) {
      JSONArray a2 = new JSONArray();
      for (int i = 0; i < w; i++) {
        a2.append(mapa[i][j]);
      }
      a1.append(a2);
    }
    aux.setJSONArray("tiles", a1);
    json = aux;
    iniciar();
  }
  void nuevo(int w, int h, int ix, int iy, int it) {
    this.w = w;
    this.h = h;
    this.ix = ix;
    this.iy = iy;
    this.it = it;
    mapa = new int[w][h];
    jugador = new Jugador(ix, iy, it);
    //guardar pared
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (i == 0 || i == w-1 || j == 0 || j == h-1) mapa[i][j] = 1;
        else  mapa[i][j] = 0;
      }
    }
  }
  void iniciar() {
    comidas = new ArrayList();
    enemigos = new ArrayList();
    piedras = new ArrayList();
    tiros = new ArrayList();  
    jugador = new Jugador(ix*TAMTILE, iy*TAMTILE, it);
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (mapa[i][j] == 2) {
          comidas.add(new Comida(i*TAMTILE+TAMTILE/2, j*TAMTILE+TAMTILE/2));
        }
        if (mapa[i][j] == 3) {
          enemigos.add(new Enemigo(i*TAMTILE+TAMTILE/2, j*TAMTILE+TAMTILE/2));
        }
        if (mapa[i][j] == 4) {
          piedras.add(new Piedra(i*TAMTILE+TAMTILE/2, j*TAMTILE+TAMTILE/2));
        }
        if (mapa[i][j] == 5) {
          m = new Meta(i*TAMTILE, j*TAMTILE);
        }
      }
    }
  }

  boolean validar() {
    return true;
  }

  void act() {
    if (input.REINICIAR.click) {
      iniciar();
    }
    //dibujar paredes
    noStroke();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (mapa[i][j] == 0 || mapa[i][j] == 2 || mapa[i][j] == 4|| mapa[i][j] == 5) {
          fill(#292923);
          rect(TAMTILE*i, TAMTILE*j, TAMTILE, TAMTILE);
        }
        if (mapa[i][j] == 1) {
          fill(100, 255, 127);
          rect(TAMTILE*i, TAMTILE*j, TAMTILE, TAMTILE);
        }
      }
    }
    //actualizar jugador;
    jugador.act();
    //act comida
    for (int i = 0; i < comidas.size(); i++) {
      Comida aux = (Comida) comidas.get(i);
      aux.act();
      if (colCubos(aux.x, aux.y, aux.tam, jugador.x, jugador.y, jugador.tam)) {
        int crece = 2;
        jugador.tam += crece;
        if (comer(jugador)) {
          comidas.remove(i);
          i--;
        }
        else {
          iniciar();
        }
      }
    }
    //act enmigos
    for (int i = 0; i < enemigos.size(); i++) {
      Enemigo aux = (Enemigo) enemigos.get(i);
      aux.act();
      if (aux.tiempo == 0) {
        tiros.add(new Tiro(aux.x, aux.y, jugador.x, jugador.y));
      }
    }
    //act meta;
    if (m != null) {
      m.dibujar();
      if (colCubos(m.x, m.y, m.tam, jugador.x, jugador.y, jugador.tam)) {
        if (!m.niv.equals("")) {
          nivel = new Nivel(m.niv);
        }
        else {
          nivel.iniciar();
        }
        nivel.act();
      }
    }

    //act tiros
    for (int i = 0; i < tiros.size(); i++) {
      Tiro aux = (Tiro) tiros.get(i);
      aux.act();
      float tama = jugador.tam / 2;
      //colisones con jugador;
      if (aux.x >= jugador.x - tama && aux.x <= jugador.x + tama && aux.y >= jugador.y - tama && aux.y <= jugador.y + tama) {
        jugador.tam -= 2;
        if (jugador.tam < 2) {
          iniciar();
          break;
        }
        tiros.remove(i);
        i--;
      }

      //colisiones con piedras
      for (int j = 0; j < piedras.size(); j++) {
        Piedra p = (Piedra) piedras.get(j);
        if (aux.x >= p.x - TAMTILE/2 && aux.x <= p.x + TAMTILE/2 && aux.y >= p.y - TAMTILE/2 && aux.y <= p.y + TAMTILE/2) {
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

  boolean colision(int x, int y) {
    return (mapa[x][y] == 1 || mapa[x][y] == 3);
  }
}
