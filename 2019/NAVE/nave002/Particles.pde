class Particles {
  ArrayList<PVector> particles, pparticles;
  float detAng1, detAng2, desAng1, desAng2;
  Particles() {
    particles = new ArrayList<PVector>();  
    pparticles = new ArrayList<PVector>();
    float ms = size*0.05;
    for (int i = 0; i < 100; i++) {
      float x = random(-ms, ms);
      float y = random(-ms, ms);
      float z = random(-ms, ms);
      particles.add(new PVector(x, y, z));
      pparticles.add(new PVector(x, y, z));

      detAng1 = random(0.001);
      detAng2 = random(0.001);
      desAng1 = random(1000);
      desAng2 = random(1000);
    }
  }

  void update() {

    float maxDis = 2000;
    for (int i = 0; i < particles.size(); i++) {
      PVector p = particles.get(i);

      if (abs(p.x-camera.pos.x) < maxDis && abs(p.y-camera.pos.y) < maxDis && abs(p.z-camera.pos.z) < maxDis) {
        float ang1 = (float) SimplexNoise.noise(desAng1+p.x*detAng1, desAng1+p.y*detAng1, desAng1+p.z*detAng1)*TAU*2;
        float ang2 = (float) SimplexNoise.noise(desAng1+p.x*detAng1, desAng1+p.y*detAng1, desAng1+p.z*detAng1)*TAU*2;
        PVector des = new PVector(cos(ang1)*cos(ang2), cos(ang1)*sin(ang2), sin(ang1));
        des.mult(0.6);
        (particles.get(i)).add(des);
        (pparticles.get(i)).lerp(particles.get(i), 0.2);
      }
    }
  }

  void show() {

    PVector p1, p2;

    stroke(255);
    strokeWeight(6);
    beginShape(POINTS);
    for (int i = 0; i < particles.size(); i++) {
      p1 = particles.get(i);
      vertex(p1.x, p1.y, p1.z);
    }
    endShape();
    /*
    strokeWeight(2);
     beginShape(LINE);
     for (int i = 0; i < particles.size(); i++) {
     p1 = particles.get(i);
     p2 = pparticles.get(i);
     
     //float maxDis = 1200;
     //if (abs(p1.x-camera.pos.x) < maxDis && abs(p1.y-camera.pos.y) < maxDis && abs(p1.z-camera.pos.z) < maxDis) {
     vertex(p1.x, p1.y, p1.z);
     vertex(p2.x, p2.y, p2.z);
     //}
     }
     endShape();
     */
  }
}
