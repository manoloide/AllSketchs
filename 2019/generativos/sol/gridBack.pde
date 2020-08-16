void gridBack(ArrayList<PVector> rects) {

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float ms = r.z*0.5;
    points.add(new PVector(r.x+ms, r.y+ms));
  }
  ArrayList<Triangle> tris = Triangulate.triangulate(points);

  noStroke();
  noFill();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    fill(255, random(30));
    rect(1+r.x, 1+r.y, r.z-2, r.z-2);
    ellipse(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.2, r.z*0.2);
    fill(255, 110);
    ellipse(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.05, r.z*0.05);
  }

  noStroke();
  beginShape(TRIANGLES);
  for (int i = 0; i < tris.size (); i++) {
    Triangle t = tris.get(i);
    stroke(255, random(40));
    if (random(1) < 0.1) line(t.p1.x, t.p1.y, t.p2.x, t.p2.y);
    if (random(1) < 0.1) line(t.p2.x, t.p2.y, t.p3.x, t.p3.y);
    if (random(1) < 0.1) line(t.p3.x, t.p3.y, t.p1.x, t.p1.y);
  }
  endShape();

  noStroke();
  beginShape(TRIANGLES);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    fill(255, random(40));
    vertex(t.p1.x, t.p1.y);
    fill(255, random(40));
    vertex(t.p2.x, t.p2.y);
    fill(255, random(40));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}
