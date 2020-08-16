class Particles {
  ArrayList<PVector> particles, pparticles;
  float detAng1, detAng2, desAng1, desAng2;
  float vel;

  float maxDis = 2000;
  Particles() {
    particles = new ArrayList<PVector>();  
    pparticles = new ArrayList<PVector>();
    float ms = maxDis*0.05;
    for (int i = 0; i < 100; i++) {
      float x = random(-maxDis, maxDis);
      float y = random(-maxDis, maxDis);
      float z = random(-maxDis, maxDis);
      vel = random(6);
      particles.add(new PVector(x, y, z));
      pparticles.add(new PVector(x, y, z));

      detAng1 = random(0.001);
      detAng2 = random(0.001);
      desAng1 = random(1000);
      desAng2 = random(1000);
    }
  }

  void update() {

    for (int i = 0; i < particles.size(); i++) {
      PVector p = particles.get(i);

      float ang1 = (float) SimplexNoise.noise(desAng1+p.x*detAng1, desAng1+p.y*detAng1, desAng1+p.z*detAng1)*TAU*2;
      float ang2 = (float) SimplexNoise.noise(desAng1+p.x*detAng1, desAng1+p.y*detAng1, desAng1+p.z*detAng1)*TAU*2;
      PVector des = new PVector(cos(ang1)*cos(ang2), cos(ang1)*sin(ang2), sin(ang1));
      des.mult(vel+bd.kickSize*12);
      (particles.get(i)).add(des);
      (pparticles.get(i)).lerp(particles.get(i), 0.1);


      float dx = (ship.pos.x-p.x);
      float dy = (ship.pos.y-p.y);
      float dz = (ship.pos.z-p.z);

      if (dx+maxDis*0.5 > maxDis) p.x += maxDis;
      if (dx-maxDis*0.5 < -maxDis) p.x -= maxDis;
      if (dy+maxDis*0.5 > maxDis) p.y += maxDis;
      if (dy-maxDis*0.5 < -maxDis) p.y -= maxDis;
      if (dz+maxDis*0.5 > maxDis) p.z += maxDis;
      if (dz-maxDis*0.5 < -maxDis) p.z -= maxDis;
    }
  }

  void show() {

    PVector p1, p2;
    hint(DISABLE_STROKE_PERSPECTIVE);

    stroke(255, 220);
    beginShape(POINTS);
    for (int i = 0; i < particles.size(); i++) {
      p1 = particles.get(i);
      strokeWeight(4+cos(time+i*21231.1)*2+bd.snareSize*2);
      stroke(getColor(world.getZone(p1.x, p1.y, p1.z)+3));
      vertex(p1.x, p1.y, p1.z);
    }
    endShape();


    hint(ENABLE_STROKE_PERSPECTIVE);
    strokeWeight(1.6);
    beginShape(LINES);
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
  }
}
