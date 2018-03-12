int cw, ch, ss;
Tile tiles[][];

void setup() {
  size(400, 720);
  ss = 80;
  cw = width/ss;
  ch = height/ss;

  tiles = new Tile[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      tiles[i][j] = new Tile(i, j);
    }
  }
}

void draw() {
  stroke(0, 30);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      tiles[i][j].update();
      tiles[i][j].show();
    }
  }
}

void mousePressed() {
  int mx = mouseX/ss;
  int my = mouseY/ss;
  tiles[mx][my].water(1);
}

class Tile {
  int water;
  int x, y;
  int time;
  Tile(int x, int y) {
    this.x = x; 
    this.y = y;
    water = 0;
  }
  void update() {
    time--;
    if (time == 0 && water > 0) {
      time = 60*30;
      water--;
    }
  }
  void show() { 
    fill(lerpColor(#BF8F5C, #795228, water*0.2));  
    rect(x*ss, y*ss, ss, ss);
  }
  void water(int w) {
    water += w;
    time = 60*30;
  }
}

