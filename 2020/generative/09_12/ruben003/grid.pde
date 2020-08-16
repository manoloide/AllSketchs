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
  points.add(new Point(swidth, 0));
  points.add(new Point(swidth, sheight));
  points.add(new Point(0, sheight));

  points.add(new Point(0, sheight*0.5));
  points.add(new Point(swidth, sheight*0.5));
  points.add(new Point(swidth*0.5, 0));
  points.add(new Point(swidth*0.5, sheight));

  points.add(new Point(0, sheight*0.25));
  points.add(new Point(0, sheight*0.75));
  points.add(new Point(swidth, sheight*0.25));
  points.add(new Point(swidth, sheight*0.75));
  points.add(new Point(swidth*0.25, 0));
  points.add(new Point(swidth*0.75, 0));
  points.add(new Point(swidth*0.25, sheight));
  points.add(new Point(swidth*0.75, sheight));


  points.add(new Point(swidth*0.50, sheight*0.5));
  points.add(new Point(swidth*0.25, sheight*0.5));
  points.add(new Point(swidth*0.75, sheight*0.5));

  points.add(new Point(swidth*0.5, sheight*0.25));
  points.add(new Point(swidth*0.5, sheight*0.75));

  points.add(new Point(swidth*0.25, sheight*0.25));
  points.add(new Point(swidth*0.25, sheight*0.75));
  points.add(new Point(swidth*0.75, sheight*0.25));
  points.add(new Point(swidth*0.75, sheight*0.75));

  points.add(new Point(swidth*0.333, sheight*0.333));
  points.add(new Point(swidth*0.333, sheight*0.666));
  points.add(new Point(swidth*0.666, sheight*0.333));
  points.add(new Point(swidth*0.666, sheight*0.666));


  points.add(new Point(swidth*0.5, sheight*0.375));
  points.add(new Point(swidth*0.5, sheight*0.625));

  points.add(new Point(swidth*0.5, sheight*0.125));
  points.add(new Point(swidth*0.5, sheight*0.875));
}

void grid() {
  noFill();
  stroke(255, 160);
  line(0, 0, swidth, sheight);
  line(0, sheight, swidth, 0);

  int div = 4;
  stroke(255, 60);
  for (int i = 0; i < div; i++) {
    float val = i*1./div;
    line(swidth*val, 0, swidth*val, sheight);
    line(0, sheight*val, swidth, sheight*val);

    line(swidth*(val+1./div), 0, swidth*val, sheight);
    line(swidth*(val+1./div), sheight, swidth*val, 0);

    line(0, sheight*(val+1./div), swidth, sheight*val);
    line(swidth, sheight*(val+1./div), 0, sheight*val);
  }

  stroke(255, 180);
  line(swidth*0.0, 0, swidth*0.50, sheight);
  line(swidth*1.0, 0, swidth*0.50, sheight);
  line(swidth*0.0, sheight, swidth*0.50, 0);
  line(swidth*1.0, sheight, swidth*0.50, 0);

  noStroke();
  fill(250, 90, 0);
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    ellipse(p.x, p.y, 4, 4);
  }
}
