class Point {
  float x, y;
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

ArrayList<Point> points = new ArrayList<Point>();  
void createPoints() {
  points = new ArrayList<Point>();
  points.add(new Point(0, 0));
  points.add(new Point(width, 0));
  points.add(new Point(width, height));
  points.add(new Point(0, height));

  points.add(new Point(0, height*0.5));
  points.add(new Point(width, height*0.5));
  points.add(new Point(width*0.5, 0));
  points.add(new Point(width*0.5, height));

  points.add(new Point(0, height*0.25));
  points.add(new Point(0, height*0.75));
  points.add(new Point(width, height*0.25));
  points.add(new Point(width, height*0.75));
  points.add(new Point(width*0.25, 0));
  points.add(new Point(width*0.75, 0));
  points.add(new Point(width*0.25, height));
  points.add(new Point(width*0.75, height));


  points.add(new Point(width*0.50, height*0.5));
  points.add(new Point(width*0.25, height*0.5));
  points.add(new Point(width*0.75, height*0.5));

  points.add(new Point(width*0.5, height*0.25));
  points.add(new Point(width*0.5, height*0.75));

  points.add(new Point(width*0.25, height*0.25));
  points.add(new Point(width*0.25, height*0.75));
  points.add(new Point(width*0.75, height*0.25));
  points.add(new Point(width*0.75, height*0.75));

  points.add(new Point(width*0.333, height*0.333));
  points.add(new Point(width*0.333, height*0.666));
  points.add(new Point(width*0.666, height*0.333));
  points.add(new Point(width*0.666, height*0.666));


  points.add(new Point(width*0.5, height*0.375));
  points.add(new Point(width*0.5, height*0.625));

  points.add(new Point(width*0.5, height*0.125));
  points.add(new Point(width*0.5, height*0.875));
}

void grid() {
  noFill();
  stroke(255, 160);
  line(0, 0, width, height);
  line(0, height, width, 0);

  int div = 4;
  stroke(255, 60);
  for (int i = 0; i < div; i++) {
    float val = i*1./div;
    line(width*val, 0, width*val, height);
    line(0, height*val, width, height*val);

    line(width*(val+1./div), 0, width*val, height);
    line(width*(val+1./div), height, width*val, 0);

    line(0, height*(val+1./div), width, height*val);
    line(width, height*(val+1./div), 0, height*val);
  }

  stroke(255, 180);
  line(width*0.0, 0, width*0.50, height);
  line(width*1.0, 0, width*0.50, height);
  line(width*0.0, height, width*0.50, 0);
  line(width*1.0, height, width*0.50, 0);

  noStroke();
  fill(250, 90, 0);
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    ellipse(p.x, p.y, 4, 4);
  }
}
