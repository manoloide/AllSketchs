PGraphics back;

Mallet mallet;
Pointer pointer;
Puck puck;

void setup() {
  size(480, 720);
  mallet = new Mallet(width/2, height/2);
  pointer = new Pointer(width/2, height*0.3, 50);
  puck = new Puck(width/2, height/2);

  back = createGraphics(width, height);
  back.beginDraw();
  back.background(80);
  back.strokeWeight(4);
  back.stroke(120);
  back.line(0, height/2, width, height/2);
  back.fill(80);
  back.ellipse(width/2, height/2, 100, 100);
  back.ellipse(width/2, height/2, 4, 4);
  back.strokeWeight(1);
  back.fill(60);
  back.stroke(120, 20);
  int ss = 40;
  ss = 8;
  for (int j = 0; j < back.height; j+=ss) {
    for (int i = 0; i < back.width; i+=ss) {
      if ((i+j)%(ss*2) == 0) {
        back.ellipse(i, j, ss*0.3, ss*0.3);
      }
    }
  }
  back.endDraw();
  noStroke();
}

void draw() {
  image(back, 0, 0);

  pointer.update();
  mallet.update();
  puck.update();
}

class Puck {
  float x, y, s, r;
  float px, py;
  float vx, vy;
  float d = 0.993;
  Puck(float x, float y) {
    this.x = x;
    this.y = y;
    s = 40;
    r = s*0.5;

    vx = random(-1, 1)*50;
    vy = random(-1, 1)*50;
  }

  void update() {
    px = x;
    py = y;

    float dx = vx;
    float dy = vy;

    float mag = mag(dx, dy);
    float des = mag;
    while (des > 0) {
      float vel = 1./mag * min(des, 1);
      x += vx*vel;
      y += vy*vel;

      if ((x < r && vx < 0) || (x > width-r && vx > 0)) vx*=-1;
      if ((y < r && vy < 0) || (y > height-r && vy > 0)) vy*=-1;

      if (dist(x, y, mallet.x, mallet.y) < r+mallet.r) {
        float d = atan2(y-mallet.y, x-mallet.x); 
        hit(d, mallet.v);
      }

      des--;
    }

    if (dist(x, y, pointer.x, pointer.y) < r+pointer.r) {
      pointer.repos();
    }

    vx *= d;
    vy *= d;

    show();
  }

  void show() {
    fill(200, 255, 20);
    ellipse(x, y, s, s);
    stroke(0, 20);
    fill(0, 8);
    ellipse(x, y, s*0.8, s*0.8);
  }

  void hit(float d, float v) {
    float av = mag(vx, vy);
    float nv = v+av;
    if (nv > 20) nv = 20;
    vx = cos(d)*nv;
    vy = sin(d)*nv;
  }
}

class Mallet {
  float x, y, s, r;
  float px, py;
  float v;
  float sm = 0.8;
  Mallet(float x, float y) {
    this.x = x; 
    this.y = y;
    s = 50;
    r = s*0.5;
  }

  void update() {
    float nx = mouseX;
    float ny = mouseY;
    //if (ny < height/2+r) ny = height/2+r;
    px = x;
    py = y;
    x += (nx-x)*sm;
    y += (ny-y)*sm;

    v = dist(mouseX, mouseY, pmouseX, pmouseY)*0.2;
    if (v > 40) v = 40;

    show();
  }

  void show() {
    noStroke();
    fill(255, 40, 20);
    ellipse(x, y, s, s);
    stroke(0, 20);
    fill(0, 8);
    ellipse(x, y, s*0.8, s*0.8);
  }
}

class Pointer {
  float x, y, s, r;
  Pointer(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    r = s*0.5;
  }

  void update() {

    show();
  }

  void show() {
    int cc = 3;
    strokeWeight(3);
    stroke(255, 130, 0);
    noFill();
    for (int i = 0; i < cc; i++) {
      float ss = map(i, 0, cc-0.5, s, 0);
      ellipse(x, y, ss, ss);
    }
  }

  void repos() {
    x = random(s, width-s);
    y = random(s, height*0.5-s);
  }
}