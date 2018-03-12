import cello.tablet.*;

JTablet jtablet = null;

void setup() {
  size(640, 480);
  frame.setResizable(true);
  try {
    jtablet = new JTablet();
  } 
  catch (JTabletException jte) {
    println("Could not load JTablet! (" + jte.toString() + ").");
  }
  smooth();
}

void draw() {
  try {
    // Get latest tablet information
    jtablet.poll();
  } 
  catch (JTabletException jte) {
    println("JTablet Error: " + jte.toString());
  }

  ellipseMode(CENTER);  

  if (mousePressed && jtablet.hasCursor()) {
    // Get the current cursor
    JTabletCursor cursor = jtablet.getCursor();
    stroke(0);
    strokeWeight(cursor.getPressureFloat() * 20);
    line(mouseX, mouseY, pmouseX, pmouseY);
    fill(255);
    noStroke();
    ellipse(pmouseX, pmouseY, 2, 2);
  }
}

void mousePressed(){
  
}

void mouseReleased(){
  
}

class Nodo {
  float x, y, tam; 
  Nodo(float x, float y, float tam) {
    this.x = x; 
    this.y = y;
    this.tam = tam;
  }
}

class Trazo {
  ArrayList<Nodo> nodos;
  Trazo() {
    nodos = new ArrayList<Nodo>();
  }
  void Agregar(Nodo n) {
    nodos.add(n);
  }
  void Suavizar() {
    for (int i = 1; i < nodos.size()-1; i++) {
      Nodo ant = nodos.get(i-1);
      Nodo aux = nodos.get(i);
      Nodo sig = nodo.get(i+1);
    }
  }
}

