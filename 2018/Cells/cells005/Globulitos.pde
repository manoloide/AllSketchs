class Globulito {
  boolean remove, injured;
  float x, y, s, a;
  float time;
  Globulito(float x, float y) {
    this.x = x; 
    this.y = y;
    s = random(2, 3)*0.5;
    a = random(TAU);
  }

  void update() {
    if(injured) time -= 10./60;
    else time += 1./60;
    
    if(injured && time > 1){
      time = 1;
    }
    if(injured && time < 0){
       remove = true; 
    }
    
    a += random(-0.1, 0.1);
    x += cos(a)*0.1;
    y += sin(a)*0.1;
    
    float rx = modelX(x, y, 0);
    float ry = modelY(x, y, 0);
    
    if(!injured && mask.get(int(rx), int(ry)) != color(80)){
       injured = true; 
    }
  }

  void show() {
    noStroke();
    //fill(#F487BB);
    fill(#059281);
    float ss = s*constrain(time, 0, 1);
    ellipse(x, y, ss, ss);
  }
}
