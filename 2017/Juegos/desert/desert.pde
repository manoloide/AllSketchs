// añadir menu de stats
// añadir font
// añadir cofres
// añadir rocas

// añadir objecto con mejoras
// añadir bombas
// añadir cuevas y escaleras
// añadir mapa
// salir del desierto

// pasar el mapa a chunks


import java.util.Collections;

final int WIDTH = 160;
final int HEIGHT = 120;
final int scale = 4;

ArrayList<Entity> entities;

Camera camera;
Player player;
Piece piece;
Terrain terrain;

PImage sprites;
PImage tiles[][];
PGraphics render;

int enemyCount;

void settings() {
  size(WIDTH*scale, HEIGHT*scale);
  noSmooth();
}

void setup() {
  noCursor();

  sprites = loadImage("sprites.png");
  tiles = cutSprites(16, 16, sprites);
  render = createGraphics(WIDTH, HEIGHT);
  render.imageMode(CENTER);
  render.beginDraw();
  render.background(#f9efd3);
  render.endDraw();

  generate();
}


void draw() {

  if (enemyCount < 100) {
    spawnEnemy();
  }

  render.beginDraw();
  for (int i = 0; i < entities.size(); i++) {
    Entity e = entities.get(i);
    e.update();
    if (e.remove) entities.remove(i--);
    for (int j = 0; j < entities.size(); j++) {
      if (!(e instanceof Mob)) continue;
      Mob m = (Mob) e;
      Entity o = entities.get(j);
      if (o instanceof Bullet) {
        Bullet b = (Bullet) o;
        if (dist(m.x, m.y, b.x, b.y) < m.s+b.s) {
          if (b.parent != m) { 
            b.remove = true;
            m.hurt(1);
            m.move(b.vx*2, b.vy*2);
            break;
          }
        }
      }
    }
  }
  Collections.sort(entities);
  camera.go(player.x, player.y);
  terrain.show();
  render.pushMatrix();
  camera.update();
  for (int i = 0; i < entities.size(); i++) {
    Entity e = entities.get(i);
    e.show();
  }
  render.popMatrix();
  drawHub();
  render.endDraw();

  image(render, 0, 0, width, height);
}

void drawHub() {
  render.image(tiles[1][8], WIDTH/2-16, HEIGHT-10);
  render.image(tiles[2][8], WIDTH/2, HEIGHT-10);
  render.image(tiles[3][8], WIDTH/2+16, HEIGHT-10);
  float  experience = (frameCount%600)/600.;
  float life = player.life/player.lifeMax;
  float energy = player.energy/player.energyMax;

  float x1 = WIDTH/2-22;
  float y1 = HEIGHT-15;

  render.stroke(#fffef2);
  render.line(x1, y1, x1+43*experience, y1);

  y1 += 4;
  render.stroke(#e9849c);
  render.line(x1+1, y1-1, x1+42*life, y1-1);
  render.stroke(#d15975);
  render.line(x1, y1, x1+43*life, y1);
  render.line(x1+1, y1+1, x1+42*life, y1+1);

  y1 += 5;
  render.stroke(#8be1a2);
  render.line(x1+1, y1-1, x1+42*energy, y1-1);
  render.stroke(#59d179);
  render.line(x1, y1, x1+43*energy, y1);
  render.line(x1+1, y1+1, x1+42*energy, y1+1);
  render.image(tiles[1][2], mouseX/scale, mouseY/scale);
}

void keyPressed() {
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (key == 'g') generate();
}

void keyReleased() {
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
}

void mousePressed() {
  if (mouseButton == LEFT) player.shooting = true;
  if (mouseButton == RIGHT) player.superShooting = true;
}
void mouseReleased() {
  if (mouseButton == LEFT) player.shooting = false;
}

void generate() {
  noiseSeed(int(random(99999999)));
  camera = new Camera(0, 0);
  entities = new ArrayList<Entity>();
  terrain = new Terrain();

  enemyCount = 0;

  player = new Player(0, 0);
  entities.add(player);
  piece = new Piece(10, 10);
  entities.add(piece);
  /*
  for (int i = 0; i < 50; i++) {
   entities.add(new Fly(random(-400, 400), random(-400, 400)));
   entities.add(new Scorpion(random(-400, 400), random(-400, 400)));
   }
   */
}

void spawnEnemy() {
  float a = random(TWO_PI);
  float d = random(120, 300);
  float x = player.x+cos(a)*d;
  float y = player.y+sin(a)*d;
  if (random(1) < 0.5) entities.add(new Fly(x, y));
  else entities.add(new Scorpion(x, y));
}

class Camera {
  float x, y, cx, cy;
  float nx, ny;
  float sm = 1;
  Camera(float x, float y) {
    this.x = x;
    this.y = y;
    cx = WIDTH/2;
    cy = HEIGHT/2;
  }
  void update() {
    x += (nx-x)*sm;
    y += (ny-y)*sm;
    render.translate(int(cx-x), int(cy-y));
  }

  void go(float nx, float ny) {
    this.nx = nx;
    this.ny = ny;
  }

  PVector getPos(float px, float py) {
    return new PVector(px-(cx-x), py-(cy-y));
  }
}

class Entity implements Comparable {
  boolean remove;
  float x, y, s;
  Entity(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  void update() {
  }
  void show() {
  }
  void move(float nx, float ny) {
    x += nx;
    y += ny;
  }

  int compareTo(Object o) { 
    int res = 0; 
    Entity e =  (Entity) o;
    if (y < e.y) res = -1;
    else if (y > e.y) res = 1;
    else {
      if ( x < e.x) res = -1;
      else if (x > e.x) res = 1;
    }

    return res;
  }
}

class Bullet extends Entity {
  float vx, vy;
  float vel = 3;
  int time = 60;
  Entity parent;
  Bullet(Entity parent, float dx, float dy) {
    super(parent.x, parent.y);
    this.parent = parent;
    float ang = atan2(dy-parent.y, dx-parent.x);
    vx = cos(ang)*vel;
    vy = sin(ang)*vel;
  }
  void update() {
    time--;
    if (time < 0)  remove = true;
    x += vx;
    y += vy;
  }
  void show() {
  }
}

class SimpleBullet extends Bullet {
  SimpleBullet(Entity parent, float x, float y) {
    super(parent, x, y);
    s = 3;
  }
  void show() {
    render.image(tiles[2][2], int(x), int(y));
  }
}

class Mob extends Entity {
  float s;
  float life;
  Mob(float x, float y) {
    super(x, y);
  }
  void hurt(float dmg) {
    life -= dmg;
    if (life <= 0) remove();
  }
  void remove() {
    remove = true;
  }
}
// añadir energia, velocidad de movimiento, velocidad de disparo, regeneracion de energia
class Player extends Mob {

  float damage = 1;

  float energy = 10;
  float energyMax = 20;
  float energyRegeneration = 0.5;

  float lifeMax = 10;
  float lifeRegeneration = 0;

  float experience = 0;

  float movementVelocity = 0.8;

  float shootTime = 0.1;
  float shootCost = 0.2;
  float supershootCost = 5;
  float reloadTime = 0;

  boolean up, down, left, right, shooting, superShooting;
  float vm = 0.8;
  int dir = 0;
  Player(float x, float y) {
    super(x, y);
    life = 10;
  }
  void update() {

    energy += energyRegeneration/60.;
    if (energy > energyMax) energy = energyMax;

    reloadTime -= 1./60;

    if (shooting) {
      if (reloadTime <= 0 && energy >= shootCost) {
        PVector mp = camera.getPos(mouseX/scale, mouseY/scale);
        shoot(mp.x, mp.y);
        reloadTime = shootTime;
        energy-=shootCost;
      }
    }

    if (superShooting) {
      PVector mp = camera.getPos(mouseX/scale, mouseY/scale);
      superShoot(mp.x, mp.y);
    }

    PVector mov = new PVector();
    if (left) {
      mov.x -= 1;
      dir = 3;
    } else if (right) {
      mov.x += 1;
      dir = 1;
    } else if (up) {
      mov.y -= 1;
      dir = 2;
    } else if (down) {
      mov.y += 1;
      dir = 0;
    }

    if (mov.mag() > 0) {
      mov.setMag(1).mult(vm);

      int dx = (x < 0)? -7 : 7;
      int dy = (y < 0)? 11 : 27;

      int tx = int(x+mov.x+dx)/16;
      int ty = int(y+mov.y+dy)/16;
      /*
      println("------");
       println(terrain.getTile(tx-1, ty-1), terrain.getTile(tx+0, ty-1), terrain.getTile(tx+1, ty-1));
       println(terrain.getTile(tx-1, ty+0), terrain.getTile(tx+0, ty+0), terrain.getTile(tx+1, ty+0));
       println(terrain.getTile(tx-1, ty+1), terrain.getTile(tx+0, ty+1), terrain.getTile(tx+1, ty+1));
       */
      if (terrain.getTile(tx, ty) == 0) {
        x += mov.x;
        y += mov.y;
      }
    }
  }

  void show() {
    int xx = int(x);
    int yy = int(y);
    render.image(tiles[dir][1], xx, yy);

    float ang = atan2(piece.y-y, piece.x-x);
    render.noStroke();
    render.fill(#efb500);
    render.ellipse(xx+cos(ang)*10, yy+sin(ang)*10, 3, 3);
  }

  void superShoot(float dx, float dy) {
    superShooting = false;
    if (energy < supershootCost) return;
    energy -= supershootCost;
    float a = atan2(dy-y, dx-x);
    int cc = 12;
    float da = TWO_PI/cc;

    for (int i = 0; i < cc; i++) {
      float ang = a+da*i;
      entities.add(new SimpleBullet(this, x+cos(ang), y+sin(ang)));
    }
  }

  void shoot(float dx, float dy) {
    entities.add(new SimpleBullet(this, dx, dy));
  }
}
class Enemy extends Mob {
  Enemy(float x, float y) {
    super(x, y);
    enemyCount++;
  }
  void update() {
    if (abs(player.x-x) > 400 || abs(player.y-y) > 400) {
      remove();
    }
  }
  void remove() {
    remove = true;
    enemyCount--;
  }
}

class Scorpion extends Enemy {
  float mx, my, nx, ny, time;
  Scorpion(float x, float y) {
    super(x-x%16, y-x%16);
    nx = this.x;
    ny = this.y;
    s = 9;
    life = 5;
  }

  void update() {
    if (time > 0) {
      time--;
    } else {
      x += (nx-x)*0.1;
      y += (ny-y)*0.1;
      if (abs(x-nx) < 0.5 && abs(y-ny) < 0.5) {
        if (dist(x, y, player.x, player.y) < 80) {
          int dx = int(player.x-x)/4;
          int dy = int(player.y-y)/4;
          dx = constrain(dx, -2, 2);
          dy = constrain(dy, -2, 2);
          nx += dx*16;
          ny += dy*16;
        } else {
          nx += int(random(-1, 2))*16;
          ny += int(random(-1, 2))*16;
        }
        time = int(random(20, 80));
      }
    }
  }

  void show() {
    render.image(tiles[4][1], int(x), int(y));
  }

  void move(float nx, float ny) {
    x += nx;
    y += ny;
  }

  void remove() {
    super.remove();
    enemyCount--;
  }
}

class Fly extends Enemy {
  int dir;
  float des, vel;
  int time;
  Fly(float x, float y) {
    super(x, y);
    life = 3;
    s = 8;
    des = random(TWO_PI);
    vel = 0.5;
    enemyCount++;
  }
  void update() {
    time++;
    des += random(-0.3, 0.3);
    float mx = cos(des)*vel;
    float my = sin(des)*vel;
    if (dist(x, y, player.x, player.y) < 100) {
      float a = atan2(player.y-y, player.x-x);
      mx = my*0.4+cos(a)*vel*0.6;
      my = my*0.4+sin(a)*vel*0.6;
    } 
    dir = 0;
    if (mx > 0) dir = 1;
    x += mx;
    y += my;
  }
  void show() {
    int tile = 0;
    if (time%16 < 8) tile = 1;
    render.image(tiles[5+tile+dir*2][1], int(x), int(y));
  }

  void remove() {
    super.remove();
    enemyCount--;
  }
}


class Piece extends Entity {
  Piece(float x, float y) {
    super(x, y);
  }
  void update() {
    if (dist(player.x, player.y, x, y) < 10) {
      float a = random(TWO_PI);
      float d = random(WIDTH, WIDTH*2);
      x = player.x+cos(a)*d; 
      y = player.y+sin(a)*d;
    }
  }
  void show() {
    render.image(tiles[0][2], int(x), int(y));
  }
}

class Terrain {
  int ix, iy;
  int seed;
  Terrain() {
    seed = int(random(99999999));
    ix = int(random(1000, 999999))*16;
    iy = int(random(1000, 999999))*16;
  }

  void show() {
    int ts = 16;

    float cdx = camera.x%ts;
    float cdy = camera.y%ts;
    int dx = int(camera.x)/ts;
    int dy = int(camera.y)/ts;

    int cw = WIDTH/ts+6;
    int ch = HEIGHT/ts+6;
    int values[][] = new int[cw][ch];


    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        values[i][j] = getTile(i+dx-cw/2, j+dy-ch/2);
      }
    }

    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        int l = 0;
        int r = 0;
        int u = 0;
        int d = 0;
        if (i > 0) l = values[i-1][j];
        if (i < cw-1) r = values[i+1][j];
        if (j > 0) u = values[i][j-1];
        if (j < ch-1) d = values[i][j+1];
        int lu = 0;
        int ld = 0;
        int ru = 0;
        int rd = 0;
        if (i > 0 && j > 0) lu = values[i-1][j-1];
        if (i > 0 && j < ch-1) ld = values[i-1][j+1];
        if (i < cw-1 && j > 0) ru = values[i+1][j-1];
        if (i < cw-1 && j < ch-1) rd = values[i+1][j+1];
        int tx = 0; 
        int ty = 0;

        int tile = values[i][j];
        if (tile == 1) {
          tx = 0;
          ty = 3;
          int cnt = l+r+u+d;
          if (cnt != 0) {
            if (cnt == 1) {
              if (l == 1) {
                tx += 3;
                ty += 1;
              } else if (r == 1) {
                tx += 1;
                ty += 1;
              } else if (u == 1) {
                tx += 2;
                ty += 2;
              } else if (d == 1) {
                tx += 2;
                ty += 0;
              }
            } else if (cnt == 2) {
              if (l == 1 && r == 1) {
                tx += 0;
                ty += 1;
              } else if (u == 1 && d == 1) {
                tx += 0;
                ty += 2;
              } else if (r == 1 && d == 1) {
                if (rd == 1) {
                  tx += 4;
                  ty += 0;
                } else {
                  tx += 1;
                  ty += 0;
                }
              } else if (r == 1 && u == 1) {
                if (ru == 1) {
                  tx += 4;
                  ty += 2;
                } else {
                  tx += 1;
                  ty += 2;
                }
              } else if (l == 1 && d == 1) {
                if (ld == 1) {
                  tx += 6;
                  ty += 0;
                } else {
                  tx += 3;
                  ty += 0;
                }
              } else if (l == 1 && u == 1) {
                if (lu == 1) {
                  tx += 6;
                  ty += 2;
                } else {
                  tx += 3;
                  ty += 2;
                }
              }
            } else if (cnt == 3) {
              if (l == 0) {
                tx += 4;
                ty += 1;
              } else if (r == 0) {
                tx += 6;
                ty += 1;
              } else if (u == 0) {
                tx += 5;
                ty += 0;
              } else if (d == 0) {
                tx += 5;
                ty += 2;
              }
            } else if (cnt == 4) {
              tx += 5;
              ty += 1;
            }
          }
        }
        render.image(tiles[tx][ty], (i-3)*ts-cdx, (j-3)*ts-cdy);
      }
    }
  }
  int getTile(int x, int y) {
    float det = 0.2;
    int tile = 0;
    if (noise((ix+x)*det, (iy+y)*det) > 0.6) tile = 1;
    return tile;
  }
}

PImage[][] cutSprites(int sw, int sh, PImage aux) {
  int cx = aux.width/sw;
  int cy = aux.height/sw;
  PImage res[][] = new PImage[cx][cy];
  for (int j = 0; j < cy; j++) {
    for (int i = 0; i < cx; i++) {
      res[i][j] = createImage(sw, sh, ARGB);
      res[i][j].copy(aux, i*sw, j*sh, sw, sh, 0, 0, sw, sh);
    }
  }
  return res;
}