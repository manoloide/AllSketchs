class World {

  ArrayList<Tile> tiles;
  ArrayList<Tile> active;
  float tileSize = 160*3;

  World() { 
    create();
  }

  void create() {

    tiles = new ArrayList<Tile>();
    active = new ArrayList<Tile>();

    updateActiveTiles();

    float x = 0;
    float y = 0; 
    float z = 0;
    int dir = 0;
    int col = color(#72B931);
    for (int i = 0; i < 100; i++) {
      col = lerpColor(rcol(), color(230), random(0.2, 0.3));
      tiles.add(new Tile(this, x, y, z, col)); 
      if (dir == 0) {
        z -= tileSize;
        dir = int(random(-2, 2)*random(0, 0.7));
      } else {
        x += dir*tileSize;
        //if (random(1) < 0.7) {
        dir = 0;
        //}
      }
    }
  }

  void updateActiveTiles() {
    active = new ArrayList<Tile>();
    PVector ts = new PVector(tileSize*15, tileSize*15, tileSize*15);
    for (int i = 0; i < tiles.size(); i++) {
      Tile tile = tiles.get(i);
      if (boxBox(player.position, player.size, tile.position, ts)) {
        active.add(tile);
      }
    }
  }

  void update() {

    updateActiveTiles();

    for (int i = 0; i < active.size(); i++) {
      active.get(i).update();
    }
  }

  void show() {
    for (int i = 0; i < active.size(); i++) {
      active.get(i).show();
    }
  }

  boolean collision(PVector pos, PVector s) {
    for (int i = 0; i < active.size(); i++) {
      if (active.get(i).collision(pos, s)) return true;
    }
    return false;
  }
}

class Tile {
  float size;
  int col;
  PVector position;
  boolean tile[][][];
  World world;
  Tile(World world, float x, float y, float z, int col) {
    this.world = world;
    size = world.tileSize/3;
    position = new PVector(x, y, z);
    this.col = col;

    tile = new boolean[3][3][3];
    for (int k = 0; k < 3; k++) {
      for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 3; i++) {
          tile[i][j][k] = false;
        }
      }
    }

    for (int k = 0; k < 3; k++) {
      int count = int(random(random(3, 5), 10)-(2-k)*3);
      while (count > 0) {
        int ix = int(random(3));
        int iy = k;
        int iz = int(random(3));
        if (!tile[ix][iy][iz]) {
          tile[ix][iy][iz] = true;
          count--;
        }
      }
    }
  }

  void update() {
  }

  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    float dx, dy, dz;
    strokeWeight(2);
    for (int k = -1; k <= 1; k++) {
      for (int j = -1; j <= 1; j++) {  
        for (int i = -1; i <= 1; i++) {
          dx = size*i;
          dy = size*j;
          dz = size*k;
          pushMatrix();
          translate(dx, dy, dz);
          noFill();
          if (!tile[i+1][j+1][k+1]) {
            stroke(255, 50);
            noFill();
          } else {
            noStroke();
            fill(col);
            box(size*0.96);
          }
          popMatrix();
        }
      }
    }
    popMatrix();
  }

  boolean collision(PVector pos, PVector s) {

    if (boxBox(pos, s, position, new PVector(world.tileSize, world.tileSize, world.tileSize))) {
      float dx, dy, dz;
      PVector ts = new PVector(size, size, size);
      for (int k = -1; k <= 1; k++) {
        for (int j = -1; j <= 1; j++) {  
          for (int i = -1; i <= 1; i++) {
            if (!tile[i+1][j+1][k+1]) continue;
            dx = size*i;
            dy = size*j;
            dz = size*k;
            if (boxBox(pos, s, position.copy().add(dx, dy, dz), ts))
              return true;
          }
        }
      }
    }
    return false;
  }
}

boolean boxBox(PVector a, PVector as, PVector b, PVector bs) {
  return boxBox(a.x, a.y, a.z, as.x, as.y, as.z, b.x, b.y, b.z, bs.x, bs.y, bs.z);
}

boolean boxBox(float ax, float ay, float az, float as, float bx, float by, float bz, float bs) {
  return boxBox(ax, ay, az, as, as, as, bx, by, bz, bs, bs, bs);
}

boolean boxBox(float ax, float ay, float az, float aw, float ah, float ad, float bx, float by, float bz, float bw, float bh, float bd) {

  float aMinX = ax-aw*0.5;
  float aMinY = ay-ah*0.5;
  float aMinZ = az-ad*0.5;
  float aMaxX = ax+aw*0.5;
  float aMaxY = ay+ah*0.5;
  float aMaxZ = az+ad*0.5;

  float bMinX = bx-bw*0.5;
  float bMinY = by-bh*0.5;
  float bMinZ = bz-bd*0.5;
  float bMaxX = bx+bw*0.5;
  float bMaxY = by+bh*0.5;
  float bMaxZ = bz+bd*0.5;

  return (aMinX <= bMaxX && aMaxX >= bMinX) &&
    (aMinY <= bMaxY && aMaxY >= bMinY) &&
    (aMinZ <= bMaxZ && aMaxZ >= bMinZ);
}
