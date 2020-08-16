ArrayList<Particle> particles;

float gridSize = 20;

void setup() {
  size(960, 540);
  smooth(2);
  pixelDensity(2);
  frameRate(25);
  rectMode(CENTER);

  particles = new ArrayList<Particle>();
}

void draw() {
  background(0);
  noStroke();
  fill(255, 40);
  for (int j = 0; j <= height; j+=gridSize) {
    for (int i = 0; i <= width; i+=gridSize) {
      rect(i, j, 2, 2);
    }
  }

  if (frameCount%4 == 0) {
    addParticle();
  }

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
    if (p.remove) particles.remove(i--);
  }
}

void keyPressed() {
  for (int i = 0; i < 100; i++) {
    addParticle();
  }
}

void addParticle() {
  float xx = gridSize*int(random(width/gridSize));
  float yy = gridSize*int(random(height/gridSize));
  particles.add(new Particle(xx, yy));
}

class Particle {
  boolean remove;
  float x, y, s;
  float nx, ny;
  float time;
  Particle(float x, float y) {
    this.x = nx = x; 
    this.y = ny = y; 
    s = 4; 
    time = 0;
    remove = false;
  }
  void update() {
    time += 1./60;
    if (nx != x || ny != y) {
      x = lerp(x, nx, 0.1); 
      y = lerp(y, ny, 0.1);
      if (abs(nx-x) < 0.1) x = nx;
      if (abs(ny-y) < 0.1) y = ny;
    } else if (time > 2) {
      if (random(1) < 0.5) nx += (int(random(2))*2-1)*gridSize;
      else ny += (int(random(2))*2-1)*gridSize;
    }

    if (time > 12) remove = true;
    if (time > 11) s = map(time, 11, 12, 4, 0);
  }
  void show() {
    fill(255);
    float ss = constrain(time, 0, 1)*s;

    float nw = ss;
    if (nx != x) nw = gridSize-abs(nx-x);
    float nh = ss;
    if (ny != y) nh = gridSize-abs(ny-y);
    rect(x, y, nw, nh);
  }
}