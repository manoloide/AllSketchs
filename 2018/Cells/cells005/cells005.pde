import toxi.math.noise.SimplexNoise;

int seed = 40;

ArrayList<Cell> cells;
ArrayList<Globulito> globulis;
FloatList angles;

float time = 0;
float scale = 1;
float maxDis = 120;
float lx1, ly1, lx2, ly2;

PVector center, camera;

float det, des;

PImage mask;

boolean exportVideo = false;
float totalTime = 60;

void setup() {

  size(540, 960, P3D);//size(1920, 1080, P3D);//
  smooth(4);
  //pixelDensity(2);

  generate();
}

void draw() {

  if (exportVideo) {
    time = frameCount*1./60;
  }
  else {
    time = millis()*0.001;
  }

  background(80); 
  noiseDetail(2);

  if (keyPressed) {
    for (int j = 0; j < 3; j++) {
      addPoint();
    }
  }


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
      angles.remove(i);
      cells.remove(i--);
    }
  }

  center.div(cells.size());
  camera.lerp(center.copy().add(-(lx1+lx2), -(ly1+ly2)), 0.02);


  float ww = lx2-lx1;
  float hh = ly2-ly1;

  scale = lerp(scale, max(width*1.2/ww, height*1.2/hh), 0.5);

  translate(width*0.5, height*0.5);
  scale(min(3, scale));
  translate(camera.x, camera.y);
  rectMode(CORNERS);
  //rect(lx1, ly1, lx2, ly2);


  stroke(0, 180);
  noStroke();

  fill(250*0.6, 50*0.6, 0);
  beginShape();
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    vertex(c.x+5, c.y+5);
  }
  endShape(CLOSE);

  fill(250, 50, 0);
  beginShape();
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    vertex(c.x, c.y);
  }
  endShape(CLOSE);

  noFill();
  strokeWeight(0.6);
  stroke(#FDCCC7);
  beginShape();
  PVector v;
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i); 
    v = desform(c.x, c.y);
    vertex(v.x, v.y);
  }
  endShape(CLOSE);


  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    float amp = map(cos(time*0.02+i+0.2), -1, 1, 2, 3)*constrain(c.tt*2.2, 0, 1)*0.9;
    float ang = angles.get(i);
    line(c.x+cos(ang+PI)*amp, c.y+sin(ang+PI)*amp, c.x+cos(ang)*amp, c.y+sin(ang)*amp);
  }


  if (cells.size() < 200) { 
    for (int i = 0; i < 80; i++) {
      addPoint();
    }
  }

  if (globulis.size() < 5000) {
    for (int j = 0; j < 10; j++) {
      globulis.add(new Globulito(random(-0.5, 0.5)*width*0.5, random(-0.5, 0.5)*height*0.5));
    }
  }

  mask = get();

  for (int i = 0; i < globulis.size(); i++) {  
    Globulito g = globulis.get(i);
    g.update();
    g.show();
  }

  if (exportVideo) {
    int frame = int(frameCount/2);
    String fileName = "f"+nf(frame, 4)+".png";
    if (frameCount%2 == 1) {
      saveFrame(fileName);
    }

    float second = frame*(1./30);
    if (second > totalTime) {
      exit();
    }
  }
}

void updateRepulsion() {

  angles.clear();
  Cell ant, act, nex;
  for (int i = 0; i < cells.size(); i++) {
    ant = cells.get((i-1+cells.size())%cells.size());
    act = cells.get((i+0+cells.size())%cells.size());
    nex = cells.get((i+1+cells.size())%cells.size());

    float ang = (atan2(nex.y-ant.y, nex.x-ant.x)+atan2(act.y-ant.y, act.x-ant.x))*0.5-HALF_PI;
    angles.push(ang+map(cos(time*0.02+i), -1, 1, 0, 0.1));

    if (!act.move) continue;

    float cx = (ant.x+nex.x)*0.5;
    float cy = (ant.y+nex.y)*0.5;

    act.x = lerp(act.x, nex.x, 0.005);
    act.y = lerp(act.y, nex.y, 0.005);

    act.x += constrain((cx-act.x)*0.4, -5, 5);
    act.y += constrain((cy-act.y)*0.4, -5, 5);
  }


  for (int k = 0; k < cells.size(); k++) {
    Cell c = cells.get(k);
    for (int j = k+1; j < cells.size(); j++) {
      Cell o = cells.get(j);
      c.repulsion(o);
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
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng, time*0.01)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes, time*0.01)*2; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void generate() {
  camera = new PVector();

  det = random(0.01);
  des = random(1000);

  desAng = random(1000);
  detAng = random(0.01);
  desDes = random(1000);
  detDes = random(0.01);


  cells = new ArrayList<Cell>();
  angles = new FloatList();
  for (int i = 0; i < 2; i++) {
    Cell c = new Cell(width*random(-0.1, 0.1), height*random(-0.1, 0.1));
    //c.move = false;
    cells.add(c);
  }

  updateRepulsion();


  globulis = new ArrayList<Globulito>();
}
