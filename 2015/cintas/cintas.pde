ArrayList<Particula> particulas;

void setup() {
  size(600, 600);
  particulas = new ArrayList<Particula>();
  for (int i = 0; i < 10; i++) {
    particulas.add(new Particula(-10, random(height)));
  }
}

void draw() {
  for (int j = 0; j < 40; j++) {
    for (int i = 0; i < particulas.size (); i++) {
      Particula p = particulas.get(i);
      p.update();
    }
  }
}

class Particula {
  color col;
  int colors[] = {
    #B4D88E, 
    #EAD465, 
    #D99E52, 
    #C64E3E, 
    #352D2B
  };
  float x, y, ang, tam, vel;
  float ax, ay, aa;
  Particula(float x, float y) {
    this.x = x; 
    this.y = y;
    init();
  }
  void init() {
    col = colors[int(random(colors.length))];
    col = color(red(col)+random(-5, 5), green(col)+random(-5, 5), blue(col)+random(-5, 5));
    x = -tam;
    y = random(height);
    ang = 0;
    tam = random(4, 40);
    vel = random(2, 8);
  }
  void update() {
    aa = ang;
    ax = x;
    ay = y;
    float va = 0.1;
    ang += random(-va, va);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
    if (x > width+tam) {
      init();
    }
  }
  void show() {
    float dx, dy;
    noStroke();
    fill(col);
    beginShape();
    dx = cos(ang+PI/2)*tam*0.5;
    dy = sin(ang+PI/2)*tam*0.5;
    vertex(x-dx, y-dy);
    vertex(x+dx, y+dy);
    dx = cos(aa+PI/2)*tam*0.5;
    dy = sin(aa+PI/2)*tam*0.5;
    vertex(ax+dx, ay+dy);
    vertex(ax-dx, ay-dy);
    endShape(CLOSE);
    stroke(0);
    dx = cos(ang+PI/2)*tam*0.5;
    dy = sin(ang+PI/2)*tam*0.5;
    line(x-dx, y-dy, x+dx, y+dy);
    dx = cos(aa+PI/2)*tam*0.5;
    dy = sin(aa+PI/2)*tam*0.5;
    line(ax-dx, ay-dy, ax+dx, ay+dy);
    //line(x-dx, y-dy, x+dx, y+dy);
  }
}

