/* @pjs font="Roboto-Bold.ttf"; */
ArrayList<Particle> particles; 
boolean mouseMoving;

int paleta[] = {
  #87ffe1, 
  #f5871e, 
  #eb4b9b, 
  #faf08c
};

PShape marca;

void setup() {
  size(700, 140);
  background(0);
  marca = loadShape("marca.svg");
  particles = new ArrayList<Particle>();
  shapeMode(CENTER);
}

void draw() {
  background(0);
  if (mouseMoving) {
    float t = pow(dist(pmouseX, pmouseY, mouseX, mouseY), 1.2);
    t = max(10, min(140, t));
    shape(marca, mouseX, mouseY, t, t);
    particles.add(new Particle(mouseX, mouseY, t));
  }

  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) {
      particles.remove(i--);
    }
  }
}

void mouseMoved() {
  mouseMoving = true;
}

class Particle {
  boolean remove;
  float x, y, s; 
  float vy, vs;
  Particle(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;
    vy = random(0.5, 4);
    vs = random(0.88, 0.99);
  }
  void update() {
    y -= vy;
    s *= vs;
    if (s < 0.1) {
      remove = true;
    }
    show();
  }
  void show() {
    shape(marca, x, y, s, s);
  }
}

