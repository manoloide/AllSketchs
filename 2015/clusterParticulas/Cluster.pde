class Cluster {
  ArrayList<Particle> zones[][];
  int s;
  int cw, ch;
  Cluster() {
    s = 60;
    cw = width/s+1;
    ch = height/s+1;
    zones = new ArrayList[cw][ch];
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        zones[i][j] = new ArrayList<Particle>();
      }
    }
  }

  void update() {
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        zones[i][j].clear();
      }
    }
    for (int i = 0; i < particles.size (); i++) {
      Particle p = particles.get(i);
      int ix = int(p.position.x)/s;
      int iy = int(p.position.y)/s;
      for (int yy = -1; yy <= 1; yy++) {
        for (int xx = -1; xx <= 1; xx++) {
          if (ix+xx < 0 || ix+xx >= cw || iy+yy < 0 || iy+yy >= ch) continue;
          zones[ix+xx][iy+yy].add(p);
        }
      }
    }
    show();
  }

  void show() {
    stroke(220);
    noStroke();
    for (int i = 0; i < width; i+=s) {
      line(i, 0, i, height);
    }
    for (int i = 0; i < height; i+=s) {
      line(0, i, width, i);
    }
  }

  ArrayList<Particle> getCluster(float x, float y) {
    int ix = constrain(int(x)/s, 0, cw-1);
    int iy = constrain(int(y)/s, 0, ch-1);
    return zones[ix][iy];
  }
}

