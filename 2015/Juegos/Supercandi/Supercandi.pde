boolean click;
Level level;
int pallete[] = {
  #FF003C, 
  #FF8A00, 
  #FABE28, 
  #88C100, 
  #00C176
};

void setup() {
  size(400, 600);
  level = new Level();
}

void draw() {
  background(160-40);

  int sep = 10;
  stroke(150-40);
  strokeWeight(sep*0.66);
  for (int i = ( (frameCount/2)% (sep*2))-sep; i < width+height; i+=sep*2) {
    line(-2, i, i, -2);
  }

  level.update();
  level.show();
  click = false;
}
void keyPressed() {
  if (key == 'r') level.generate();
}

void mousePressed() {
  click = true;
}

class Level {
  ArrayList<Candy> candys;
  boolean calculate, full;
  Candy tiles[][];
  int w, h;
  Level() {
    w = 8;
    h = 12;
    generate();
  }
  void update() {
    for (int i = 0; i < candys.size (); i++) {
      Candy c = candys.get(i);
      c.update();
      if (c.remove) removeCandy(c);
      if (candys.size() == w*h) full = true;
      else full = false;
    }

    if (full && calculate) {
      clearGroups();
      calculate = false;
    }

    for (int i = 0; i < w; i++) {
      if (tiles[i][0] == null) {
        addCandy(i, 0);
      }
    }

    show();
  }
  void show() {
    for (int i = 0; i < candys.size (); i++) {
      Candy c = candys.get(i);
      c.show();
    }
  }
  void generate() {
    tiles = new Candy[w][h];
    candys = new ArrayList<Candy>();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        addCandy(i, j);
      }
    }
    clearMovement();
  }

  void clearMovement() {
    boolean clear = false;
    while (!clear) {
      clear = true;
      for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
          int t = tiles[i][j].type;
          if ((i > 0 && i < w-1 && t == tiles[i-1][j].type && t == tiles[i+1][j].type) ||
            (j > 0 && j < h-1 && t == tiles[i][j-1].type && t == tiles[i][j+1].type)) {
            int nt = int(random(pallete.length));
            while (nt == t) nt = int(random(pallete.length));
            tiles[i][j].changeType(nt);
            clear = false;
          }
        }
      }
    }
  }

  void clearGroups() {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int t = tiles[i][j].type;
        if (i > 0 && i < w-1 && t == tiles[i-1][j].type && t == tiles[i+1][j].type) {
          tiles[i-1][j].hidden();
          tiles[i][j].hidden();
          tiles[i+1][j].hidden();
        }
        if (j > 0 && j < h-1 && t == tiles[i][j-1].type && t == tiles[i][j+1].type) {
          tiles[i][j-1].hidden();
          tiles[i][j].hidden();
          tiles[i][j+1].hidden();
        }
      }
    }
  }

  void addCandy(int x, int y) {
    Candy c = new Candy(this, x, y);
    tiles[x][y] = c;
    candys.add(c);
  }

  void removeCandy(Candy c) {
    candys.remove(c);
    tiles[c.tx][c.ty] = null;
  }

  void setTile(int tx, int ty, Candy c) {
    tiles[tx][ty] = c;
    calculate = true;
  }

  PVector getPositionCandy(int x, int y) {
    float sep = min(width/(w+1), height/(h+1));
    float dx = (width-sep*(w-1))/2;
    float dy = (height-sep*(h-1))/2;
    return new PVector((x)*sep+dx, (y)*sep+dy);
  }
}

class Candy {
  boolean on, drag;
  boolean hide, remove;
  color col; 
  float x, y, s, cx, cy, vx, vy;
  int tx, ty;
  int type;
  float timeOn, timeHide; 
  Level parent;
  Candy(Level parent, int tx, int ty) {
    this.parent = parent; 
    this.tx = tx; 
    this.ty = ty;
    updatePosition();
    x = cx;
    y = -100;
    s = 24;
    type = int(random(pallete.length));
    col = color(pallete[type]);
  }
  void update() {
    if (abs(x-mouseX)+abs(y-mouseY) < s) {
      on = true;
      timeOn += 1./20;
      if (timeOn > 1) timeOn = 1;
      if (click) drag = true;
    } else {
      on = false;
      timeOn -= 1./20;
      if (timeOn < 0) timeOn = 0;
    }
    if (!mousePressed) {
      if (drag) {
        drag = false;
        calculateChange();
      }
    }

    if (hide) {
      timeHide -= 1./15;
      if (timeHide < 0) {
        timeHide = 0;
        remove = true;
      }
    }

    if (drag) {
      x = mouseX;
      y = mouseY;
      //remove();
    } else {
      if (ty < parent.h-1 && parent.tiles[tx][ty+1] == null) {
        parent.setTile(tx, ty, null);
        ty++;
        parent.setTile(tx, ty, this);
        updatePosition();
      }

      vx += (cx-x)*0.12;
      vy += (cy-y)*0.12;
      vx *= 0.72;
      vy *= 0.72;

      x += vx;
      y += vy;
    }
  }
  void show() {
    if (timeOn > 0) {
      stroke(240);
      strokeWeight(sin(timeOn*PI*0.75)*5);
    } else {
      noStroke();
    }
    fill(col);

    float ss = s;
    if (hide) {
      fill(lerpColor(col, color(255), sin(PI/2*timeHide))); 
      ss = sin(PI*0.75*timeHide)*this.s;
    }
    ellipse(x, y, ss, ss);
  }

  void changeType(int t) {
    type = t;
    col = color(pallete[type]);
  }

  void updatePosition() {
    PVector pos = parent.getPositionCandy(tx, ty);
    cx = pos.x;
    cy = pos.y;
    parent.setTile(tx, ty, this);
  }

  void calculateChange() {
    int ax = tx;
    int ay = ty;
    Candy nears[] = new Candy[4];
    if (tx > 0) nears[0] = parent.tiles[tx-1][ty];
    if (tx < parent.w-1) nears[1] = parent.tiles[tx+1][ty];
    if (ty > 0) nears[2] = parent.tiles[tx][ty-1];
    if (ty < parent.h-1) nears[3] = parent.tiles[tx][ty+1];
    for (int i = 0; i < 4; i++) {
      Candy c = nears[i];
      if (c == this || c == null) continue;
      if (abs(c.x-x)+abs(c.y-y) < s) {
        tx = c.tx;
        ty = c.ty;
        updatePosition();
        c.tx = ax;
        c.ty = ay;
        c.updatePosition();
        break;
      }
    }
  }

  void hidden() {
    hide = true;
    timeHide = 1;
  }

  void remove() {
    remove = true;
    parent.tiles[tx][ty] = null;
  }
}

