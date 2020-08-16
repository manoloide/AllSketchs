

class Point {
  PVector ini, acr, pos, tgt;
  PVector vel, acc;
  float decay;

  Point(PVector ori) {
    ini = ori.copy();
    acr = ori.copy();
    tgt = ori.copy();
    pos = ori;

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    decay = random(0.8, 0.9)*0.8;
  }

  void update() {

    tgt.lerp(ini, 0.04);
    PVector m = new PVector(mouseX, mouseY);
    float dist = dist(mouseX, mouseY, pos.x, pos.y);

    if (dist < 360) {
      float d = pow(map(dist, 0, 360, 0.4, 0), 1.6);
      tgt.lerp(m, d);
    }


    acc = PVector.sub(tgt, pos);
    acc.mult(.025);
    vel.add(acc);
    pos.add(vel);
    vel.mult(decay);
    acc.set(0, 0, 0);
  }
}