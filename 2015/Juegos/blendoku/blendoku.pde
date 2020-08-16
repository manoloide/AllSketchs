Locker lockers[][];
ArrayList<Piece> pieces;
boolean click;
Locker lockerSelect;
Piece select;

void setup() {
  size(640, 640);
  rectMode(CENTER);
  generate();
}

void draw() {
  background(80);
  //lockerSelect = null;
  for (int j = 0; j < lockers[0].length; j++) {
    for (int i = 0; i < lockers.length; i++) {
      if (lockers[i][j] != null)
        lockers[i][j].update();
    }
  }
  for (int i = pieces.size ()-1; i >= 0; i--) {
    Piece p = pieces.get(i);
    p.update();
  }

  for (int i = 0; i < pieces.size (); i++) {
    Piece p = pieces.get(i);
    p.show();
  }
  click = false;
}

void keyPressed() {
  if (key == 'g') generate();
}

void mousePressed() {
  click = true;
}

void orderPieces() {
  for (int i = 0; i < pieces.size ()-1; i++) {
    Piece p = pieces.get(i);
    if (p.drag) {
      pieces.add(pieces.size(), p);
      pieces.remove(i--);
    }
  }
}

void generate() {
  pieces = new ArrayList<Piece>();

  int cw = 6; 
  int ch = 6;
  int sep = 10;
  int size = 60;
  int dx = (width-(cw-1)*(sep+size))/2;
  int dy = (height-(ch-1)*(sep+size))/2;
  lockers = new Locker[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      int x = dx+i*(size+sep);
      int y = dy+j*(size+sep);
      lockers[i][j] = new Locker(x, y, size);
    }
  }
  for (int i = 0; i < 2; i++) {
    boolean hor = (random(1) < 0.5)? true : false;
    int cc = int(random(3, ch));
    if (hor) cc = int(random(3, cw));
    int x = int(random(cw-cc));
    int y = int(random(ch-cc));
    color c1 = color(random(256), random(256), random(256));
    color c2 = color(random(256), random(256), random(256));
    for (int k = 0; k < cc; k++) {
      int ix = ((hor)? x+k : x);
      int iy = ((!hor)? y+k : y);
      int xx = dx+ix*(size+sep);
      int yy = dy+iy*(size+sep);
      color col = lerpColor(c1, c2, map(k, 0, cc-1, 0, 1));
      Piece piece = new Piece(xx, yy, size, col);
      pieces.add(piece);
      piece.setLocker(lockers[ix][iy]);
      lockers[ix][iy].active = true;
    }
  }
}


class Locker {
  boolean active, on;
  Piece piece;
  float x, y, s;
  Locker(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;
    active = false;
  }
  void update() {
    //if (!active) return; 
    if (mouseX > x-s/2 && mouseX < x+s/2 && mouseY > y-s/2 && mouseY < y+s/2) {
      on = true;
      lockerSelect = this;
    } else {
      on = false;
    }
    show();
  }
  void show() {
    stroke(90);
    strokeWeight(2);
    noFill();
    rect(x, y, s, s, 6);
  }
}

class Piece {
  boolean on, drag;
  color col;
  float x, y, s;
  Locker locker;
  Piece(float x, float y, float s, color col) {
    this.x = x; 
    this.y = y;
    this.s = s;
    this.col = col;
  }
  void update() {
    if (mouseX > x-s/2 && mouseX < x+s/2 && mouseY > y-s/2 && mouseY < y+s/2) {
      on = true;
    } else {
      on = false;
    }

    if (drag) {
      if (!mousePressed) {
        drag = false;
        select = null;
        Piece aux = lockerSelect.piece;
        Locker la = locker;
        if (aux != null) {
          aux.setLocker(la);
        } else {
          locker.piece = null;
        }
        if (lockerSelect != null) {
          setLocker(lockerSelect);
        }
      } else {
        x += mouseX-pmouseX;
        y += mouseY-pmouseY;
      }
    } else {
      x += (locker.x-x)*0.6;
      y += (locker.y-y)*0.6;
    }

    if (on && click) {
      if (select == null) {
        select = this;
        drag = true;
        orderPieces();
      }
    }
  }
  void show() {
    stroke((on)? 240 : 180);
    fill(col);
    rect(x, y, s, s, 6);
  }

  void setLocker(Locker locker) {
    this.locker = locker;
    locker.piece = this;
  }
}

