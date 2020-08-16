class Particle {
  boolean remove;
  color col;
  float s; 
  PVector position, des;
  Particle(float x, float y) {
    position = new PVector(x, y);
    des = new PVector();
    s = random(2, random(8, 12));
    col = color(20);
  }
  void movement() {
    des = new PVector();
    ArrayList<Particle> particles = cluster.getCluster(position.x, position.y);
    for (int i = 0; i < particles.size (); i++) {
      Particle p = particles.get(i);
      if (p == this) continue;
      float dis = position.dist(p.position);
      float distance = (s+p.s)*0.6;
      if (dis < distance) {
        float vel = (dis-distance)*0.1;
        PVector vec = new PVector(p.position.x, p.position.y, p.position.z);
        vec.sub(position);
        vec.normalize();
        vec.mult(vel); 
        des.add(vec);
      }
    }
  }
  void update() {
    if (position.x+s < 0 || position.x > width+s || position.y+s < 0 || position.y > height+s) {
      remove = true;
    } 
    if (position.x < 0 || position.x >= width || position.y < 0 || position.y >= height) {
      s *= 0.92;
    } else {
      if (brightness(mask.get(int(position.x), int(position.y))) < 200) {
        s *= 0.92;
      }
    }
    if (s < 1) remove = true;
    position.add(des);
    show();
  }
  void show() {
    noStroke();
    fill(col);
    ellipse(position.x, position.y, s, s);
  }
}

