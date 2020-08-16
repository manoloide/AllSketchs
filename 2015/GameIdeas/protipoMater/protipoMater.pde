ArrayList<Entity> entities;
int killed;
Player player;

void setup() {
  size(600, 600);
  rectMode(CENTER);
  textSize(40);
  textAlign(CENTER, CENTER);
  noStroke();
  reset();
}

void draw() {
  background(#527465);
  fill(255, 22);
  text("killed: "+killed, width/2, 100);
  text("move/arrow key\nattack/space", width/2, height/2);
  if (frameCount%max(20, 100) == 0) {
    float a = PI/2*int(random(4));
    entities.add(new Enemy(width/2+400*cos(a), height/2+400*sin(a), player));
  }
  for (int i = 0; i < entities.size (); i++) {
    Entity e = entities.get(i);
    e.update();
    if (e.remove) {
      if (e == player) player = null;
      entities.remove(i--);
    }
    e.show();
  }
  if (player == null) reset();
}

void reset() {
  killed = 0;
  entities = new ArrayList<Entity>();
  player = new Player(width/2, height/2);
  entities.add(player);
}

void keyPressed() {
  player.pressed();
}

void keyReleased() {
  player.released();
}

class Entity {
  boolean immunity, remove; 
  float x, y, t;
  float live;
  float immunityTime;
  void update() {
  }
  void show() {
  }
  void damage(float amount) {
    if (immunity) return;
    live -= amount;
    if (live <= 0) {
      if (this != player) killed++;
      remove = true;
    }
    immunity = true;
    immunityTime = 2;
  }
}

class Player extends Entity {
  boolean attack;
  boolean up, down, left, right;
  int dir;
  float attackTime;
  Player(float x, float y) {
    this.x = x;
    this.y = y;
    t = 80;
    live = 3;
  }
  void update() {
    float vel = 4;
    if (true || keyPressed) {
      if (up) y -= vel;
      if (down) y += vel;
      if (left) x -= vel;
      if (right) x += vel;
    }
    attackTime -= 60./1000;
    immunityTime -= 60./1000;
    if (immunityTime < 0) immunity = false;
    if (attackTime < 0) attack = false;

    for (int i = 0; i < entities.size (); i++) {
      Entity e = entities.get(i);
      if (e == this) continue;
      if (!immunity && colisionRect(x, y, t, t, e.x, e.y, e.t, e.t)) {
        damage(1);
      }
    }
  }
  void show() {
    fill(#F0F7D2);
    if (!immunity || immunityTime%1 > 0.5) {
      rect(x, y, t, t);
    }
    if (attack) {
      float a = PI/2*dir;
      rect(x+t*cos(a)*0.75, y+t*sin(a)*0.75, t/2, t/2);
    }
    fill(0, 80);
    text(int(live), x, y);
  }
  void pressed() {
    if (keyCode == UP) {
      dir = 3;
      up = true;
    }
    if (keyCode == DOWN) {
      dir = 1;
      down = true;
    }
    if (keyCode == LEFT) {
      dir = 2;
      left = true;
    }
    if (keyCode == RIGHT) {
      dir = 0;
      right = true;
    }
    if (key == ' ' && !attack) {
      attack = true;
      attack();
      attackTime = 1;
    }
  }
  void released() {
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
    if (key == ' ') {
      attack = false;
    }
  }
  void attack() {
    float a = PI/2*dir;
    float xx = x+t*cos(a)*0.75;
    float yy = y+t*sin(a)*0.75;
    float tt = t/2;
    for (int i = 0; i < entities.size (); i++) {
      Entity e = entities.get(i);
      if (e == this) continue;
      if (colisionRect(xx, yy, tt, tt, e.x, e.y, e.t, e.t)) {
        e.damage(1);
      }
    }
  }
}

class Enemy extends Entity {
  Entity target;
  Enemy(float x, float y, Entity target) {
    this.x = x;
    this.y = y;
    this.target = target;
    t = 50;
    live = 1;
  }
  void update() {
    immunityTime -= 60./1000;
    if (immunityTime < 0) immunity = false;
    float vel = 2;
    float a = atan2(target.y-y, target.x-x);
    x += cos(a)*vel;
    y += sin(a)*vel;
  }
  void show() {
    fill(#DB3C3C);
    rect(x, y, t, t);
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}

