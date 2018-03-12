ArrayList<Coso> cositos;
color c1, c2; 
void setup() {
  size(600, 400);
  cositos = new ArrayList<Coso>();
  for (int i = 0; i < 5; i++) {
    cositos.add(new Coso());
  }
  c1 = color(#DDE9B7);
  c2 = color(#55C66C);
  background(128);
}

void draw() {
  for (int j = 0; j < 500; j++) {
    for (int i = 0; i < cositos.size(); i++) {
      Coso aux = cositos.get(i);
      aux.act();
    }
  }
}
void keyPressed( ) {
  saveFrame("####");
}

class Coso {
  int x, y, t; 
  float val, inc;
  Coso() {
    iniciar();
  }
  void iniciar() {
    x = 0;
    y = y;
    val = random(256);
    inc = random(0.1, 0.2);
    t = int(random(1, 5));
  }
  void act() {
    y++;
    val += inc;
    inc *= 1.08;
    if (val >= 256) {
      val = random(256);
      inc = random(0.1, 0.2);
    }
    if (y > height) {
      y = 0; 
      x+= t;
      t = int(random(1, 5));
    }
    dibujar();
  }

  void dibujar() {
    color col, col1, col2;
    color c1w = lerpColor(#B4DBA2, #3C906E, map(x, 0, width, 0, 1));
    color c1h = lerpColor(#DDE9B7, #035048, map(y, 0, height, 0, 0.8));
    col1 = lerpColor(c1w, c1h, 0.5);
    color c2w = lerpColor(#46053F, #A40E4B, map(x, 0, width, 0, 1));
    color c2h = lerpColor(#FE3D4E, #FCA49A, map(y, 0, height, 0, 0.8));
    col2 = lerpColor(c2w, c2h, 0.5);
    noStroke();
    fill(lerpColor(col1, col2, val/256));
    rect(x, y, 4, 4);
  }
}
