class Visual3 extends Visual {
  class Particle {
    boolean remove;
    float x, y, a, s, v; 
    float ic, dc; 
    Particle(float x, float y) {
      this.x = x; 
      this.y = y; 
      this.s = random(2, 180)*random(1);
      v = random(s*0.1)*random(0.1, 1);
      dc = random(20)*random(1)*random(1);
    }
    void update(float det, float time) {
      a = noise(x*det, y*det, time)*TWO_PI*2+random(-0.2, 0.2);
      x += cos(a)*v;
      y += sin(a)*v;

      if (x < -s) x += render.width+s*2;
      if (y < -s) y += render.width+s*2;
      if (x > render.width+s)  x -= render.width+s*2;
      if (y > render.width+s) y -= render.width+s*2;
    }
    void show() {
      render.noStroke();
      //render.tint(cs.getColor(ic+dc*time), 100);
      render.image(getImage(), x, y, s, s);
      //render.noTint();
    }
  }
  ArrayList<Particle> particles;
  void init() {
    particles = new ArrayList<Particle>();
    int cc = int(random(100));
    if (cc < 10) cc = 10;
    for (int i = 0; i < cc; i++) {
      particles.add(new Particle(random(render.width), random(render.height)));
    }
    //background(cs.rcol());
  }

  void reset() {
    seed = int(random(9999999));
    init();
  }

  void update() {
    randomSeed(seed);
    float det = random(0.01);
    float tt = time*random(0.01)*random(1)*random(1);
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).update(det, tt);
    }
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    int sca = int(random(-4, 4));
    render.translate(render.width/2, render.height/2);
    render.rotate(cos(time*random(-0.1, 0.1))*0.1);
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);
    render.translate(-render.width/2, -render.height/2);

    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).show();
    }
  }
} 