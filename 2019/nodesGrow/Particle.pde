class Particle {
  boolean remove, grow;
  float a1, a2, vel, lar, mv;
  PVector pos;

  ArrayList<PVector> points;

  Particle(float x, float y, float z) {
    pos = new PVector(x, y, z);   
    points = new ArrayList<PVector>();

    points.add(pos.copy());

    if (x == 0 && y == 0 && z == 0) {
      a1 = random(TAU);
      a2 = random(TAU);
    } else {
      a1 = -sqrt(tan(x/y));
      a2 = sqrt(tan((z)/(sqrt(x*x+y*y))));
    }


    a1 = random(TAU);
    a2 = random(PI);

    vel = random(1, 2)*0.5;
    mv = random(0.999, 1.008);
    lar = random(100, 200)*0.6;

    grow = true;
  }

  void update() {
    if (grow) {
      float varAng = 0.06;
      a1 += random(-varAng, varAng);
      a2 += random(-varAng, varAng);

      vel *= mv;

      pos.x += sin(a2)*cos(a1)*vel;
      pos.y += sin(a2)*sin(a1)*vel;
      pos.z += cos(a2)*vel;


      points.add(pos.copy()); 

      if (points.size() > lar) {
        grow = false;

        for (int i = 0; i < 5; i++) {
          particles.add(new Particle(pos.x, pos.y, pos.z));
        }
      }
    }
  }

  void show() {
    stroke(180, 200);
    strokeWeight(1);

    beginShape(LINES);
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);

    stroke(255, 60, 0);
    strokeWeight(4);
    point(pos.x, pos.y, pos.z);

    /*
    pushMatrix();
     fill(140, 100, 255);
     translate(pos.x, pos.y, pos.z);
     textSize(20);
     scale(0.1);
     text(degrees(a1)+" "+degrees(a2), 0, 0);
     popMatrix();
     */
  }
}
