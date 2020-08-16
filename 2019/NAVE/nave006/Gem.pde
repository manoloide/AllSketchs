// crear gemas hermosas generativas

class Gem {


  float maxDistance = 10000;

  boolean active, remove;
  float distShip;
  int col;
  PVector pos;
  Gem(float x, float y, float z) {
    pos = new PVector(x, y, z); 
    col = rcol();
  }

  void update() {

    active = false;
    if ((abs(pos.x-ship.pos.x) < maxDistance) && 
      (abs(pos.y-ship.pos.y) < maxDistance) &&
      (abs(pos.z-ship.pos.z) < maxDistance)) {
      active = true;

      distShip = dist(ship.pos.x, ship.pos.y, ship.pos.z, pos.x, pos.y, pos.z);
      
      if(distShip < 200) remove = true;
    }
  }

  void show() {
    if (!active) return;

    float tt = globalTime*1.01;
    float rx = tt;
    float ry = tt*0.61;
    float rz = tt*0.73;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    fill(col);
    box(400);
    popMatrix();

    if (distShip < maxDistance) {
      float alp = pow(map(distShip, 0, maxDistance, 1, 0), 1.2);
      stroke(255, 250*alp);
      strokeWeight(1);
      line(ship.pos.x, ship.pos.y, ship.pos.z, pos.x, pos.y, pos.z);
    }
  }
}
