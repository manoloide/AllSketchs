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
  noFill();
  stroke(234);
  strokeWeight(8);
  corazon(width/2, height/2, 400);
  /*
  for (int i = 0; i < cargadores.size(); i++) {
   Cargador c = cargadores.get(i);
   c.act();
   }
   */
}

void keyPressed() {
  if (key == 's') {
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

void corazon(float x, float y, float tam) {
  beginShape();
  bezier(x+0, 0, -25, x-90, -150, x-70, -150, 25);
  bezier(x-150, 25, x-150, 120, -50, 126, 0, 250);
  endShape();
  /*
  float d = tam/2;
  arc(x, y, d, d, TWO_PI/4, TWO_PI);
  arc(x+d, y, d, d, TWO_PI/2, TWO_PI+PI/2);
  arc(x, y+d*1.1, d, d*1.2, PI*3/2, TWO_PI);
  arc(x+d, y+d, d, d, PI, PI*3/2);
  //arc(100,100, 50, 50, TWO_PI/1, TWO_PI/1);
  */
}
