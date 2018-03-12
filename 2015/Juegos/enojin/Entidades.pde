class Entity implements Comparable {
  boolean remove;
  float life;
  PVector position;
  Entity(float x, float y) {
    position = new PVector(x, y); 
    life = 100;
  }

  void update() {
  }

  void show() {
  }

  int compareTo(Object o) { 
    int res = 0; 
    Entity e =  (Entity) o;
    if (position.y < e.position.y) { 
      res = -1;
    } else if (position.y > e.position.y) { 
      res = 1;
    } else {
      if (position.x < e.position.x) {
        res = -1;
      } else if (position.x > e.position.x) {
        res = 1;
      }
    }

    return res;
  }
}


class Bobo extends Entity {
  boolean angry;
  Bobo victim;
  float life;
  float velocity, angle;
  int dir;
  PVector target;
  Bobo(float x, float y) {
    super(x, y);
    target = new PVector(width/2, height/2);
    life = 100;
    velocity = 1;
  }

  void update() {
    if (angry ) {
      if (victim.angry || victim.remove) victim = null;
      if (victim == null) {
        searchVictim();
      } else {
        float dis = position.dist(victim.position);
        if (dis < 25) {
          victim.life -= 4;
        }
        angle = atan2(victim.position.y-position.y, victim.position.x-position.x);
        position.x += cos(angle)*velocity*2;
        position.y += sin(angle)*velocity*2;
        if (cos(angle) > 0) dir = 1; 
        else dir = 0;
      }
    } else {
      angle = atan2(target.y-position.y, target.x-position.x);
      position.x += cos(angle)*velocity;
      position.y += sin(angle)*velocity;
      if (cos(angle) > 0) dir = 1; 
      else dir = 0;
    }
    if (position.dist(target) < 1 || life <= 0) remove = true;

    if (click && dist(mouseX, mouseY, position.x, position.y) < 25) {
      angry = true;
      searchVictim();
    }
  }

  void show() {
    noStroke();
    fill(245);
    if (angry) fill(245, 160, 160);
    imageMode(CENTER);
    pushMatrix();
    translate(0, cos(frameCount*0.2)*10);
    image(bicho, position.x, position.y);
    //ellipse(position.x, position.y, 50, 50);

    int w = 40;
    float lp = map(life, 0, 100, 0, 1);
    fill(0, 255, 0);
    rect(position.x-w/2, position.y-32, w*lp, 3);
    fill(255, 0, 0);
    rect(position.x-w/2+w*lp, position.y-32, w*(1-lp), 3);
    popMatrix();
  }

  void searchVictim() {
    float minDist = 0;
    victim = null;
    for (int i = 0; i < entities.size (); i++) {
      Entity e = entities.get(i);
      if (!(e instanceof Bobo)) continue;
      Bobo b = (Bobo) e;
      if (b == this || b.angry) continue;
      float dist = position.dist(b.position);
      if (victim == null || dist < minDist) {
        victim = b; 
        minDist = dist;
      }
    }
  }
}

