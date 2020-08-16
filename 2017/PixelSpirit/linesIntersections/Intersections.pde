class Line {
  PVector p1, p2;   
  Line(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  Line(float x1, float y1, float x2, float y2) {
    this(new PVector(x1, y1), new PVector(x2, y2));
  }
}
PVector segmetnsIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float x12 = x1 - x2;
  float x34 = x3 - x4;
  float y12 = y1 - y2;
  float y34 = y3 - y4;

  float c = x12 * y34 - y12 * x34;

  if (abs(c) < 0.1) {
    return null;
  } else {
    float a = x1 * y2 - y1 * x2;
    float b = x3 * y4 - y3 * x4;

    float x = (a * x34 - b * x12) / c;
    float y = (a * y34 - b * y12) / c;

    return new PVector(x, y);
  }
}
/*
PVector segmetnsIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
 float A1 = y2-y1;
 float B1 = x1-x2;
 float C1 = A1*x1+B1*y1;
 
 float A2 = y4-y3;
 float B2 = x3-x4;
 float C2 = A2*x3+B2*y3;
 
 float delta = A1*B2 - A2*B1;
 if (delta == 0)
 return null;
 
 float nx = (B2*C1 - B1*C2)/delta;
 float ny = (A1*C2 - A2*C1)/delta;
 
 //if (abs(dist(nx, ny, x1, y1)+dist(nx, ny, x2, y2)-dist(x1, y1, x2, y2)) < 0.000001 && abs(dist(nx, ny, x3, y3)+dist(nx, ny, x4, y4)-dist(x3, y3, x4, y4)) < 0.000001) {
 if (((abs(x1-nx)+abs(nx-x2))-abs(x1-x2) < 0.001) && ((abs(y1-ny)+abs(ny-y2))-abs(y1-y2) < 0.001)) {
 //if (pointInRect(nx, ny, min(x1, x2), min(y1, y2), abs(x1-x2), abs(y1-y2)) && pointInRect(nx, ny, min(x3, x4), min(y3, y4), abs(x3-x4), abs(y3-y4))) {
 return new PVector(nx, ny);
 }
 return null;
 }
 */

boolean pointInRect(float x, float y, float rx, float ry, float rw, float rh) {
  if (x >= rx && x < rx+rw && y >= ry && y < ry+rh)
    return true;
  else
    return false;
}

PVector segmetnsIntersection(PVector li1, PVector lf1, PVector li2, PVector lf2) {
  return segmetnsIntersection(li1.x, li1.y, lf1.x, lf1.y, li2.x, li2.y, lf2.x, lf2.y);
}



Line lineIntersectionRect(PVector p1, PVector p2, PVector rp, PVector s) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  if (p1.x >= rp.x && p1.x < rp.x+s.x && p1.y >= rp.y && p1.y < rp.y+s.y) {
    points.add(p1);
  }
  if (p2.x >= rp.x && p2.x < rp.x+s.x && p2.y >= rp.y && p2.y < rp.y+s.y) {
    points.add(p2);
  }

  if (points.size() < 2) {
    Line lines[] = new Line[4];
    lines[0] = new Line(rp.x, rp.y, rp.x+s.x, rp.y);
    lines[1] = new Line(rp.x+s.x, rp.y, rp.x+s.x, rp.y+s.y);
    lines[2] = new Line(rp.x+s.x, rp.y+s.y, rp.x, rp.y+s.y);
    lines[3] = new Line(rp.x, rp.y+s.y, rp.x, rp.y);

    for (int i = 0; i < 4; i++) {
      PVector aux = segmetnsIntersection(lines[i].p1, lines[i].p2, p1, p2);
      if (aux != null) {
        points.add(aux);
      }
    }
  }

  if (points.size() >= 2) {
    return new Line(points.get(0), points.get(1));
  }

  return null;
}