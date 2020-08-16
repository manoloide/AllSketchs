Quad quad;

void setup() {
  size(960, 960);
  rectMode(CENTER);
  noStroke();
  generate();
}

void draw() {
  background(0);

  if (random(100) < 10) {
    //quad.sub(30);
    quad.join(50);
  }

  quad.update();
}

void keyPressed() {
  if (key == 'g') generate();
}

void generate() {
  quad = new Quad(width/2, height/2, width);
  for (int i = 0; i < 50; i++) {
    quad.sub(0);
  }
}

class Quad {
  ArrayList<Quad> quads;
  boolean sub, remove;
  color col, ncol;
  float x, y, s;
  int time, transTime;
  Quad parent;
  Quad(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;
    parent = null;
    quads = new ArrayList<Quad>();
    col = rcol();
  }
  Quad(float x, float y, float s, Quad parent) {
    this.x = x; 
    this.y = y;
    this.s = s;
    this.parent = parent;
    quads = new ArrayList<Quad>();
    ncol = rcol();
    ncol = color(random(256), random(256), random(256));
    while (ncol == parent.col) 
      ncol = rcol();
    col = parent.col;
    time = transTime = parent.transTime;
    if (time == 0) col = ncol;
  }

  void update() {
    if (time > 0) {
      time--;
      float v = map(time, 0, transTime, 1, 0);
      if (remove) v = 1-v;
      if (parent != null) col = lerpColor(parent.col, ncol, v);
    }

    if (sub) {
      if (remove) {
        if (time == 0) {
          sub = false;
          remove = false;
          quads = new ArrayList<Quad>();
          println("sub false");
        }
        show();
      }
      for (int i = 0; i < quads.size(); i++) {
        quads.get(i).update();
      }
    } else {
      show();
    }
  }

  void show() {
    stroke(0, 20);
    noFill();
    rect(x-1, y-1, s, s);
    noStroke();
    fill(col);
    rect(x, y, s, s);
  }

  void join(int tt) {
    if (time > 0) return;
    boolean join = true;
    for (int i = 0; i < quads.size(); i++) {
      if (quads.get(i).sub) {
        join = false;
        break;
      }
    }
    if (join) {
      remove = true;
      time = transTime = tt;
      ;
    } else {
      quads.get(int(random(quads.size()))).join(tt);
    }
  }

  void sub(int tt) {
    if (time > 0) return;
    if (sub) {
      quads.get(int(random(quads.size()))).sub(tt);
    } else {
      float ms = s*0.5;
      float dd = ms*0.5;
      quads.add(new Quad(x-dd, y-dd, ms, this));
      quads.add(new Quad(x+dd, y-dd, ms, this));
      quads.add(new Quad(x-dd, y+dd, ms, this));
      quads.add(new Quad(x+dd, y+dd, ms, this));
      sub = true;
      time = transTime = tt;
    }
  }
}

color colors[] = {#de4a1e, #ed8673, #567cc6, #91a9e1, #f0e0a7};
int rcol() {
  return colors[int(random(colors.length))];
}