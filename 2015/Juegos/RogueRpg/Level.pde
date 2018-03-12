class Level {
  int w, h;
  int tiles[][];
  Level() {
    w = h = 64;
    generate();
  }
  void generate() {
    tiles = new int[w][h];

    float det = 0.1;
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int v = int(noise(i*det, j*det)*4);    
        tiles[i][j] = v;
      }
    }
  }
  void update() {
  }
  void show() {
    render.beginDraw();
    for (int j = 0; j < render.height; j++) {
      for (int i = 0; i < render.width; i++) {
        int x = i+int(camera.x)-render.width/2; 
        int y = j+int(camera.y)-render.height/2;
        int tx = x/20;
        int ty = y/20;
        int px = (x+20)%20;
        int py = (y+20)%20;
        color col = color(0);
        if (tx >= 0 && tx < w && ty >= 0 && ty < h) {
          int tile = tiles[tx][ty];
          boolean l = (tx > 0 && tiles[tx-1][ty] != tile);
          boolean r = (tx < w-1 && tiles[tx+1][ty] != tile);
          boolean t = (ty > 0 && tiles[tx][ty-1] != tile);
          boolean d = (ty < h-1 && tiles[tx][ty+1] != tile);
          col = sprites.get(tile*20+px, py);
        }
        render.set(i, j, col);
      }
    }
    render.endDraw();
  }
  boolean colision(int x, int y, int w, int h) {
    int xx = x/20;
    int yy = y/20;
    int ww = this.w;
    int hh = this.h;
    int cw = w/20+1;
    int ch = h/20+1;
    for (int j = -ch; j <= ch; j++) {
      for (int i = -cw; i <= cw; i++) {
        if (xx+i < 0 || xx+i >= ww || yy+j < 0 || yy+j >= hh) continue;
        int t = tiles[xx+i][yy+j];
        if (t == 1 || t == 2) continue;
        if (colisionRect((xx+i)*20+10, (yy+j)*20+10, 20, 20, x, y, w, h)) {
          return true;
        }
      }
    }
    return false;
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}

