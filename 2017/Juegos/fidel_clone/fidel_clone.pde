Level level;
PFont font;

void setup() {
  size(720, 720); 
  pixelDensity(2);
  smooth(8);
  font = createFont("Moon Bold.otf", 40, true);
  textFont(font);
  level = new Level();
}

void draw() {
  background(30);
  level.update();
  level.show();
}

void keyPressed() {
  if (key == 'w' || keyCode == UP) level.player.moved(0, -1);
  if (key == 's' || keyCode == DOWN) level.player.moved(0, +1);
  if (key == 'a' || keyCode == LEFT) level.player.moved(-1, 0);
  if (key == 'd' || keyCode == RIGHT) level.player.moved(+1, 0);
  if (key == 'g') level = new Level();
}

class Player {
  ArrayList<PVector> points;  
  int x, y; 
  float s;
  Level level;
  Player(Level level, int x, int y) {
    this.level = level;
    this.x = x; 
    this.y = y; 
    s = level.s*0.3;

    points = new ArrayList<PVector>();
    moved(0, 0);
  }
  void update() {
  }
  void show() {
    fill(255, 50, 0);
    float dx = level.dx; 
    float dy = level.dy;
    float ls = level.s;

    pushMatrix();
    translate(dx, dy);
    stroke(255, 50, 0);
    strokeWeight(ls*0.06);
    PVector a = points.get(0);
    for (int i = 1; i < points.size(); i++) {
      PVector p = points.get(i);
      ellipse(a.x*ls, a.y*ls, s*0.2, s*0.2);
      line(a.x*ls, a.y*ls, p.x*ls, p.y*ls);
      a = p;
    }
    ellipse(x*ls, y*ls, s, s);
    popMatrix();
  }

  void moved(int mx, int my) {
    int nx = x+mx; 
    int ny = y+my; 
    if (nx >= 0 && nx < level.w && ny >= 0 && ny < level.h) {
      boolean used = level.used[nx][ny];
      if (points.size() >= 2) {
        PVector ant = points.get(points.size()-2);
        if (used && nx == ant.x && ny == ant.y) {
          PVector p = points.remove(points.size()-1);
          level.used[int(p.x)][int(p.y)] = false;
          points.remove(points.size()-1);
          used = false;
        }
      }
      if (!used) {
        x = nx; 
        y = ny;
        points.add(new PVector(x, y));
        level.used[x][y] = true;
      }
    }
  }
}

class Level {
  boolean used[][];
  int w, h; 
  int values[][];
  float s, ss, dx, dy;
  Player player;
  PVector init, end;
  Level() {
    create();
  }

  void create() { 
    w = int(random(3, 10));
    h = int(random(3, 10));
    used = new boolean[w][h];
    values = new int[w][h];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        used[i][j] = false;
        values[i][j] = int(random(-4, 4)*random(0.3, 1)*random(1));
      }
    }

    s = min(width/(w+2.), height/(h+2.));
    ss = s*0.8;
    dx = (width-(w-1)*s)*0.5;
    dy = (height-(h-1)*s)*0.5;

    init = new PVector(int(random(w)), int(random(h)));
    end = new PVector(int(random(w)), int(random(h)));
    while (init.x == end.x && init.y == end.y) {
      end = new PVector(int(random(w)), int(random(h)));
    }
    values[int(init.x)][int(init.y)] = 0;
    values[int(end.x)][int(end.y)] = 0;
    player = new Player(this, int(init.x), int(init.y));
  }

  void update() {
    player.update();
    if (player.x == end.x && player.y == end.y) {
      create();
    }
  }

  void show() {    
    noStroke();
    fill(60);

    rectMode(CENTER);

    textAlign(CENTER, CENTER);
    textSize(ss*0.6);
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        float xx = dx+s*i;
        float yy = dy+s*j;
        fill(60);
        rect(xx, yy+ss*0.1, ss, ss, ss*0.05);
        fill(70);
        rect(xx, yy, ss, ss, ss*0.05);
        fill(0, 180);
        if (i == init.x && j == init.y) 
          ellipse(xx, yy, s*0.6, s*0.6);
        if (i == end.x && j == end.y) 
          ellipse(xx, yy, s*0.6, s*0.6);
        if (!used[i][j] && values[i][j] != 0) {
          fill(0, 80);
          text(values[i][j], xx, yy);
          fill(200);
          text(values[i][j], xx, yy-ss*0.08);
        }
      }
    }
    player.show();
  }
}