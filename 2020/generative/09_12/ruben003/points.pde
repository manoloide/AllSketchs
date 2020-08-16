

void pointsss() {

  noStroke();
  background(0);
  //blendMode(ADD);
  for (int i = 0; i < 30; i++) {
    Point p1 = points.get(int(random(points.size()*random(1))));
    Point p2 = points.get(int(random(points.size()*random(1))));
    while (p1.equals(p2)) {
      p2 = points.get(int(random(points.size()*random(1))));
    }
    Point p3 = points.get(int(random(points.size()*random(1))));
    while (p3.equals(p1) || p3.equals(p2)) {
      p3 = points.get(int(random(points.size()*random(1))));
    }
    float detCol = random(0.01)*random(1)*0.6;
    float detSiz = random(0.1)*random(1);

    ArrayList<PVector> points = new ArrayList<PVector>();
    noStroke();

    float l1 = dist(p1.x, p1.y, p2.x, p2.y);
    float l2 = dist(p2.x, p2.y, p3.x, p3.y);
    float l3 = dist(p3.x, p3.y, p1.x, p1.y);

    float area = sqrt((l1+l2+l3)*(-l1+l2+l3)*(l1-l2+l3)*(l1+l2-l3))/4;


    for (int k = 0; k < area*0.05; k++) {
      PVector p = triangles(p1, p2, p3);  
      p.z = 0.1+pow(noise(p.x*detSiz, p.y*detSiz), 1.2)*4;

      boolean add = true;
      for (int j = 0; j < points.size(); j++) {
        PVector other = points.get(j);
        float dis = dist(p.x, p.y, other.x, other.y);
        if (dis < (p.z+other.z)*2) {
          add = false;
          break;
        }
      }

      if (add) {
        float noi = noise(p.x*detCol, p.y*detCol)*colors.length;
        fill(getColor(noi*2), random(250));
        ellipse(p.x, p.y, p.z*5, p.z*5);
        points.add(p);
      }
    }
  }
}

PVector triangles(Point p1, Point p2, Point p3) {
  float r1 = random(0, 1)*random(1);  
  float r2 = random(0, 1); 
  float x1 = (1 - sqrt(r1)) * p1.x + (sqrt(r1) * (1 - r2)) * p2.x + (sqrt(r1) * r2) * p3.x;
  float y1 = (1 - sqrt(r1)) * p1.y + (sqrt(r1) * (1 - r2)) * p2.y + (sqrt(r1) * r2) * p3.y;
  return new PVector(x1, y1, r1*r2);
}
