ArrayList<Forma> formas;
Input input;

void setup() {
  size(800, 600);
  input = new Input();
  formas = new ArrayList<Forma> ();
  Forma f = new Forma();
  for (int i = 0; i < 6; i++) {
    f.agregar(new Punto(width/2+cos(TWO_PI/6*i)*100, height/2+sin(TWO_PI/6*i)*100));
  }
  formas.add(f);
}  

void draw() {
  background(200);
  for (int i = 0; i < formas.size(); i++) {
    Forma aux = formas.get(i);
    aux.act();
    if (aux.eliminar) formas.remove(i--);
  }
  input.act();
}
void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}

void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

class NodoF {
  boolean eliminar;
  float val;
  int pos;
  NodoF(int pos, float val) {
    this.pos = pos;
    this.val = val;
  }
}

class AutoF {
  ArrayList<NodoF> nodos;
  AutoF() {
    nodos = new ArrayList<NodoF>();
  }
  AutoF(NodoF n) {
    nodos = new ArrayList<NodoF>();
    agregar(n);
  }
  AutoF(float v) {
    nodos = new ArrayList<NodoF>();
    nodos.add(new NodoF(0, v));
  }
  void agregar(NodoF n) {
    nodos.add(n);
  }
  float getVal(){
     return nodos.get(0).val; 
  }
}

class Punto {
  boolean eliminar;
  AutoF x, y;
  Punto(float x, float y) {
    this.x = new AutoF(x); 
    this.y = new AutoF(y);
  }
}

class Forma {
  ArrayList<Punto> puntos;
  boolean eliminar;
  float x, y;
  String nombre;
  Forma() {
    puntos = new ArrayList<Punto>();
  }
  void agregar(Punto p) {
    puntos.add(p);
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    beginShape();
    for (int i = 0; i < puntos.size(); i++) {
      Punto aux = puntos.get(i);
      vertex(aux.x.getVal(), aux.y.getVal());
    }
    endShape(CLOSE);
  }
}
