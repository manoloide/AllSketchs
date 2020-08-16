class Bicho {
  float x, y, s;
  float time, vel, ang, v1;
  int seed;
  Bicho() {
    x = random(width);
    y = random(height); 
    s = getSize();
    vel = random(1);
    ang = random(TAU);
    v1 = random(0.1);
    time = 0;
    seed = int(random(9999999));
  }

  void update(float delta) {
    time += delta*0.005*vel;
    x = noise(time*20, seed)*width;
    y = noise(seed, time*20)*height;
    s = getSize();
  }

  void show() {
    stroke(128+128*cos(time), 2);
    //fill(255, 14*cos(time));
    fill(getColor(time*20), 10);
    ellipse(x, y, s, s);
    float r1 = s*0.5;
    float r2 = s*3;
    float a = random(TAU*5)*random(-1, 1)*random(0.2, 1)+time*v1+ang;
    stroke(200+56*cos(time*2), random(10));
    line(x+cos(a)*r1, y+sin(a)*r1, x+cos(a)*r2, y+sin(a)*r2);
  }

  float getSize() {
    return (1-pow(cos(time*10)*0.5+0.5, 2))*50;
  }
}
