class Map {

  int seed;
  int cw, ch;
  int tiles[][];
  float noise[][];
  float detCol;

  Map() {
    cw = width/tileSize;
    ch = height/tileSize;
    create();
  }

  void create() {

    seed = int(random(9999999));
    noiseSeed(seed);
    randomSeed(seed);


    objects.clear();
    stats.water = -12;

    detCol = random(0.1)*random(0.5, 1);
    tiles = new int[cw][ch];
    noise = new float[cw][ch];

    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        tiles[i][j] = (random(1) < 0.1 && i > 0 && i < cw-1 && j > 0 && j < ch-1)? 1 : 0;
        noise[i][j] = random(1);
      }
    }

    for (int j = -1; j <= 1; j++) {
      for (int i = -1; i <= 1; i++) {
        int tx = int(player.position.x+i*tileSize*0.5);
        int ty = int(player.position.y+j*tileSize*0.5);
        boolean border = tx < 0 || tx >= cw || ty < 0 || ty >= ch;
        if (!border)
          tiles[tx][ty] = 1;
      }
    }

    int cc = int(random(4, 16));
    for (int k = 0; k < cc; k++) {
      int ww = int(random(1, random(8, 10))*random(0.5, 1));
      int hh = int(random(1, random(10, 14))*random(0.5, 1));
      int xx = int(random(1, cw-ww-1));
      int yy = int(random(1, ch-hh-1));
      for (int j = 0; j < hh; j++) {
        for (int i = 0; i < ww; i++) {
          tiles[xx+i][yy+j] = 1;
        }
      }
    }

    for (int j = 1; j < ch-1; j++) {
      for (int i = 1; i < cw-1; i++) {
        if (tiles[i][j] == 0) {
          float xx = (i+0.5)*tileSize;
          float yy = (j+0.5)*tileSize;
          if (random(1) < 0.05) {
            objects.add(new Coin(xx, yy, tileSize*0.4, tileSize*0.4));
          } else if (random(1) < 0.1 && j < ch-1 && tiles[i][j+1] != 0 && j > 0 && tiles[i][j-1] == 0) {
            objects.add(new Springboard(xx, yy+tileSize*0.4, tileSize-4, tileSize*0.2));
          }
        }
      }
    }

    int xx = int(random(4, cw-4));
    int yy = int(random(4, ch/2));
    while (tiles[xx][yy] != 0) {
      xx = int(random(4, cw-4));
      yy = int(random(4, ch/2));
    }
    objects.add(new Portal((xx+0.5)*tileSize, (yy+0.5)*tileSize, tileSize*1.2, tileSize*1.2));
  }

  void show() {

    noStroke();

    rectMode(CORNER);
    for (int i = 0; i < ch; i++) {
      fill(getColor(i*0.2+global.time*-1), 40);
      rect(0, i*tileSize, width, tileSize);
    }

    noStroke();
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        if (tiles[i][j] != 0) {

          // puente
          if (j > 0 && j < ch-1 && tiles[i][j-1] == 0 && tiles[i][j+1] == 0) {
            float hei = 0.12;
            fill(#7a5951);
            rect(i*tileSize, j*tileSize, tileSize, tileSize*hei);
            tiles[i][j] = 2;

            fill(0);
            float amp1 = 0.24;
            float amp2 = 0.36;
            if (i-1 < 0 || tiles[i-1][j] == 1) {
              quad(i*tileSize, (j+amp1+hei)*tileSize, (i+amp1)*tileSize, (j+hei)*tileSize, (i+amp2)*tileSize, (j+hei)*tileSize, i*tileSize, (j+amp2+hei)*tileSize);
            }
            if (i+1 >= cw || tiles[i+1][j] == 1) {
              quad((i+1)*tileSize, (j+amp1+hei)*tileSize, (i+1-amp1)*tileSize, (j+hei)*tileSize, (i+1-amp2)*tileSize, (j+hei)*tileSize, (i+1)*tileSize, (j+amp2+hei)*tileSize);
            }
          } 
          // tierra
          else {

            tiles[i][j] = 1;

            fill(getColor(noise(i*detCol, j*detCol, global.time*0.05)*colors.length*2));
            rect(i*tileSize, j*tileSize, tileSize, tileSize);


            //pasto
            if (j > 0 && tiles[i][j-1] == 0) {

              float xx = i*tileSize;
              float yy = j*tileSize;
              float ww = tileSize;

              if (i > 0 && tiles[i-1][j] == 0) {
                xx -= 2;
                ww += 2;
              }

              if (i < cw-1 && tiles[i+1][j] == 0) {
                ww += 2;
              }

              fill(0, 30);
              rect(i*tileSize, yy, tileSize, tileSize*(0.18+noise[i][j]*0.04));
              fill(colors[2]);
              rect(xx, yy, ww, tileSize*(0.1+noise[i][j]*0.04));

              float pw = tileSize*0.2;
              float ph = tileSize*0.06;
              float noi = noise[i][j];
              for (int k = 0; k < 8; k++) {
                float osc = cos(global.time*1.2+k);
                float px = (i+(noi+((noi+1)*k*0.15))%1)*tileSize;
                triangle(px+osc*1.4, yy-ph*osc, px-pw*0.5, yy, px+pw*0.5, yy); 
                //rect(px, py, pw, ph);
              }
            }
          }

          //grid tiles
          for (int dy = -1; dy < 2; dy++) {
            for (int dx = -1; dx < 2; dx++) {
              int ax = i+dx;
              int ay = j+dy;
              if (ax >= 0 && ax < cw && ay >= 0 && ay < ch && tiles[ax][ay] == 0)
                fill(255, 100);
              else 
              fill(40, 100);

              rect((i+0.45+dx*0.2)*tileSize, (j+0.45+dy*0.2)*tileSize, tileSize*0.1, tileSize*0.1);
            }
          }
          // shadows;
          if ( j < ch-1 && tiles[i][j+1] == 0 && tiles[i][j] == 1) {
            beginShape();
            fill(0, 40);
            vertex(i*tileSize, (j+1)*tileSize);
            vertex((i+1)*tileSize, (j+1)*tileSize);
            fill(0, 0);
            vertex((i+1)*tileSize, (j+1.5)*tileSize);
            vertex(i*tileSize, (j+1.5)*tileSize);
            endShape();
          }
        }
      }
    }
  }

  void click(int mx, int my) {
    int tx = int(mx/tileSize);
    int ty = int(my/tileSize);
    if (stats.coins > 0) {
      stats.coins--;
      tiles[tx][ty] = (tiles[tx][ty] != 0)? 0 : 1;
    }
  }

  boolean collision(PVector position, float w, float h) {
    for (int j = -1; j <= 1; j++) {
      for (int i = -1; i <= 1; i++) {
        int tx = int(position.x/tileSize)+i;
        int ty = int(position.y/tileSize)+j;
        boolean border = tx < 0 || tx >= cw || ty < 0 || ty >= ch;

        float hh = tileSize;
        if (!border && tiles[tx][ty] == 2)
          hh = tileSize*0.12;

        if (rectCollision(position.x-w*0.5, position.y-h*0.5, w, h, (tx)*tileSize, (ty)*tileSize, tileSize, hh)) {
          if (border) return true;
          if (tiles[tx][ty] != 0) return true;
        }
      }
    }
    return false;
  }
}

boolean rectCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  return !(x1 > x2+w2 || x1+w1 < x2 || y1 > y2+h2 || y1+h1 < y2);
}
