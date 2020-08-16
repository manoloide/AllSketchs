class Player {
  boolean activo;
  float x, y, velx, vely;
  float w, h;
  int maxSaltos = 2;
  int saltos;
  int seleccionado;
  int inventario[][];
  Player() {
    x = MAPA_WIDTH/2 *TILE_SIZE;
    //y = MAPA_HEIGHT/2 *TILE_SIZE;
    w = 18;
    h = 40;
    inventario = new int[4][2];
    activo = true;
  }
  void update() {
    if (activo) {
      movimiento();
      acciones();
    }
    show();
  }
  void show() {
    noStroke();
    fill(240, 34, 64);
    rect(x, y, w, h);
  }

  void movimiento() {
    float ace = 0.1;
    float vel = 3;

    float ax = x;
    if (input.IZQUIERDA.press) {
      velx -= ace;
      if (velx < -vel) velx = -vel;
    } else if (input.DERECHA.press) {
      velx += ace;
      if (velx > vel) velx = vel;
    } else {
      velx *= 0.3;
    }
    x += velx;
    if (world.colision(this)) {
      x = ax;
    }

    float ay = y;
    if (saltos > 0) {
      vely += 1;
    }
    if (input.SALTAR.click && saltos <= maxSaltos) {
      saltos++; 
      vely = -14;
    }
    y += vely;
    if (world.colision(this)) {
      if (vely > 0) {
        saltos = 0;
      }
      vely = 0;
      y = ay;
    } else {
      if (saltos == 0)
        saltos = 1;
    }
  }

  void acciones() {
    if (input.mclick) {
      int xx = int(mouseX-camera.x+TILE_SIZE/2-width/2) /TILE_SIZE;
      int yy = int(mouseY-camera.y+TILE_SIZE/2-height/2) /TILE_SIZE;
      float dis = dist(mouseX-camera.x-width/2, mouseY-camera.y-height/2, player.x, player.y);
      if (dis < TILE_SIZE*3) {
        if (world.mapa[xx][yy] == ID_PASTO) world.mapa[xx][yy] = ID_TIERRA;
        if (world.mapa[xx][yy] != ID_NADA) {
          player.agregarMaterial(world.mapa[xx][yy], 1);
          world.mapa[xx][yy] = ID_NADA;
        } else if (world.mapa[xx][yy] == ID_NADA && player.inventario[player.seleccionado][1] > 0) {
          int ant = world.mapa[xx][yy];
          world.mapa[xx][yy] = player.inventario[player.seleccionado][0];
          if (world.colision(player)) {
            world.mapa[xx][yy] = ant;
          } else {
            player.inventario[player.seleccionado][1]--;
          }
        }
      }
    }
  }

  void agregarMaterial(int id) {
    agregarMaterial(id, 1);
  }

  void agregarMaterial(int id, int cant) {
    for (int i = 0; i < inventario.length; i++) {
      if (inventario[i][0] == 0 || inventario[i][0] == id) {
        inventario[i][0] = id; 
        inventario[i][1] += cant;
        break;
      }
    }
  }
}
