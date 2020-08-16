ArrayList<Quads> quads;

void setup() {
  size(960, 960);
  generate();
  background(10);
}


void draw() {
  /*
  fill(0, 6);
   rect(width/2, height/2, width, height);
   */
  background(10);  
  for (int i = 0; i < quads.size(); i++) {
    quads.get(i).update();
  }
}

void keyPressed() {
  generate();
}

void generate() {
  quads = new ArrayList<Quads>(); 
  for (int i = 0; i < 1; i++) {
    quads.add(new Quads());
  }
}

class Quad {
  boolean arrive;
  int x, y;
  PVector pos, tar;
  float ss = 5;
  float vel = 0.03;
  Quads parent;
  Quad(Quads parent, int x, int y, int tx, int ty) {
    this.parent = parent;
    this.x = tx;
    this.y = ty;
    this.pos = new PVector(x*parent.size, y*parent.size);
    this.tar = new PVector(tx*parent.size, ty*parent.size);
    arrive = false;
  }
  void update() {
    if (!arrive) {
      PVector aux = tar.copy();
      aux.sub(pos);
      aux.mult(vel);
      pos.add(aux);
      if (tar.dist(pos) < 0.08) arrive = true;
    }

    if (frameCount%parent.timeSearch == 0 && arrive) {
      searchNeighbor();
    }
  }

  void searchNeighbor() {
    int nq = int(random(4));
    if (nq == 0 && x > 0 && parent.quads[x-1][y] == null) {
      parent.quads[x-1][y] = new Quad(parent, x, y, x-1, y);
    }
    if (nq == 1 && x < parent.cw-1 && parent.quads[x+1][y] == null) {
      parent.quads[x+1][y] = new Quad(parent, x, y, x+1, y);
    }
    if (nq == 2 && y > 0 && parent.quads[x][y-1] == null) {
      parent.quads[x][y-1] = new Quad(parent, x, y, x, y-1);
    }
    if (nq == 3 && y < parent.ch-1 && parent.quads[x][y+1] == null) {
      parent.quads[x][y+1] = new Quad(parent, x, y, x, y+1);
    }
  }

  void show() {
    noStroke();
    //fill(255);
    rectMode(CENTER);
    rect(pos.x, pos.y, ss, ss);
  }
}


class Quads {
  color col;
  float zoom, velZoom;
  int size = 40;
  int cw;
  int ch;
  int timeSearch = 20;
  Quad[][] quads;
  void update() {
    zoom += velZoom;
    pushMatrix();
    translate(width/2, height/2);
    scale(zoom);
    translate(-width/2, -height/2);
    int nulls = 0;
    fill(col);
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        if (quads[i][j] != null) {
          quads[i][j].update();
          quads[i][j].show();
        } else {
          nulls++;
        }
      }
    }
    if (nulls == 0) generate();
    popMatrix();
  }

  void show() {
  }

  void generate() {
    col = color(255);//color(random(100, 256), random(100, 256), random(100, 256)); 
    size = int(random(20, 180));
    timeSearch = int(random(10, 50));
    cw = width/size+1;
    ch = width/size+1;
    zoom = 1;
    velZoom = random(0.004)*random(-0.1, 1);
    quads = new Quad[cw][ch];
    int cc = int(random(8, 20));
    for (int i = 0; i < cc; i++) {
      int x = int(random(cw)); 
      int y = int(random(ch));
      quads[x][y] = new Quad(this, x, y, x, y);
    }
  }
}