void olas() {

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 120; i++) {
    points.add(new PVector(random(width), random(height), width*random(0.4)*random(1)));
  }

  PGraphics gra = createGraphics(width, height);
  gra.beginDraw();
  gra.background(0);
  gra.noStroke();
  gra.fill(255);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    gra.ellipse(p.x*0.5, p.y*0.5, p.z*0.5, p.z*0.5);
  }
  gra.endDraw();

  noFill();

  float det = random(0.02)*random(0.2, 1);
  float des = random(1000);
  float det2 = random(0.03)*random(0.2, 1);
  float des2 = random(1000);
  float  res = 8;

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(#F0EEEB);
    ellipse(p.x, p.y, p.z+4, p.z+4);
  }

  float xx, yy, ang;
  for (int i = 0; i < 40000; i++) {
    xx = random(width);
    yy = random(height);
    stroke(0, 60);
    fill(rcol(), 120);
    beginShape();
    vertex(xx, yy);
    for (int j = 0; j < 20; j++) {
      res = pow(noise(des2+xx*det2, des2+yy*det2), 4)*PI*8; 
      ang = noise(des+xx*det, des+yy*det)*TAU*res;
      xx += cos(ang);
      yy += sin(ang);
      if (brightness(gra.get(int(xx), int(yy))) < 20) break;
      vertex(xx, yy);
    }
    endShape();
  }

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    arc2(p.x, p.y, p.z+4, p.z*0.4, 0, TAU, color(255), 20, 0);
  }
}