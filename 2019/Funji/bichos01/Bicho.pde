class Bicho {
  float x, y, s, lar;
  float time, vel, ang, v1;
  int seed, col;
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
    time += delta*0.002*vel;
    x = noise(time*20, seed)*width;
    y = noise(seed, time*20)*height;
    s = getSize();
    lar = random(1, 2);
    col = getColor(time*200);
    
    if(random(1) < 0.01){
     for(int i = 0; i < 100; i++){
       walkers.add(new Walker(x, y, random(10)*random(1)*random(1)*random(1)*random(1), col));
     }
    }
  }

  void show() {
    stroke(128+128*cos(time), 2);
    //fill(255, 14*cos(time));
    fill(col, 20);
    ellipse(x, y, s, s);
    float r1 = s*0.5;
    float r2 = s*lar;
    for (int i = 0; i < 10; i++) {
      float a = noise(time*4+random(0.1))*TAU*5+v1+ang;
      stroke(200+56*cos(time*2), random(6)*random(1)*random(1));
      line(x+cos(a)*r1, y+sin(a)*r1, x+cos(a)*r2, y+sin(a)*r2);
    }
  }

  float getSize() {
    return (1-pow(cos(time*10)*0.5+0.5, 2))*50;
  }
}
