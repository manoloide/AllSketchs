ArrayList <pelota> pel = new ArrayList<pelota>();

void setup() {
  size(400, 400);
  stroke(0,60);
  fill(255,180);
}

void draw() {
  for (pelota p:pel) {
    p.act();
  }
}

void mousePressed() {
  pel.add(new pelota(mouseX, mouseY));
}

class pelota {
  float x, y, tam, velx, vely;
  pelota(float nx, float ny) {
    x = nx;
    y = ny;
    tam = random(10, 60);
    float ang = random(TWO_PI);
    velx = cos(ang);
    vely = sin(ang);
  }
  void act() {
    x += velx;
    y += vely;
    if(x < tam/2 || x > width-tam/2){
       velx*=-1; 
    }
    if(y < tam/2 || y > height-tam/2){
       vely*=-1; 
    }
    ellipse(x, y, tam, tam);
  }
}

