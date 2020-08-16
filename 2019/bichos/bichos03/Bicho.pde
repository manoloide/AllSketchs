class Bicho {
  float x, y, s, size;
  float time, vel, ang, v1;
  int seed;
  Bicho() {
    x = random(width);
    y = random(height); 
    s = getSize();
    size = random(100)*random(0.2, 1);
    vel = random(1);
    ang = random(TAU);
    v1 = random(0.1);
    time = 0;
    seed = int(random(9999999));
  }

  void update(float delta) {
    time += delta*0.002*vel;
    x = (noise(time*20, seed)*2.4-0.7)*width;
    y = (noise(seed, time*20)*2.4-0.7)*height;
    s = getSize();
  }

  void show() {
    stroke(128+128*cos(time), 2);
    //fill(255, 14*cos(time));
    fill(getColor(time*200), 20);
    ellipse(x, y, s, s);
    float r1 = s*0.5;
    float r2 = s*3;
    float a = noise(time*4)*TAU*5+v1+ang;
    stroke(200+56*cos(time*2), random(30)*random(1)*random(1));
    line(x+cos(a)*r1, y+sin(a)*r1, x+cos(a)*r2, y+sin(a)*r2);
  }

  float getSize() {
    return (1-pow(cos(time*10)*0.5+0.5, 2))*size;
  }
}
