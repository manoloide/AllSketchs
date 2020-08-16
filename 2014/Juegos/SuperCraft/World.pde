class World {

  int mapa[][];
  int fondo[][];

  World() {
    crearWorld();
  }

  void update() {
    for (int i = 0; i < 50; i++) {
      int xx = int(random(mapa.length));
      int yy = int(random(mapa[0].length)); 
      if (mapa[xx][yy] == ID_PASTO) {
        if (yy < 1 || mapa[xx][yy-1] != ID_NADA) {
          mapa[xx][yy] = ID_TIERRA;
        }
      }
      if (mapa[xx][yy] == ID_TIERRA) {
        if (yy < 1 || mapa[xx][yy-1] == ID_NADA) {
          mapa[xx][yy] = ID_PASTO;
        }
      }
    }
    dibujarWorld();
  }

  void crearWorld() {
    mapa = new int[MAPA_WIDTH][MAPA_HEIGHT];
    fondo = new int[MAPA_WIDTH][MAPA_HEIGHT];
    for (int j = 0; j < MAPA_HEIGHT; j++) {
      float col = j*1./MAPA_HEIGHT*4;
      for (int i = 0; i < MAPA_WIDTH; i++) {
        mapa[i][j] = round(col+random(-0.08, 0.08));//*10+int(random(4));
        fondo[i][j] = round(col+random(-0.03, 0.03));//*10;//+int(random(4));
        if (mapa[i][j] == ID_TIERRA && noise(i*0.05, j*0.05)<0.4) {
           mapa[i][j] = ID_ARENA;
        }
      }
    }
  }

  void dibujarWorld() {
    int x0 = int(-camera.x-width/2)/TILE_SIZE;
    int y0 = int(-camera.y-height/2)/TILE_SIZE; 
    if (x0 < 0) x0 = 0;
    if (y0 < 0) y0 = 0;
    int x1 = x0+width/TILE_SIZE+2;
    int y1 = y0+height/TILE_SIZE+2;
    if (x1 > MAPA_WIDTH) x1 = MAPA_WIDTH;
    if (y1 > MAPA_HEIGHT) y1 = MAPA_HEIGHT;
    for (int j = y0; j < y1; j++) {
      for (int i = x0; i < x1; i++) {
        strokeWeight(6);
        boolean dibujar = true;
        /*
        if (mapa[i][j] == ID_TIERRA) {
         fill(COLOR_TIERRA);
         }
         if (mapa[i][j] == ID_PASTO) {
         fill(COLOR_PASTO);
         }
         if (mapa[i][j] == ID_PIEDRA) {
         fill(COLOR_PIEDRA);
         }
         //stroke(220, 30);
         */
        if (mapa[i][j] != ID_NADA) {
          image(Tiles[mapa[i][j]], i*TILE_SIZE, j*TILE_SIZE);
        } else {
          if (fondo[i][j] != ID_NADA) {
            image(Tiles[fondo[i][j]], i*TILE_SIZE, j*TILE_SIZE);
            fill(0, 120);
            noStroke();
            rect(i*TILE_SIZE, j*TILE_SIZE, TILE_SIZE, TILE_SIZE);
          }
        }
      }
    }
  }
  boolean colision(Player p) {
    int xx = int(p.x)/TILE_SIZE;
    int yy = int(p.y)/TILE_SIZE; 
    for (int j = -1; j <= 1; j++) {
      for (int i = -1; i <= 1; i++) {
        if (xx+i >= MAPA_WIDTH || yy+j >= MAPA_HEIGHT || xx+i < 0 || yy+j < 0 || mapa[xx+i][yy+j] == 0) continue;
        if (colisionRectangulo(p.x, p.y, p.w, p.h, (xx+i)*TILE_SIZE, (yy+j)*TILE_SIZE, TILE_SIZE, TILE_SIZE)) {
          return true;
        }
      }
    }
    return false;
  }
}

boolean colisionRectangulo(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  return ((x1-w1*0.5 < x2+w2*0.5) && (x2-w2*0.5 < x1+w1*0.5) && (y1-h1*0.5 < y2+h2*0.5) && (y2-h2*0.5 < y1+h1*0.5));
}

void generarSprites() {
  Tiles = new PImage[5];
  PGraphics aux = createGraphics(TILE_SIZE, TILE_SIZE);
  for (int i = 0; i < 5; i++) {
    aux.beginDraw();
    if (i == ID_NADA)
      aux.clear();
    if (i == ID_TIERRA || i == ID_PASTO) {
      float bri = 0;//random(-5, 5);
      int varCol = 0;//3;
      color colTierra = color(red(COLOR_TIERRA)+random(-varCol, varCol)+bri, green(COLOR_TIERRA)+random(-varCol, varCol)+bri, blue(COLOR_TIERRA)+random(-varCol, varCol)+bri);
      float intTex = random(0.4, 0.6);
      float dx = random(100);
      float dy = random(10);

      //aux.background(COLOR_TIERRA);
      for (int yy = 0; yy < TILE_SIZE; yy++) {
        for (int xx = 0; xx < TILE_SIZE; xx++) {
          color col = lerpColor(colTierra, color(20), noise(xx*0.03+dx, yy*0.03+dy)*intTex);
          if (i == ID_PASTO && TILE_SIZE*0.2 > yy) {
            col = lerpColor(COLOR_PASTO, color(20), noise(xx*0.03, yy*0.03)*0.5);
          }
          col = lerpColor(col, color(255), (xx*1./TILE_SIZE)*0.06);
          col = lerpColor(col, color(255), (1-yy*1./TILE_SIZE)*0.08);
          aux.set(xx, yy, col);
        }
      }
    }
    if (i == ID_PIEDRA) {
      for (int yy = 0; yy < TILE_SIZE; yy++) {
        for (int xx = 0; xx < TILE_SIZE; xx++) {
          color col = lerpColor(COLOR_PIEDRA, color(20), noise(xx*0.03, yy*0.03)*0.7);
          col = lerpColor(COLOR_PIEDRA, color(255), noise(xx*0.2, yy*0.2)*0.08);
          col = lerpColor(col, color(255), (xx*1./TILE_SIZE)*0.15);
          col = lerpColor(col, color(255), (1-yy*1./TILE_SIZE)*0.08);
          aux.set(xx, yy, col);
        }
      }
    }
    if (i == ID_ARENA) {
      for (int yy = 0; yy < TILE_SIZE; yy++) {
        for (int xx = 0; xx < TILE_SIZE; xx++) {
          color col = lerpColor(COLOR_ARENA, color(20), noise(xx*0.03, yy*0.03)*0.7);
          col = lerpColor(COLOR_ARENA, color(255), noise(xx*0.2, yy*0.2)*0.08);
          col = lerpColor(col, color(255), (xx*1./TILE_SIZE)*0.15);
          col = lerpColor(col, color(255), (1-yy*1./TILE_SIZE)*0.08);
          aux.set(xx, yy, col);
        }
      }
    }
    if (i != ID_NADA) {
      aux.noFill();
      for (int s = 1; s < 16; s++) {
        aux.stroke(0, 12*(1-0.5/s));
        aux.strokeWeight(s);
        aux.rect(0, 0, TILE_SIZE, TILE_SIZE, i*1.2);
      }
    }
    aux.endDraw();
    // println(i, j);
    Tiles[i] = aux.get();
  }
}
