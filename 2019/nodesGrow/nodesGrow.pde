import peasy.PeasyCam;

ArrayList<Particle> particles;

PeasyCam cam;

void setup() {
  size(1920, 1080, P3D);
  smooth(8);
  cam = new PeasyCam(this, 400);

  particles = new ArrayList<Particle>();
}


void draw() {

  background(0);

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    if (keyPressed) {
      p.update();
    }
    p.show();
    if (p.remove) {
      particles.remove(i--);
    }
  }
}

void keyPressed() {
  particles.clear();
  for (int i = 0; i < 10; i++) {
    particles.add(new Particle(random(-0.5, 0.5), random(-0.5, 0.5), random(-0.5, 0.5)));
  }
}
