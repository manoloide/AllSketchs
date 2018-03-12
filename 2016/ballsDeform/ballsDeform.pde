void setup() {
  size(960, 960);
}

void draw() {



  float sizeBall = 260;

  background(255);
  textSize(60);
  textAlign(LEFT, TOP);
  fill(0, 20);
  text("BallsDeform", 50, 50);

  noStroke();
  fill(#ffda4c, 40);
  ellipse(mouseX, mouseY, sizeBall, sizeBall);
  fill(#ffda4c);
  ellipse(mouseX, mouseY, 150, 150);


  ArrayList<PVector> points = new ArrayList<PVector>();
  float radius = 120;
  float resolution = 16;
  float da = TWO_PI/resolution;
  for (int i = 0; i < resolution; i++) {
    float angle = da*i;
    float x = width/2 + cos(angle)*radius;
    float y = height/2 + sin(angle)*radius;

    float dist = dist(mouseX, mouseY, x, y);
    if (dist < sizeBall*0.5) {
      dist = sizeBall*0.5-dist;
      dist *= 0.8;
      float ang = atan2(mouseY-y, mouseX-x);
      x -= cos(ang)*dist;
      y -= sin(ang)*dist;
    }
    points.add(new PVector(x, y));
  }


  PVector point = points.get(0);
  beginShape();
  curveVertex(point.x, point.y);
  for (int i = 0; i <= points.size(); i++) {
    PVector p = points.get(i%points.size());
    curveVertex(p.x, p.y);
  }
  endShape(CLOSE);


  noStroke();
  fill(0);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 5, 5);
  }
}