

class Scene2 extends Scene {
  ArrayList<LineParticle> lps;
  Scene2() {
    super();
    lps = new ArrayList<LineParticle>();
    generate();
  }

  void update() {
    super.update();
    noLights();
    //background(16);
    if (frame%(20*60) == 0) generate();
    for (int i = 0; i < lps.size (); i++) {
      LineParticle lp = lps.get(i);
      lp.update();
    }
  }

  void show() {
  }

  void generate() {
    lps.clear();
    for (int i = 0; i < 120; i++) {
      lps.add(new LineParticle(0, 0, 0));
    }
  }

  class LineParticle {
    ArrayList<PVector> points;
    float ss, vel;
    PVector ant, pos, npos;
    LineParticle(float x, float y, float z) {
      npos = new PVector(x, y, z);
      pos = new PVector(x, y, z);
      newPos();

      points = new ArrayList<PVector>();
      points.add(new PVector(x, y, z));

      ss = 40;
      vel = random(0.001, 0.5)*random(1);
    }

    void update() {
      ant = new PVector(pos.x, pos.y, pos.z); 
      PVector mov = new PVector(npos.x, npos.y, npos.z);
      mov.sub(pos);
      mov.mult(vel);
      pos.add(mov);

      if (pos.dist(npos) < 0.001) {
        points.add(new PVector(npos.x, npos.y, npos.z));
        ant = new PVector(npos.x, npos.y, npos.z); 
        pos = new PVector(npos.x, npos.y, npos.z);
        newPos();
      }

      show();
    }

    void show() {
      stroke(255, 40);
      PVector p1, p2;
      p2 = new  PVector();
      for (int i = 1; i < points.size (); i++) {
        p1 = points.get(i-1);
        p2 = points.get(i);
        line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      }
      line(p2.x, p2.y, p2.z, pos.x, pos.y, pos.z);

      stroke(255);
      line(ant.x, ant.y, ant.z, pos.x, pos.y, pos.z);
      strokeWeight(1);
    }

    void newPos() {
      float ss = 40;
      if (random(1) < 0.3333333333) {
        npos.x += (random(1) < 0.5)? ss : -ss;
      } else {
        if (random(1) < 0.5) {
          npos.y += (random(1)  < 0.5)? ss : -ss;
        } else {
          npos.z += (random(1) < 0.5)? ss : -ss;
        }
      }
    }
  }
}
