ArrayList<Particle> particles;
int cc = 4; 
float ss = 420;
int time = 60;

void setup() {
  size(960, 960, P3D);
  smooth(4);
  generate();
}

void draw() {
  background(5);
  translate(width/2, height/2, -300+cos(frameCount*0.008)*40);
  rotateX(frameCount*0.0073);
  rotateY(frameCount*0.00031);
  rotateZ(frameCount*0.00001);

  time = 0;
  if (random(100) < 0.1 && time < 0) {
    generate();
    time = 50*60;
  }

  /*
  stroke(255, 8);
   for (int j = 0; j <= cc; j++) {
   for (int i = 0; i <= cc; i++) {
   float p = -ss/2.;
   float d = ss/cc;
   line(p+d*i, p+d*j, -p, p+d*i, p+d*j, p);
   line(p+d*i, -p, p+d*j, p+d*i, p, p+d*j);
   line(-p, p+d*i, p+d*j, p, p+d*i, p+d*j);
   }
   }
   */

  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
    p.show();
  }
  /*
  if (frameCount%2 == 0) {
   saveFrame("####.png");
   if (frameCount/2 > 30*5) {
   for (int i = 0; i < particles.size (); i++) {
   Particle p = particles.get(i);
   p.move = true;
   p.vel = random(0.05, 0.2);
   p.npos = new PVector();
   }
   */
  if (frameCount%2 == 0) {
    saveFrame("export/####.png");
    if(frameCount > 2048*2+4)
      exit();
  }
}

void generate() {
  cc = int(random(3, 7)); 
  ss = random(300, 500);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 240; i++) {
    particles.add(new Particle());
  }
}

class Particle {
  boolean move, remove;
  float vel;
  PVector pos, ant, npos;
  Particle() {
    pos = new PVector();
    ant = new PVector();
    npos = newPos();
    move = true;
    randomVel();
  }

  void update() {
    if (move) {
      ant = new PVector(pos.x, pos.y, pos.z);
      PVector des = new PVector(npos.x, npos.y, npos.z);
      des.sub(pos);
      des.mult(vel);
      pos.add(des);
      float d = pos.dist(npos);
      if (d < 0.01) move = false;
    } else {
      if (random(1) < 0.005) {
        randomVel();
        npos = newPos2();
        move = true;
      }
    }
  }

  void show() {
    stroke(255);
    line(ant.x, ant.y, ant.z, pos.x, pos.y, pos.z);
    point(pos.x, pos.y, pos.z);
  }

  void randomVel() {
    vel = random(0.02, 0.2);
  }

  float newVal() { 
    float v = -ss/2.;
    float d = ss/cc;
    return v+d*int(random(cc+1));
  }

  PVector newPos() { 
    return new PVector(newVal(), newVal(), newVal());
  }

  PVector newPos2() {
    PVector aux = new PVector(npos.x, npos.y, npos.z);
    if (random(1) < 0.333333) {
      aux.x = newVal();
    } else {
      if (random(1) < 0.5) aux.y = newVal();
      else aux.z = newVal();
    }
    return aux;
  }
}

