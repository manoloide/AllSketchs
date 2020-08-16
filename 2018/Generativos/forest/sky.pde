void sky() {
  background(#DEE1DA);

  noStroke();
  beginShape();
  fill(rcol());
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape();
  
  float det = random(0.01);
  float des = random(1000);
  float lim = random(1);

  ArrayList<PVector> points = new ArrayList<PVector>();
  points = new ArrayList<PVector>();
  float maxDist = width*random(0.04);
  for (int i = 0; i < 1000; i++) {
    float xx = width*random(-0.1, 1.1);
    float yy = height*random(-0.1, 0.5);
    if(noise(des+det*xx, des+det*yy) < lim)
      points.add(new PVector(xx, yy));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);
    fill(255, random(20, 255));
    float ss = random(2);
    ellipse(p1.x, p1.y, ss, ss);
    for (int j = 0; j < points.size(); j++) {
      PVector p2 = points.get(j);
      float dis = p1.dist(p2);
      if (dis < maxDist) {
        stroke(255, 16*(1-(dis/maxDist)));
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }

  noStroke();
  beginShape();
  fill(0, 30);
  vertex(0, 0);
  vertex(width, 0);
  fill(0, 0);
  vertex(width, height*0.4);
  vertex(0, height*0.4);
  endShape();
  
  
}