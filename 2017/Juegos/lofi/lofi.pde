final int WIDTH = 160;
final int HEIGHT = 120;
final int scale = 6;

Screen3D world;
PImage sprites;
Player player;

void settings() {
  size(WIDTH*scale, HEIGHT*scale);
  noSmooth();
  sprites = loadImage("tiles.png");
  player = new Player(0, 0, 0);
  world = new Screen3D(WIDTH, HEIGHT);
}

void setup() {
}

void draw() {

  player.update();
  world.update();

  image(world.render, 0, 0, width, height);
}

void keyPressed() {
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
}

void keyReleased() {
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
}

class Player {
  boolean up, down, left, right;
  float x, y, z;
  float rot;
  float mx, my;

  float vm = 0.1;
  float vr = 0.04;

  Player(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    rot = 0;
  }

  void update() {
    mx = 0;
    my = 0;

    if (abs(width/2-mouseX) > width*0.2) {
      float dir = (width/2-mouseX < 0) ? 1 : -1;
      float vel = map(abs(width/2-mouseX), width*0.2, width*0.5, 0, 1);
      rot += vr*dir*vel;
    }

    if (up) {
      mx += cos(-rot+HALF_PI)*vm;
      my += sin(-rot+HALF_PI)*vm;
    }
    if (down) {
      mx -= cos(-rot+HALF_PI)*vm;
      my -= sin(-rot+HALF_PI)*vm;
    }
    if (left) {
      mx -= cos(-rot)*vm;
      my -= sin(-rot)*vm;
    }
    if (right) {
      mx += cos(-rot)*vm;
      my += sin(-rot)*vm;
    }

    this.x += mx;
    this.y += my;
  }
}


class Screen3D {
  int w, h;
  double xCam, yCam, zCam, rot, fov;
  double[] zBuffer;
  PImage render;
  Screen3D(int w, int h) {
    this.w = w; 
    this.h = h;
    render = createImage(w, h, RGB);
    zBuffer = new double[w*h];
  }

  void update() {
    render.loadPixels();
    renderFloor();
    renderFog();
    render.updatePixels();
  }

  void renderFloor() {
    float time = millis()/1000.;

    float cx = w*0.5;
    float cy = h*0.4;

    xCam = player.x;
    yCam = player.y;
    zCam = player.z;
    rot = player.rot;
    fov = h*0.6;

    double rCos = Math.cos(rot);
    double rSin = Math.sin(rot);
    for (int y = 0; y < h; y++) {
      double yd = ((y+0.5)-cy)/fov;
      double zd = (4-zCam*8)/yd;
      if (yd < 0) {
        zd = (4+zCam*8)/-yd;
      }
      for (int x = 0; x < w; x++) {
        double xd = (cx-x)/fov;
        xd *= zd;
        double xx = xd*rCos+zd*rSin+(xCam+0.5)*8;
        double yy = zd*rCos-xd*rSin+(yCam+0.5)*8;

        int xp = (int)xx&7;
        int yp = (int)yy&7;
        if (xp < 0) xp--;
        if (yp < 0) yp--;
        zBuffer[x+y*w] = zd;
        render.pixels[x+y*w] = sprites.get(xp, yp);
      }
    }

    randomSeed(100);
    for (int i = 0; i < 1000; i++) {
      double x = random(-2, 2) - xCam*2;
      double y = random(-2, 2) - yCam*2;
      double z = (1.5 -zCam)*2;

      double xx = x*rCos+y*rSin;
      double yy = z;
      double zz = y*rCos-x*rSin;

      if (zz > 0) {
        int px = (int) (xx/zz*fov+cx);
        int py = (int) (yy/zz*fov+cy);
        if (px >= 0 && px < w && py >= 0 && py < h) {
          zBuffer[px+py*w] = zz*4;
          render.pixels[px+py*w] = 0xffffffff;
        }
      }
    }
  }
  void renderFog() {
    for (int i = 0; i < w*h; i++) {
      float fog = (int)(15000/(zBuffer[i]*zBuffer[i])*10);
      fog = constrain(fog, 0, 255);
      fog = fog/255.;
      int col = render.pixels[i];
      render.pixels[i] = color(red(col)*fog, green(col)*fog, blue(col)*fog);
    }
  }
}