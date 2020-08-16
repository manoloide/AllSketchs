class Level {
  boolean used[][];
  int w, h; 
  int values[][];
  int tiles[][];
  int totalValues;
  float s, ss, dx, dy;
  Player player;
  PVector init, end;
  Level() {
    create();
  }

  void create() { 
    w = int(random(3, random(4, 8)));
    h = int(random(3, random(4, 8)));
    used = new boolean[w][h];
    values = new int[w][h];
    tiles = new int[w][h];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        used[i][j] = false;
        values[i][j] = int(random(-5, 5)*random(0.3, 1));
        tiles[i][j] = int(random(1.1));
      }
    }

    s = min(width/(w+2.), height/(h+2.));
    ss = s*0.82;
    dx = (width-(w-1)*s)*0.5;
    dy = (height-(h-1)*s)*0.5;

    init = new PVector(int(random(w)), int(random(h)));
    end = new PVector(int(random(w)), int(random(h)));
    while (init.x == end.x && init.y == end.y) {
      end = new PVector(int(random(w)), int(random(h)));
    }
    values[int(init.x)][int(init.y)] = 0;
    values[int(end.x)][int(end.y)] = 0;
    tiles[int(init.x)][int(init.y)] = 0;
    tiles[int(end.x)][int(end.y)] = 0;
    player = new Player(this, int(init.x), int(init.y));
  }

  void update() {
    player.update();
    if (player.x == end.x && player.y == end.y && totalValues >= 0) {
      create();
    }
  }

  void show() {    
    noStroke();
    fill(60);

    rectMode(CENTER);

    textAlign(CENTER, CENTER);
    textSize(ss*0.6);
    totalValues = 0;
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        float xx = dx+s*i;
        float yy = dy+s*j;
        if(tiles[i][j] != 0) continue;
        fill(60);
        rect(xx, yy+ss*0.1, ss, ss, ss*0.05);
        fill(80);
        float dy = 0;
        if(used[i][j]) {
          dy = ss*0.025;
          totalValues += values[i][j];
        }
        rect(xx, yy+dy, ss, ss, ss*0.05);
        fill(0, 180);
        if (i == init.x && j == init.y) 
          ellipse(xx, yy, s*0.6, s*0.6);
        if (i == end.x && j == end.y) 
          ellipse(xx, yy, s*0.6, s*0.6);
        if (!used[i][j] && values[i][j] != 0) {
          fill(0, 90);
          text(values[i][j], xx, yy);
          fill(200);
          text(values[i][j], xx, yy-ss*0.08);
        }
      }
    }
    
    fill(230);
    textSize(40);
    text(totalValues, width*0.5, ss*0.5);
    player.show();
  }
}
