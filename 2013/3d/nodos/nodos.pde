ArrayList<Nodo> nodos; 
Nodo nsel;
void setup() {
  size(800, 600, P3D);
  nodos = new ArrayList<Nodo>();
  nsel = new Nodo(1000, 1000, 0);
  nodos.add(nsel);
  background(0);
}

void draw() {
  translate(-nsel.x, -nsel.y, nsel.z-200);
  //translate(-mouseX,-mouseY);
  //rotateX(((frameCount*1.%356)/356)*TWO_PI);
  //rotateY(((frameCount*1.%356)/356)*TWO_PI);
  //rotateZ(((frameCount%356)/356)*TWO_PI);
  background(0);
  for (int i = 0; i < nodos.size(); i++) {
    Nodo n = nodos.get(i);
    n.act();
  }
}

void mousePressed() {
  Nodo aux = new Nodo(nsel.x+random(200, 500), nsel.y+random(200, 500), nsel.z+random(200, 500));
  nsel.vecinos.add(aux);
  nsel = aux;
  nodos.add(nsel);
}

class Nodo {
  ArrayList<Nodo> vecinos;
  float x, y, z, tam;
  Nodo(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    vecinos = new ArrayList<Nodo>();
    tam = 80;
  }
  void act() {
    dibujar();
  }

  void dibujar() {
    stroke(255);
    for (int i = 0; i < vecinos.size(); i++) {
      Nodo a = vecinos.get(i);
      line(a.x, a.y, a.z, x, y, z);
    }
    noStroke();
    pushMatrix();
    translate(x, y, z);
    sphere(tam);
    popMatrix();
  }
}

