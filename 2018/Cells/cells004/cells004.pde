import toxi.math.noise.SimplexNoise;

ArrayList<Cell> cells;

float time = 0;
float scale = 1;
float maxDis = 120;
float lx1, ly1, lx2, ly2;

PVector center, camera;

float det, des;

void setup() {
  size(540, 960, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {

  time = millis()*0.001;

  background(80); 

  noiseDetail(2);


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

    if (c.remove) {
      cells.remove(i--);
    }
  }
  center.div(cells.size());

  camera.lerp(center.copy().add(-(lx1+lx2), -(ly1+ly2)), 0.08);


  float ww = lx2-lx1;
  float hh = lx2-lx1;

  scale = lerp(scale, max(width*1.2/ww, height*1.2/hh), 0.5);

  translate(width*0.5, height*0.5);
  scale(min(3, scale));
  translate(camera.x, camera.y);


  rectMode(CORNERS);
  //rect(lx1, ly1, lx2, ly2);


  stroke(0, 180);
  noStroke();

  /*
  fill(250*0.6, 60*0.6, 0);
  beginShape();
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    vertex(c.x+5, c.y+5);
  }
  endShape(CLOSE);
  */

  fill(250, 60, 0);
  beginShape();
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    vertex(c.x, c.y);
  }
  endShape(CLOSE);

  if (cells.size() < 200) {
    for (int i = 0; i < 40; i++) {
      addPoint();
    }
  }
}

void updateRepulsion() {

  Cell ant, act, nex;
  for (int i = 1; i < cells.size()+1; i++) {
    ant = cells.get(i-1);
    act = cells.get(i%cells.size());
    nex = cells.get((i+1)%cells.size());

    if (!act.move) continue;

    float cx = (ant.x+nex.x)*0.5;
    float cy = (ant.y+nex.y)*0.5;

    act.x = lerp(act.x, nex.x, 0.005);
    act.y = lerp(act.y, nex.y, 0.005);

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
    for (int j = 0; j < 3; j++) {
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

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng, time*0.01)*TAU*3;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes, time*0.01)*30; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void generate() {
  camera = new PVector();
  cells = new ArrayList<Cell>();

  det = random(0.01);
  des = random(1000);

  for (int i = 0; i < 2; i++) {
    Cell c = new Cell(width*random(-0.1, 0.1), height*random(-0.1, 0.1));
    //c.move = false;
    cells.add(c);
  }
}
