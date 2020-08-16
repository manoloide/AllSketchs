class Mundo {
  int w, h, dx, dy;
  Tile tiles[][];
  Mundo(int w, int h) {
    this.w = w; 
    this.h = h;
    tiles = new Tile[w][h];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        tiles[i][j] = new Tile();
        if(i < 4 && j < 4) tiles[i][j] = null;
      }
    }
  }
  void act() {
    dx = int(-j1.x)+width/2;
    dy = int(-j1.y)+height/2;
    if (input.click) {		
      int tx = int(j1.x+mouseX-width/2); 
      int ty = int(j1.y+mouseY-height/2);
      if (tx >= 0) {
        tx = (tx/16)%m.w;
      } else {
        tx = m.w+((tx/16)%m.w)-1;
      }
      if (ty >= 0) {
        ty = (ty/16)%m.h;
      } else {
        ty = m.h+((ty/16)%m.h)-1;
      }
      if (m.tiles[tx][ty] != null) {
        m.tiles[tx][ty].picar(j1);
        m.tiles[tx][ty] = null;
      } else {
        //m.tiles[tx][ty] = new Tile();
      }
      println(tx, ty);
    }
  }
  void dibujar() {
    int x1, y1, x2, y2;
    x1 = int(j1.x-width/2)/16-1;
    y1 = int(j1.y-height/2)/16-1;
    x2 = int(j1.x+width/2)/16+1;
    y2 = int(j1.y+height/2)/16+1;
    for (int j = y1; j<y2; j++) {
      int ty = j%h;
      if (j < 0) {
        ty = (j+1)%h;
        ty = h-abs(ty)-1;
      }
      for (int i = x1; i<x2; i++) {
        int tx = i%w;
        if (i < 0) {
          tx = (i+1)%w;
          tx = w-abs(tx)-1;
        }
        if (tiles[tx][ty] != null) {
          image(tiles[tx][ty].img, dx+i*16, dy+j*16);
        }
      }
    }
  }
  boolean colision(Jugador ju, float xx, float yy) {
    int px, py;
    if(ju.x >= 0) px = int((ju.x/16));
    else px = int((m.w-1)+((ju.x/16+1)%m.w)); //int(3+(i+1)%4)
    if(ju.y >= 0) py = int(ju.y/16);
    else py = int((m.h-1)+((ju.y/16+1)%m.h));
    for(int j = -2; j < 2; j++){
      for(int i = -2; i < 2; i++){
        int ax, ay;
        ax = px+i;
        ay = py+j;

        if(ax < 0) ax += m.w;
        if(ax >= m.w) ax %= m.w;

        if(ay < 0) ay += m.h;
        if(ay >= m.h) ay %= m.h;

        if (tiles[ax][ay] != null) {
          if (colisionRectangulo(width/2-ju.w/2+xx, height/2-ju.h/2+yy, ju.w, ju.h, dx+(px+i)*16, dy+(py+j)*16, 16, 16)) {
           return true;
         }
       }
     }
   }
   return false;
 }
}

boolean colisionRectangulo(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if ((x1 < x2+w2) && (x2 < x1+w1) && (y1 < y2 + h2)) {
    return y2 < y1 + h1;
  }
  return false;
}
