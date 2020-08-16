void setup( ) {
    size(640, 640);
    generate();
}

void draw( ) {

}

void keyPressed( ) {
  generate();
}

void generate( ) {
  background(230);
  PVector[] points = new PVector[4];
  noFill();
  for(int i = 0; i < points.length; i++){
      points[i] = new PVector(width*random(0.1, 0.9), height*random(0.1, 0.9));

      ellipse(points[i].x, points[i].y, 2, 2);
  }

  stroke(0, 160);
  for(int i = 1; i < points.length; i++){
    PVector p1 = points[i-1];
    PVector p2 = points[i];

    line(p1.x, p1.y, p2.x, p2.y);
  }
}
