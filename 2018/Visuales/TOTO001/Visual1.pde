

class Visual1 extends Visual {
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
    
    feedback(int(random(-4, 4)), 0);

    render.imageMode(CENTER);
    for (int i = 0; i < 20; i++) {
      float ss = cos(time*random(0.2, random(0.5, 3)))*0.5+0.5;
      ss *= height*random(0.2, 0.8);
      render.pushMatrix();
      render.translate(random(width), random(height));
      render.rotate(time*random(-0.1, 0.1));
      render.image(getImage(), 0, 0, ss, ss);
      render.popMatrix();
    }
  }
} 