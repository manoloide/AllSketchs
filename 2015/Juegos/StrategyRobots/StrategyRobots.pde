ArrayList<Entity> entities;
boolean click;
int scale = 2;
Level level;
PGraphics render;
PImage sprites;
PImage tiles[][];

void setup() {
  size(640, 480);
  noSmooth();
  render = createGraphics(width/scale, height/scale);
  sprites = loadImage("sprites.png");
  tiles = createTiles(sprites, 16, 16);

  entities = new ArrayList<Entity>();
  entities.add(new Worker(width/4, height/4));
  level = new Level();
}

void draw() {
  render.beginDraw();
  render.background(0);
  level.show();
  for (int i = 0; i < entities.size (); i++) {
    Entity e = entities.get(i);
    e.update();
    if (e.remove) entities.remove(i--);
  }
  render.endDraw();
  image(render, 0, 0, width, height);

  click = false;
}

void keyPressed() {
  level.createLevel();
}

void mousePressed() {
  click = true;
}

class Level {
  int w, h;
  int data[][];
  Level() {
    w = 22;
    h = 16;
    createLevel();
  }
  void show() {
    PImage tile = tiles[0][5];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (data[i][j] == 0) tile = tiles[0][5];
        if (data[i][j] == 1) {
          boolean l = (i > 0 && data[i-1][j] != 1);
          boolean r = (i < w-1 && data[i+1][j] != 1);
          boolean t = (j > 0 && data[i][j-1] != 1);
          boolean d = (j < h-1 && data[i][j+1] != 1);
          tile = tiles[0][6];
          if (l && r && t && d) {
            tile = tiles[3][3];
          } else {
            if (l) tile = tiles[0][3];
            if (t) tile = tiles[1][2];
            if (r) tile = tiles[2][3];
            if (d) tile = tiles[1][4];
            if (l && t) tile = tiles[0][2];
            if (t && r) tile = tiles[2][2];
            if (r && d) tile = tiles[2][4];
            if (d && l) tile = tiles[0][4];
            if (l && r) {
              if (t) tile = tiles[4][3];
              else if (d) tile = tiles[4][5];
              else tile = tiles[4][4];
            }
            if (d && t) {
              if (l) tile = tiles[3][2];
              else if (r) tile = tiles[5][2];
              else tile = tiles[4][2];
            }
          }
        }
        render.image(tile, i*16, j*16);
      }
    }
  }
  void createLevel() {
    data = new int[w][h];
    float det = 0.1;
    noiseSeed(int(random(999999999)));
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        data[i][j] = int(noise(i*det, j*det)*2);
      }
    }
  }
}

PImage[][] createTiles(PImage img, int w, int h) {
  int cw = img.width/w;
  int ch = img.height/h;
  PImage tiles[][] = new PImage[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      tiles[i][j] = createImage(w, h, ARGB);
      tiles[i][j].copy(img, i*cw, j*ch, w, h, 0, 0, w, h);
    }
  }
  return tiles;
}

