ArrayList<Cell> cells;

float scale = 1;
float maxDis = 40;
float lx1, ly1, lx2, ly2;

PVector center, camera;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  background(240); 


  updateRepulsion();

  center = new PVector();

  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    c.update();
    center.add(c.x, c.y);

    if (c.x < lx1 || i == 0) lx1 = c.x;
    if (c.y < ly1 || i == 0) ly1 = c.y;
    if (c.x > lx2 || i == 0) lx2 = c.x;
    if (c.y > ly2 || i == 0) ly2 = c.y;
  }
  center.div(cells.size());

  camera.lerp(center.copy().add(-(lx1+lx2), -(ly1+ly2)), 0.15);


  float ww = lx2-lx1;
  float hh = lx2-lx1;
  
  scale = lerp(scale, max(width*0.8/ww, height*0.8/hh), 0.12);

  translate(width*0.5, height*0.5);
  scale(min(2, scale));
  translate(camera.x, camera.y);


  rectMode(CORNERS);
  //rect(lx1, ly1, lx2, ly2);

  noFill();
  stroke(0, 180);
  beginShape();
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    vertex(c.x, c.y);
  }
  endShape(CLOSE);

  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    c.show();
  }
}

void updateRepulsion() {

  for (int i = 1; i < cells.size()+1; i++) {
    Cell ant = cells.get(i-1);
    Cell act = cells.get(i%cells.size());
    Cell nex = cells.get((i+1)%cells.size());

    if (!act.move) continue;

    float cx = (ant.x+nex.x)*0.5;
    float cy = (ant.y+nex.y)*0.5;

    act.x += constrain((cx-act.x)*0.4, -5, 5);
    act.y += constrain((cy-act.y)*0.4, -5, 5);
  }


  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    for (int j = i+1; j < cells.size(); j++) {
      Cell o = cells.get(j);
      c.repulsion(o);
    }
  }

  if (keyPressed) {
    for (int j = 0; j < 12; j++) {
      addPoint();
    }
  }
}

void keyPressed() {
  if (key == ' ') generate(); 
  else addPoint();
}

void addPoint() {
  int ind = int(random(1, cells.size()));

  Cell p1 = cells.get(ind-1);
  Cell p2 = cells.get(ind-0);

  cells.add(ind, new Cell((p1.x+p2.x)*0.5, (p1.y+p2.y)*0.5));
}

void generate() {
  camera = new PVector();
  cells = new ArrayList<Cell>();
  for (int i = 0; i < 10; i++) {
    Cell c = new Cell(width*random(-0.1, 0.1), height*random(-0.1, 0.1));
    //c.move = false;
    cells.add(c);
  }
}
