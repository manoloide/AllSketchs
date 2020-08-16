ArrayList<Entity> entities;
Player player;
PShader post;

void setup() {
  size(540, 960, P2D);
  smooth(8);
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));

  entities = new ArrayList<Entity>();
  player = new Player();
  entities.add(player);

  for (int i = 0; i < 200; i++) {
    entities.add(new Star());
  }
}

void draw() {
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));
  post.set("time", millis()/1000.);
  background(#101517);

  if (frameCount%60 == 0)
    entities.add(new Enemy(new PVector(random(width), -100)));

  for (int i = 0; i < entities.size(); i++) {
    Entity e = entities.get(i);
    e.update();
    e.show();
    if (e.remove) entities.remove(i--);
  }


  filter(post);
}

void mousePressed() {
  player.shoot = true;
  player.setTarget(new PVector(mouseX, mouseY));

  if (mouseEvent.getClickCount()==2) {
    player.superShoot();
  }
}

void mouseDragged() {
  player.setTarget(new PVector(mouseX, mouseY));
}

void mouseReleased() {
  player.shoot = false;
}


class Entity {
  boolean remove;
  PVector pos;
  void update() {
  }
  void show() {
  }

  boolean outScreen() {
    return pos.x < -100 || pos.x > width+100 || pos.y < -100 || pos.y > height+100;
  }
}


class Bullet extends Entity {
}

class Ship extends Entity {
  float life;
}

class Particle extends Entity {
}

class Enemy extends Ship {
  PVector dir;
  Enemy(PVector np) {
    pos = np;
    dir = new PVector(0, 2);
    life = 2;
  }
  void update() {
    pos.add(dir);


    if (outScreen()) remove = true;
  }

  void show() {
    strokeWeight(2);
    stroke(#FF1F48);
    noFill();
    parall(pos.x, pos.y, 20, 14, 30, 30);
  }
}

class Player extends Ship {
  boolean shoot;
  float timeShoot;
  PVector target;
  Player() {
    pos = new PVector(width/2, height*0.7);
    target = pos.copy();
    life = 10;
  }

  void update() {
    PVector mov = target.copy();
    mov.sub(pos);
    mov.mult(0.16);
    pos.add(mov);

    timeShoot -= 1./60;
    if (shoot) 
      shoot();
  }

  void show() {
    strokeWeight(2);
    stroke(#B0FF1F);
    noFill();
    ellipse(pos.x, pos.y, 100, 100);

    rhombus(pos.x, pos.y, 40, 40);
  }

  void setTarget(PVector nt) {
    target = nt;
  }

  void shoot() {
    if (timeShoot > 0) return;
    SimpleBullet b = new SimpleBullet(this, new PVector(0, -5), color(#B0FF1F));
    entities.add(b);
    timeShoot = 0.5;
  }

  void superShoot() {
    int count = 32;
    float da = TWO_PI/count;
    float angle = PI*1.5;
    float vel = 3;
    for (int i = 0; i < count; i++) {
      angle += da;
      SimpleBullet b = new SimpleBullet(this, new PVector(cos(angle)*vel, sin(angle)*vel), color(#B0FF1F));
      entities.add(b);
    }
  }
}

class SimpleBullet extends Bullet {
  color col;
  Entity parent;
  PVector dir;
  SimpleBullet(Entity p, PVector d, color c) {
    parent = p; 
    dir = d;
    col = c;
    pos = p.pos.copy();
  }
  void update() {
    pos.add(dir);
    if (outScreen()) remove = true;
  }
  void show() {
    strokeWeight(2);
    stroke(col);
    line(pos.x, pos.y, pos.x-dir.x, pos.y-dir.y);
  }
}


void rhombus(float x, float y, float w, float h) {
  w *= 0.5;
  h *= 0.5;
  beginShape();
  vertex(x-w, y);
  vertex(x, y-h);
  vertex(x+w, y);
  vertex(x, y+h);
  endShape(CLOSE);
}

void parall(float x, float y, float w1, float w2, float h1, float h2) {
  w1 *= 0.5; 
  w2 *= 0.5;
  h1 *= 0.5;
  h2 *= 0.5;
  beginShape();
  vertex(x-w1, y-h1);
  vertex(x+w1, y-h1);
  vertex(x+w2, y+h2);
  vertex(x-w2, y+h1);
  endShape(CLOSE);
}

class Star extends Particle {
  PVector pos, vel, ant;
  Star () {
    pos = new PVector(random(width), random(height));
    ant = pos.copy();
    vel = new PVector(0, 0.02+random(1)*random(0.5));
  }

  void update() {
    ant = pos.copy();
    pos.add(vel);
    if (ant.y > height) {
      pos = new PVector(random(width), random(-30)); 
      ant = pos.copy();
    }
  }

  void show() {
    stroke(255, 40+vel.y*100);
    line(pos.x, pos.y, ant.x, ant.y);
  }
}