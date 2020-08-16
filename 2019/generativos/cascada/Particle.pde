class Particle {
  ArrayList<PVector> points;
  boolean remove;
  float x, y;
  float lar, str;
  Particle() {
    points = new ArrayList<PVector>(); 
    x = width*random(-0.55, 0.55);
    y = height*random(-0.55, 0.55);
    lar = random(20, random(100, 400))*random(1);
    str = random(0.8, 2);

    for (int i = 0; i < lar; i++) {
      float ang = noise(des+x*det, des+y*det)*TAU*2;
      x += cos(ang);
      y += sin(ang);
      points.add(new PVector(x, y));
    }
  }

  void update() {
  }

  void show() {

    noFill();
    stroke(getColor(noise(desCol+x*detCol, desCol+y*detCol)*8+random(1)));
    strokeWeight(str);
    beginShape();
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      vertex(p.x, p.y);
    }
    endShape();
  }
}
