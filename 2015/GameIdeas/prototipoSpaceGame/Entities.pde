class Entity {
  float x, y; 
  void update() {
  }
  void show() {
  }
}


class Ship extends Entity {
  float x, y; 
  float vel, velx, vely;
  Ship(float x, float y) {
    this.x = x;
    this.y = y;
    vel = 1;
    velx = vely = 0;
  }
  void update() {
    
    velx = 0; 
    vely = 0;
    if(input.left.press) velx -= vel;
    if(input.right.press) velx += vel;
    if(input.up.press) vely -= vel;
    if(input.down.press) vely += vel;
    x += velx; 
    y += vely;
    
    show();
  }
  void show() {
    noStroke();
    fill(255);
    ellipse(x, y, 30, 30);
  }
}

