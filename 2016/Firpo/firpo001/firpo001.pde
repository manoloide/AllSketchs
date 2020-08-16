ArrayList<Particle> particles;
float z;

PImage img;

void setup() {
  size(900, 900);
  img = loadImage("https://scontent.fgru3-2.fna.fbcdn.net/v/t1.0-1/14440964_10154608520988179_5738855555904655440_n.jpg?oh=9a5fd7d1c35eb9f29f325879277a6373&oe=58A72095");
  generate();
  background(0);
}

void draw() {
  background(0);
  fill(0, 50);
  noStroke();
  rect(0, 0, width, height);

  z += 0.02;

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
  }
}

void keyPressed() {
  generate();
}

void generate() {
  particles = new ArrayList<Particle>();

  for (int i = 0; i < 6000; i++) {
    particles.add(new Particle(random(width), random(height)));
  }
}

float det = 0.005;

class Particle {
  PVector ant, pos;
  Particle(float x, float y) {
    pos = new PVector(x, y);
  }

  void update() {
    float vel = 0.4;
    float ang = noise(pos.x*det, pos.y*det, z)*TWO_PI*2;
    ant = pos.copy();
    pos.add(new PVector(cos(ang)*vel, sin(ang)*vel));
  }

  void show() {
    strokeWeight(2);
    stroke(img.get(int(pos.x), int(pos.y)));
    //point(pos.x, pos.y);
    line(pos.x, pos.y, ant.x, ant.y);
  }
}