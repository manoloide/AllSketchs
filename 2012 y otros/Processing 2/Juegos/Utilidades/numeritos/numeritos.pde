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
  float x, y, tam, time, ang;
  int val;
  Numerito(float nx, float ny, float nv) {
    x = nx;
    y = ny;
    val = int(nv);
    time = 1;
    ang = 0;
  }
  void act() {
    time -= 0.02;
    mover();
    draw();
  }
  void mover() {
    ang += TWO_PI/30;
    x += sin(ang) * 0.5;
    y -= 0.5;
  }
  void draw() {
    text(val, x, y);
  }
}

