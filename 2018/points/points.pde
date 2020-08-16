ArrayList<Particle> particles;

void setup() {
  size(960, 540, P2D);
  smooth(8);
  pixelDensity(2);

  particles = new ArrayList<Particle>();
}

void draw() {
  background(#4D5055);
  
  if(frameCount%(20*60) == 0) particles.add(new Particle(random(width), random(height), random(20, 120), random(TAU)));

  calculateRepulsion();

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
    if (p.remove) particles.remove(i--);
  }
}

void calculateRepulsion() {
  for (int i = 0; i < particles.size(); i++) {
    Particle p1 = particles.get(i);
    for (int j = i+1; j < particles.size(); j++) {
      Particle p2 = particles.get(j);
      float ang = atan2(p2.pos.y-p1.pos.y, p2.pos.x-p1.pos.x);
      float dis = dist(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
      float max = p1.s+p2.s;
      if (dis < max*0.8) {
        float rep = map(dis, 0, max*0.8, 0.08, 0);
        p1.pos.x += cos(ang-PI)*dis*rep;
        p1.pos.y += sin(ang-PI)*dis*rep;
        p2.pos.x += cos(ang)*dis*rep;
        p2.pos.y += sin(ang)*dis*rep;
      }
    }
  }
}

void mousePressed() {
  particles.add(new Particle(mouseX, mouseY, random(20, 120), random(TAU)));
}

class Particle {
  boolean remove;
  PVector pos;
  float ns, s, a, va;
  int col, type;
  Particle(float x, float y, float s, float a) {
    this.pos = new PVector(x, y);
    this.s = 0;
    this.ns = s;
    this.a = a;
    
    type = int(random(3));
    a = random(TAU);
    va = random(0.002)*random(-1, 1);

    col = (random(1) < 0.8)? color(10) : color(240);
  }
  void update() {
    
    s = lerp(s, ns, 0.004);
    
    float ang = atan2(mouseY-pos.y, mouseX-pos.x);
    pos.x += cos(ang)*0.03;
    pos.y += sin(ang)*0.03;
    
    a += va;
  }
  void show() {
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    if (type == 0) ellipse(0, 0, s, s);
    if (type == 1) rect(-s*0.5, -s*0.01, s, s*0.2);
    if (type == 2) triangle(cos(a)*s*0.5, sin(a)*s*0.5, cos(a+TAU/3)*s*0.5, sin(a+TAU/3)*s*0.5, cos(a+TAU*2./3)*s*0.5, sin(a+TAU*2./3)*s*0.5); 
    popMatrix();
  }
}
