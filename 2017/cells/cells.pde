ArrayList<Cell> cells;
void setup() {
  size(1280, 720, P2D);
  pixelDensity(2);

  generate();
}

void draw() {
  background(30);

  for (int i = 0; i < cells.size(); i++) {
    Cell act = cells.get(i);
    for (int j = i+1; j < cells.size(); j++) {
      Cell ant = cells.get(j); 
      float d = dist(act.nx, act.ny, ant.nx, ant.ny);
      float md = (act.ns+ant.ns)*0.6;
      if (d < md) {
        float dd = md-d;
        float a = atan2(ant.ny-act.ny, ant.nx-act.nx);
        float dx = cos(a)*dd*0.1;
        float dy = sin(a)*dd*0.1;
        act.dx -= dx; 
        act.dy -= dy; 
        ant.dx += dx; 
        ant.dy += dy;
      }
    }
    if (mousePressed) {
      float d = dist(act.nx, act.ny, mouseX, mouseY);
      float md = (act.ns+200)*0.6;
      if (d < md) {
        float dd = md-d;
        float a = atan2(mouseY-act.ny, mouseX-act.nx);
        float dx = cos(a)*dd*0.1;
        float dy = sin(a)*dd*0.1;
        act.dx -= dx; 
        act.dy -= dy;
      }
    }
  }

  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    c.update(); 
    c.show();
  }
}

void keyPressed() {
  generate();
}


void mouseMoved() {
  for (int i = cells.size()-1; i >= 0; i--) {
    Cell c = cells.get(i);
    if (c.tt > 0) continue;
    if (dist(mouseX, mouseY, c.x, c.y) < c.s*0.5) {
      float ang = random(TWO_PI);
      float r = c.s*0.5;
      float area = pow(r, 2)*PI;
      float narea = area*0.5; 
      float nr = sqrt(narea/PI);
      float dx = cos(ang)*nr*1.1;
      float dy = sin(ang)*nr*1.1;
      cells.add(new Cell(c.x, c.y, c.s, c.c, c.x-dx, c.y-dy, nr*2, rcol()));
      cells.add(new Cell(c.x, c.y, c.s, c.c, c.x+dx, c.y+dy, nr*2, rcol()));
      cells.remove(i);
      break;
    }
  }
}

void generate() {
  cells = new ArrayList<Cell>();
  cells.add(new Cell(width/2, height/2, width*0.6, rcol()));
}

PVector des(PVector pos, float d, float s, float t) {
  pos.x += noise(pos.x*d, pos.y*d, t)*s-s*0.5; 
  pos.y += noise(pos.x*d+4535, pos.y*d, t+100)*s-s*0.5;
  return pos;
}

class Cell {
  color c, nc;
  float x, y, nx, ny;
  float dx, dy;
  float s, ns;
  float tt = 0.2;
  float det, des;
  Cell(float x, float y, float s, int c) {
    this(x, y, s, c, x, y, s, c);
  }
  Cell(float x, float y, float s, int c, float nx, float ny, float ns, int nc) {
    this.x = x; 
    this.y = y; 
    this.nx = nx; 
    this.ny = ny; 
    this.s = s;
    this.ns = ns;
    this.c = c; 
    this.nc = nc;
    det = random(0.2);//random(1);
  }

  void update() {
    x += dx; 
    nx += dx;
    y += dy; 
    ny += dy;
    dx = 0; 
    dy = 0;

    x += (nx-x)*0.1;
    y += (ny-y)*0.1;
    s += (ns-s)*0.1;

    tt -= 1./60;

    c = lerpColor(c, nc, 0.1);
  }

  void show() {
    noStroke();
    fill(c);
    float r = s*0.5;
    int res = max(16, int(PI*r*0.5));
    float da = TWO_PI/res;
    /*
    ArrayList<PVector> pts1, pts2;
     pts1 = new ArrayList<PVector>();
     pts2 = new ArrayList<PVector>();
     */
    float tt = millis()*0.0002;
    beginShape();
    fill(c);
    for (int i = 0; i < res; i++) {
      float a1 = da*i;
      PVector p1 = new PVector(x+cos(a1)*r, y+sin(a1)*r);
      des(p1, det/r, r*2, tt);
      vertex(p1.x, p1.y);
      /*
      PVector p2 = new PVector(x+cos(a1)*r*0.4, y+sin(a1)*r*0.4);
       des(p2, det, r*2, tt);
       pts1.add(p1);
       pts2.add(p2);
       */
    }
    endShape();
    /*
    for (int i = 0; i < res; i++) {
     int i2 = (i+1)%res;
     beginShape();
     fill(c);
     vertex(pts1.get(i).x, pts1.get(i).y);
     vertex(pts1.get(i2).x, pts1.get(i2).y);
     fill(255);
     vertex(pts2.get(i2).x, pts2.get(i2).y);
     vertex(pts2.get(i).x, pts2.get(i).y);
     endShape(CLOSE);
     beginShape();
     vertex(pts2.get(i2).x, pts2.get(i2).y);
     vertex(pts2.get(i).x, pts2.get(i).y);
     vertex(x, y);
     endShape(CLOSE);
     }
     */
    //ellipse(x, y, s, s); 
    fill(60);
    //ellipse(x, y, s*0.02, s*0.02);
  }
}

int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}