ArrayList<Particle> particles;

void setup() {
  size(960, 960, P3D); 
  smooth(4);
  generate();
}


void draw() {
  background(10);
  translate(width/2, height/2, -400);

  float vel = 0.02;
  rotateX(frameCount*0.07*vel);
  rotateY(frameCount*0.012*vel);
  rotateZ(frameCount*0.003*vel);

  stroke(180, 80);
  fill(255, 240);

  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.updateMovement(); 
    if (p.remove) particles.remove(i--);
  }

  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update(); 
    if (p.remove) particles.remove(i--);
  }
}

void keyPressed() {
  generate();
}

void generate() {
  particles = new ArrayList<Particle>();

  Particle ant = new Particle(0, 0, 0);
  ant.setTarget(random(-500, 500), random(-500, 500), random(-500, 500));
  particles.add(ant);
  for (int i = 0; i < 20; i++) {
    Particle p = new Particle();
    p.setTarget(random(-500, 500), random(-500, 500), random(-500, 500));
    particles.add(p);
  }
}

class Particle {
  ArrayList<Particle> childrens;
  boolean remove;
  float vel, elastic;
  int level;
  Particle parent;
  PVector position, target;
  PVector velocity, force;

  Particle() {
    init();
  }

  Particle(Particle parent) {
    init();
    setParent(parent);
  }

  Particle(float x, float y, float z) {
    init();
    position = new PVector(x, y, z);
  }

  Particle(Particle parent, float x, float y, float z) {
    init();
    setParent(parent);
    position = new PVector(x, y, z);
  }

  void init() {
    parent = null;
    position = new PVector();
    target = new PVector();
    childrens = new ArrayList<Particle>();
    velocity = new PVector();
    force = new PVector();
    vel = random(0.6, 0.82);
    elastic = random(0.01, 0.014);
  }

  void updateMovement() {
    force = new PVector();
    if (parent != null) {
      for (int i = 0; i < parent.childrens.size (); i++) {
        Particle p = parent.childrens.get(i);
        if (p == this) continue;
        float dis = target.dist(p.target);
        float distance = 20;
        if (dis < distance) {
          float vel = (dis-distance)*0.1;
          PVector vec = new PVector(p.target.x, p.target.y, p.target.z);
          vec.sub(target);
          vec.normalize();
          vec.mult(vel); 
          force.add(vec);
        }
      }
    }
  }

  void update() {

    target.add(force);

    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    velocity.add(aux);
    velocity.mult(vel);
    position.add(velocity);

    if (level < 2 && childrens.size() < 3 && velocity.mag() < 0.1 ) {
      float dd = 220/(level+1);
      for (int i = 0; i < 10; i++) {
        Particle p = new Particle(this, position.x, position.y, position.z);
        float a1 = random(TWO_PI);
        float a2 = random(TWO_PI);
        p.setTarget(position.x+cos(a1)*cos(a2)*dd, position.y+cos(a1)*sin(a2)*dd, position.z+sin(a1)*dd);
        particles.add(p);
        addChild(p);
      }
    }
    /*
    movement.sub(position);
     movement.mult(0.4);
     position.add(movement);
     */
    show();
  }

  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    box(4);
    /*
    ellipse(0, 0, 40, 40);
     line(-10, -10, 10, 10);
     line(-10, 10, 10, -10);
     */
    popMatrix();

    for (int i = 0; i < childrens.size (); i++) {
      Particle c = childrens.get(i);
      line(position.x, position.y, position.z, c.position.x, c.position.y, c.position.z);
    }
  }

  void setParent(Particle p) {
    parent = p;
    parent.addChild(this);
  }
  void setPosition(float x, float y, float z) {
    position = new PVector(x, y, z);
  }

  void setTarget(float x, float y, float z) {
    target = new PVector(x, y, z);
  }

  void addChild(Particle p) {
    if (!childrens.contains(p)) {
      childrens.add(p);
      p.caculateLevel();
    }
  }

  void caculateLevel() {
    level = 0;
    Particle aux = this;
    while (aux.parent != null) {
      level++;
      aux = aux.parent;
    }
  }
}

