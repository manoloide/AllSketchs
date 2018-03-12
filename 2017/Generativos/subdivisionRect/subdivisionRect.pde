void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);
  ArrayList<Quad> quads = new ArrayList<Quad>();

  ArrayList<PVector> points = new ArrayList<PVector>();
  float bb = 4;
  points.add(new PVector(bb, bb));
  points.add(new PVector(width-bb, bb));
  points.add(new PVector(width-bb, height-bb));
  points.add(new PVector(bb, height-bb));
  quads.add(new Quad(new ArrayList<PVector>(points)));

  float des = random(0.4)*random(0.5, 1);
  int cc = int(random(100, 5000));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(quads.size()*random(1)));
    Quad q = quads.get(ind);

    float x = (q.points.get(0).x+q.points.get(1).x+q.points.get(2).x+q.points.get(3).x)/4;
    float y = (q.points.get(0).y+q.points.get(1).y+q.points.get(2).y+q.points.get(3).y)/4;

    PVector rnd = randQuad(q.points, des);
    x = rnd.x;
    y = rnd.y;

    ArrayList<PVector> aux = new ArrayList<PVector>(q.points);
    ArrayList<PVector> aux2 = new ArrayList<PVector>();
    for (int j = 0; j < 4; j++) {
      PVector np = aux.get(j).copy().add(aux.get((j+1)%4)).mult(0.5);
      aux2.add(np);
    }
    for (int j = 0; j < 4; j++) {
      aux.add(j*2+1, aux2.get(j));
    }


    for (int j = 0; j < 4; j++) {
      points.clear();
      points.add(new PVector(x, y)); 
      for (int k = 1; k < 4; k++) {
        points.add(aux.get((k+j*2)%8).copy());
      }
      quads.add(new Quad(new ArrayList<PVector>(points)));
    }
    quads.remove(ind);
  }
  blendMode(ADD);
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    color col = getColor(random(colors.length));
    fill(col, random(100, 200));
    //stroke(col);
    stroke(0);
    q.show();
    q.show();
  }
}

PVector randQuad(ArrayList<PVector> points, float des) {
  PVector a = points.get(0);
  PVector b = points.get(1);
  PVector c = points.get(2);
  PVector d = points.get(3);
  float s = random(des, 1-des);
  PVector e = a.copy().mult(s).add(b.copy().mult(1-s));
  PVector f = c.copy().mult(s).add(d.copy().mult(1-s));
  float t = random(des, 1-des);
  return e.copy().mult(t).add(f.copy().mult(1-t));
}

class Quad {
  ArrayList<PVector> points;
  Quad(ArrayList<PVector> points) {
    this.points = points;
  }

  void show() {
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
}


int colors[] = {#1e3888, #47a8bd, #f5e663, #ffad69, #9c3848};
//{#240603, #4ABABB, #EA8559, #0B62A6, #F5F7DC, #0E1928, #355566, #82B0AD};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}