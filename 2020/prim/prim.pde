ArrayList<PVector> points;

void setup() {
  size(960, 540);
  pixelDensity(2);
  smooth(4);
  points = new ArrayList<PVector>();
}

void draw() {

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < points.size(); i++) {
    unreached.add(points.get(i));
  }

  if (unreached.size() > 0) {
    int ind = int(random(unreached.size()));
    reached.add(unreached.get(ind));
    unreached.remove(ind);
  }

  background(0); 

  while (unreached.size() > 0) {
    float record = 10000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      PVector v1 = reached.get(i);
      for (int j = 0; j < unreached.size(); j++) {
        PVector v2 = unreached.get(j);
        float d = v1.dist(v2);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }

    stroke(230, 240, 250);
    line(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);

    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    noStroke();
    fill(240, 230, 255);
    ellipse(p.x, p.y, 5, 5);
  }
}

void mousePressed() {
  points.add(new PVector(mouseX, mouseY));
}
