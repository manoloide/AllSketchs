class Map {
  int seed;
  int tileSize = 50;
  int tileColor[] = {
    #A3BEDE, 
    #EDEDB6, 
    #A4DB92, 
    #91C481
  };

  ArrayList<Building> buildings;
  ArrayList<Entity> entities;
  boolean busy[][];
  int w, h;
  int tiles[][];

  Map(int w, int h) {
    this.w = w;
    this.h = h;

    buildings = new ArrayList<Building>();
    entities = new ArrayList<Entity>();

    entities.add(new Villager(width/2, height/2));
    entities.add(new Villager(width/2, height/2+100));
    entities.add(new Villager(width/2+100, height/2));
    entities.add(new Villager(width/2+100, height/2+100));
    createMap();
  }

  void update() {
    for (int i = 0; i < buildings.size (); i++) {
      Building b = buildings.get(i);
      b.update();
      if (b.remove) buildings.remove(i--);
    }
    for (int i = 0; i < entities.size (); i++) {
      Entity e = entities.get(i);
      e.update();
      if (e.remove) entities.remove(i--);
    }
  }

  void show() {
    noStroke();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        fill(tileColor[tiles[i][j]]);
        rect(i*tileSize, j*tileSize, tileSize, tileSize);
      }
    }

    for (int i = 0; i < buildings.size (); i++) {
      Building b = buildings.get(i);
      b.show();
    }
    for (int i = 0; i < entities.size (); i++) {
      Entity e = entities.get(i);
      e.show();
    }
  }

  void createMap() {
    seed = int(random(999999));
    noiseSeed(seed);
    busy = new boolean[w][h];
    tiles = new int[w][h];
    float det = 0.05;
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        busy[i][j] = false;
        int val = 0;
        float noi = noise(i*det, j*det);
        if (noi > 0.55) val = 3;
        else if (noi > 0.35) val = 2;
        else if (noi > 0.3) val = 1;
        tiles[i][j] = val;
      }
    }
  }
}
