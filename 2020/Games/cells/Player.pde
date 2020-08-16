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

    float dx = level.dx; 
    float dy = level.dy;
    float ls = level.s;

    pushMatrix();
    translate(dx, dy);

    strokeWeight(ls*0.05);

    stroke(0, 80);
    fill(0, 80);
    PVector a = points.get(0);
    float sy = s*0.05;
    for (int i = 1; i < points.size(); i++) {
      PVector p = points.get(i);
      noStroke();
      ellipse(a.x*ls, a.y*ls+sy, s*0.4, s*0.4);
      stroke(0, 80);
      line(a.x*ls, a.y*ls+sy, p.x*ls, p.y*ls+sy);
      a = p;
    }
    ellipse(x*ls, y*ls, s, s);

    int col = color(250, 70, 20);
    stroke(col);
    fill(col);
    a = points.get(0);
    for (int i = 1; i < points.size(); i++) {
      PVector p = points.get(i);
      noStroke();
      ellipse(a.x*ls, a.y*ls-sy, s*0.4, s*0.4);
      stroke(col);
      line(a.x*ls, a.y*ls-sy, p.x*ls, p.y*ls-sy);
      a = p;
    }
    ellipse(x*ls, y*ls-s*0.2, s, s);
    popMatrix();
  }

  void moved(int mx, int my) {
    int nx = x+mx; 
    int ny = y+my; 
    if (nx >= 0 && nx < level.w && ny >= 0 && ny < level.h && level.tiles[nx][ny] <= 0) {
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
