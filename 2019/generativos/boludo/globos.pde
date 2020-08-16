void globos() {
  
  float det = random(0.002, 0.004)*random(0.08, 0.1)*5;
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1500; i++) {
    PVector p = new PVector(random(width), random(height));

    float noise = (float) SimplexNoise.noise(p.x*det, p.y*det, seed);
    noise = constrain(noise*3.5-1.9, 0, 1);

    p.z = pow(noise, 1.2)*40;

    boolean add = true;
    for (int k = 0; k < points.size(); k++) {
      PVector o = points.get(k);
      if (dist(p.x, p.y, o.x, o.y) < (p.z+o.z)*1.1) {
        add = false;
        break;
      }
    }

    if (add) points.add(p);

    fill(rcol());
    ellipse(p.x, p.y, p.z, p.z*1.1);
    fill(255, 40);
    ellipse(p.x+p.z*0.2, p.y-p.z*0.2, p.z*0.2, p.z*0.2);

    float lx = p.x-p.z*0.3;
    float ly = p.y+p.z*0.4;
    
    noiseDetail(2);

    float ang = PI*random(0.6, 0.75);
    ang += random(-0.1, 0.1)*random(0.1)*random(1);
    stroke(rcol());
    noFill();
    beginShape();
    float lar = p.z;
    float desA = random(10);
    float detA = lar*random(0.006, 0.01)*0.08;
    for (int k = 0; k < lar; k++) {
      float noi = (float) SimplexNoise.noise(desA+lx*detA, desA+ly*detA)-0.5;
      //ang += (noi)*0.001;
      float a = ang+noi*PI*0.2;
      lx += cos(a);
      ly += sin(a);
      vertex(lx, ly);
    }
    endShape();
    noStroke();
  }
}
