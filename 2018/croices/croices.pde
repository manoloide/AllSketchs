ArrayList<Particle> particles;

float time = 0;
float grid = 20;

void setup() {
  size(displayWidth, displayHeight);
  pixelDensity(2);
  smooth(8);

  generate();
}

void draw() {
  background(0);

  noFill();
  stroke(255);
  strokeWeight(2);

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
    if (p.remove) particles.remove(i--);
  }
}

class Particle {
  boolean remove;
  float x, y;
  void update() {
  };
  void show() {
  };
}

class Line extends Particle {
  float nx, ny;
  int dir;
  float a1, a2, s1, s2;
  Line() {
    this(random(width+grid), random(height+grid));
  }
  Line(float x, float y) {
    this.x = x;
    this.y = y;
    x -= x%grid;
    y -= y%grid;
    dir = int(random(4));
    if (dir%2 == 0) {
      nx = x;
      ny = y+((dir/2)*2-1)*int(random(1, 10))*grid;
    } else {
      nx = x+((dir/2)*2-1)*int(random(1, 10))*grid;
      ny = y;
    }
    a1 = a2 = 0;
    s1 = random(0.2, 0.3);
    s2 = random(0.3, 0.4);
  }
  void update() {
    a1 = lerp(a1, 1, s1);
    a2 = lerp(a2, 1, s2);
    if (a1 > 0.9999 && a2 > 0.9999) {
      particles.add(new Explo(nx, ny));
      remove = true;
    }
  }
  void show() {
    float x1 = lerp(x, nx, a1);
    float y1 = lerp(y, ny, a1);
    float x2 = lerp(x, nx, a2);
    float y2 = lerp(y, ny, a2);
    stroke(255);
    line(x1, y1, x2, y2);
  }
}

class Explo extends Particle {
  float life, tt;
  Explo(float x, float y) {
    this.x = x; 
    this.y = y;
    tt = 0;
    life = random(4, 12);
  }
  void update() {
    tt += 1./60;

    if (tt > life) {
      remove = true;
      particles.add(new Line(x, y));
    }
  }

  void show() {
    float tm = map(tt, 0, life, 0, 1);
    float ts = tm;
    if (tm > 0.1) {
      ts = 0.5+cos(ts*10)*1.2;
    }
    rectMode(CENTER);
    float s = 10*ts;



    if (tm > 0.2) {
      float ss = cos(tm*TWO_PI*4)*100;
      strokeWeight(1);
      stroke(255);
      line(x-ss, y, x+ss, y);
      line(x, y-ss, x, y+ss);
    }

    noFill();
    stroke(20);
    strokeWeight(2);
    rect(x, y, tm*20, tm*20);

    noFill();
    stroke(255);
    strokeWeight(1);
    if (s > 5) fill(255);
    rect(x, y, s, s);
  }
}

void keyPressed() {
  generate();
}

void generate() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 100; i++) {
    particles.add(new Line());
  }
}
