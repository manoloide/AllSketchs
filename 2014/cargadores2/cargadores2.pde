ArrayList<Arco> arcos;

void setup() {
  size(600, 600);
  arcos = new ArrayList<Arco>();
  for (int i = 0; i < 20; i++) {
    arcos.add(new Arco(width/2, height/2, 20+40*i, int(random(4, 20))));
  }
}
void draw() {
  background(40);
  for (int i = 0; i < arcos.size(); i++) {
    Arco aux = arcos.get(i);
    aux.act();
  }
}

class Arco {
  boolean eliminar;
  float x, y, d, r, da, ang, time;
  int cant;
  Arco(float x, float y, float d, int cant) {
    this.x = x; 
    this.y = y; 
    this.d = d;
    this.cant = cant;
    r = d/2;
    da = TWO_PI/cant;
    time = random(40, 200);
  }
  void act() {
    ang = TWO_PI*(frameCount%time)/time;
    dibujar();
  }
  void dibujar() {
    noFill();
    stroke(200);
    for (int i = 0; i < cant; i++) {
      strokeWeight(i*0.2);
      arc(x, y, r, r, da*i+ang, da*(i+1)+ang);
    }
  }
}
