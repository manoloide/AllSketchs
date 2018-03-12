ArrayList<Numerito> numericos;

void setup() {
  size(400, 400);
  numericos = new ArrayList<Numerito>();
}

void draw() {
  background(0);
  for (int i = 0; i < numericos.size(); i++) {
    Numerito aux = numericos.get(i);
    aux.act();
    if (aux.time <= 0) {
      numericos.remove(i);
      i--;
    }
  }
}

void mousePressed() {
  numericos.add(new Numerito(mouseX, mouseY, random(10)));
}

class Numerito {
  float x, y, xx, yy, zz, za, tam;
 int time; 
  double xa, ya;
  int val;
  Numerito(float nx, float ny, float nv) {
    x = nx;
    y = ny;
    xx = nx;
    yy = ny;
    zz = 10;
    val = int(nv);
    time = 600;
    xa = random(-1,1);
    ya = random(1);
    za = random(1);
  }
  void act() {
    time --;
    mover();
    draw();
  }
  void mover() {
    xx += xa;
    yy += ya;
    zz += za;
    if (zz < 0) {
      zz = 0;
      za *= -0.5;
      xa *= 0.6;
      ya *= 0.6;
    }
    za -= 0.1;
    x = xx;
    y = yy;
  }
  void draw() {
    text(val, x, y-zz+1);
  }
}

