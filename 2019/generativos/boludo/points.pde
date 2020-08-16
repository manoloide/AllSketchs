void points(float grid) {

  ArrayList<PVector> points = new ArrayList<PVector>();

  int cc = 10;
  float amp = random(1);
  for (int i = 0; i < cc; i++) {
    float x1 = random(width+grid);
    float y1 = random(height+grid);

    x1 -= x1%grid;
    y1 -= y1%grid;

    if (random(1) < 0.5) {
      x1 -= x1%(grid*2);
      y1 -= y1%(grid*2);
    }
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x1, y1, other.x, other.y) < 3) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x1, y1));
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  beginShape(TRIANGLE);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = triangles.get(i);
    if(random(1) < 0.8) continue;
    int col = rcol();
    fill(col, random(190));
    vertex(t.p1.x, t.p1.y);
    fill(col, random(190));
    vertex(t.p2.x, t.p2.y);
    fill(col, random(190));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();



  float ss = grid*1.5;

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    stroke(0, 10);
    noFill();
    ellipse(p.x, p.y, ss*2, ss*2);
    noStroke();
    fill(255, 30);
    ellipse(p.x, p.y, ss*1.8, ss*1.8);
    fill(rcol());
    ellipse(p.x, p.y, ss*0.4, ss*0.4);
    fill(255, 30);
    ellipse(p.x, p.y, ss*0.18, ss*0.18);
  }
}
