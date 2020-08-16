class Visual2 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    noiseSeed(seed);
    randomSeed(seed);
    
    feedback(int(random(-20, 20)), 0);
    
    float tt = random(0.2, random(0.5, 3));
    int seg = int(random(4, 12));
    int div = int(random(1, 5));
    float da = time*random(-0.8, 0.8)*random(1);
    render.imageMode(CENTER);
    for (int j = 0; j < div; j++) {
      for (int i = 0; i < seg; i++) {
        float ang = map(i, 0, seg, 0, TAU)+da;
        float ss = width*(cos(time*tt)*0.5+0.5)*map(j, 0, 4, 0.1, 0.8);
        float xx = width*0.5+cos(ang)*ss;
        float yy = height*0.5+sin(ang)*ss;
        render.pushMatrix();
        render.translate(xx, yy);
        render.fill(cs.rcol());
        render.image(getImage(), 0, 0, ss, ss);
        render.popMatrix();
      }
    }
  }
} 