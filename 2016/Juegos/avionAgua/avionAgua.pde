int world_width = 2048;
int world_height = 1024;

ArrayList<Entity> entities;
Plane plane;
Water water;

void setup() {
  size(720, 480);
  smooth(8);
  entities = new ArrayList<Entity>();
  plane = new Plane();
  entities.add(plane);
  water = new Water();
  entities.add(water);
  entities.add(new Enemy());
  entities.add(new Enemy());
}

void draw() {
  background(250, 210, 180);

  for (int i = 0; i < entities.size(); i++) {
    Entity e = entities.get(i);
    e.update();
    if (e.remove) entities.remove(i--);
  }
}

void keyPressed() {
  if (keyCode == UP) plane.Run = true;
  if (keyCode == RIGHT) plane.Right = true;
  if (keyCode == LEFT) plane.Left = true;
  if (key == 'x') plane.Attack = true;
  if (key == 'r') plane.pos = new PVector(width/2, height/2);
}

void keyReleased() {
  if (keyCode == UP) plane.Run = false;
  if (keyCode == RIGHT) plane.Right = false;
  if (keyCode == LEFT) plane.Left = false;
  if (key == 'x') plane.Attack = false;
}

class Entity {
  boolean remove;
  PVector pos;
  void update() {
  }
  void show() {
  }
}

class Bullet extends Entity {
  Entity parent;
  float dir, vx, vy;
  float vel = 8;
  float lifeTime;
  Bullet(Entity parent, PVector pos, float dir) {
    this.parent = parent;
    this.pos = pos.copy();
    this.dir = dir;
    vx = cos(dir)*vel;
    vy = sin(dir)*vel;
    lifeTime = 10;
  }
  void update() {
    pos.x += vx;
    pos.y += vy;
    lifeTime -= 1./60;
    if (lifeTime < 0) remove = true;

    show();
  }
  void show() {
    stroke(255, 240, 230);
    fill(255);
    ellipse(pos.x, pos.y, 6, 6);
  }
}

class Enemy extends Entity {
  float angle, vel;
  Enemy() {
    vel = 2;
    float ang = random(PI, TWO_PI);
    pos = new PVector(plane.pos.x + cos(ang)*width, plane.pos.y + sin(ang)*width);
  }

  void update() {
    float newAngle = atan2(plane.pos.y-pos.y, plane.pos.x-pos.x);
    angle = newAngle;
    pos.x += cos(angle)*vel;
    pos.y += sin(angle)*vel;

    show();
  }

  void show() {
    noStroke();
    fill(255, 120, 120);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rect(-8, -3, 16, 6);
    popMatrix();
  }
}


class Plane extends Entity {
  boolean Attack, Run, Right, Left;
  float angle, vel, grav;
  float timeAttack;
  PVector dir, ace;
  Plane() {
    pos = new PVector(width/2, height/2);
    angle = PI*1.5;
    ace = new PVector();
    dir = new PVector(cos(angle), sin(angle));
    vel = 0;
    grav = 0;
  }
  void update() {
    float velRot = 0.12;
    timeAttack -= 1./60;
    if (Attack && timeAttack < 0) {
      attack();
    }
    if (Run) {
      velRot = 0.05;
      vel += 0.02;
      if (vel > 2) vel = 2;

      dir = new PVector(cos(angle), sin(angle));
      dir.mult(vel);
      ace.x *= 0.9;
      ace.y *= 0.9;

      ace.x += dir.x;
      ace.y += dir.y;
    } else {
      vel *= 0.8;
      if (pos.y < height-100) {
        ace.y += 0.08;
      } else {
        ace.x *= 0.99;
        if (ace.y > 0) ace.y *= 0.8;
        ace.y -= 0.12;
      }
    }
    if (Right) plane.rotated(velRot);
    if (Left) plane.rotated(-velRot);

    ace.limit(5);
    pos.add(ace);
    if (pos.y > height) pos.y = height;
    show();
  }
  void show() {
    noStroke();
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rect(-8, -3, 16, 6);
    popMatrix();
  }

  void attack() {
    timeAttack = 0.2;
    Bullet b = new Bullet(this, pos, angle);
    entities.add(b);
  }

  void rotated(float aux) {
    angle += aux;
    angle = angle%TWO_PI;
    angle += TWO_PI;
    angle = angle%TWO_PI;
  }
}

class Water extends Entity {
  ArrayList<PVector> initPoints, points;
  int sep = 10;
  Water() {
    initPoints = new ArrayList<PVector>();
    points = new ArrayList<PVector>();
    int bb = 6;
    int cc = width/sep + 1 + bb*2;
    for (int i = -bb; i < cc-bb; i++) {
      initPoints.add(new PVector(0+i*sep, height-120));
      points.add(new PVector(0+i*sep, height-120));
    }
  }
  void update() {
    PVector pos = plane.pos.copy().sub((new PVector(cos(plane.angle), sin(plane.angle))).mult(14));
    pos.y = min(pos.y, height-130);
    float size = 40;
    if (plane.Run) size = 45;
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      PVector aux = p.copy();
      float dis = aux.dist(pos);
      if (dis < size) {
        dis = size-dis;
        float aa = atan2(aux.y-pos.y, aux.x-pos.x);
        aux.x += cos(aa)*dis;
        aux.y += sin(aa)*dis;
      } else {
        PVector dif = initPoints.get(i).copy().sub(aux);
        dif.mult(0.1);
        aux.add(dif);
      }
      p.x = aux.x;
      p.y = aux.y;
    }


    show();
  }
  void show() {
    /*
    fill(255, 0, 200);
     for (int i = 0; i < points.size(); i++) {
     PVector p = points.get(i);
     ellipse( p.x, p.y+cos(-frameCount*0.2+i)*2, 3, 3);
     }
     */


    noStroke();
    fill(160, 180, 240);
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      curveVertex( p.x, p.y+cos(-frameCount*0.1+i)*2);
    }
    vertex(width+20, height+20);
    vertex(-20, height+20);
    endShape(CLOSE);
  }
}

class Camera {
  PVector pos, tar;

  Camera() {
    pos = new PVector();
    tar = new PVector();
  }
}  