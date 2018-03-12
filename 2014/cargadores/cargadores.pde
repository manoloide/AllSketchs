ArrayList<Cargador> cargadores;

void setup() {
  size(800, 600);
  cargadores = new ArrayList<Cargador>();
  for (int j = 0; j < 5; j++) {
    for (int i = 0; i < 7; i++) {
      Cargador c = new Cargador(100+i*100, 100+j*100, 10, 70);
      c.ace = random(0.001, 0.01);
      cargadores.add(c);
    }
  }
}

void draw() {
  background(30);
  for (int i = 0; i < cargadores.size(); i++) {
    Cargador c = cargadores.get(i);
    c.act();
  }
}

void keyPressed(){
   if(key == 's'){
      saveFrame("######");
   } 
}

class Cargador {
  float x, y, anc, dim, val, ang, ace, vel, rot;
  Cargador(float x, float y, float anc, float dim) {
    this.x = x;
    this.y = y;
    this.anc = anc;
    this.dim = dim;
    ang = PI/2;
    rot = PI;
    ace = 0.01;
  }
  void act() {
    val += ace;
    rot += TWO_PI/(3*ace);
    if (val >= 1 || val <= 0) ace *= -1;
    dibujar();
  }

  void dibujar() {
    noFill();
    strokeWeight(anc);
    float ori = PI+ang+rot;
    float da = map(val, 0, 1, 0, PI);
    strokeCap(SQUARE);
    stroke(map(val, 0, 1, 90, 40));
    arc(x, y, dim, dim, ori-da, ori+da);
    stroke(map(val, 1, 0, 90, 40));
    ori = ang+rot;
    da = map(val, 1, 0, 0, PI);
    arc(x, y, dim, dim, ori-da, ori+da);
    //fill(map(val, 0, 1, 80, 100));
    //arc(x, y, dim, dim, 0, TWO_PI);
  }
}
