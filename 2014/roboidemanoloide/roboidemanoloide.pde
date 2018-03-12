ArrayList<Punto> puntos;
color paleta[];

int cant = 6;

void setup() {
  size(600, 600);
  smooth(8);
  puntos = new ArrayList<Punto>();
  paleta = new color[6];
  paleta[0] = color(#7B5498);
  paleta[1] = color(#BB7AC2);
  paleta[2] = color(#30B19F);
  paleta[3] = color(#AFD275);
  paleta[4] = color(#F5774B);
  float da = TWO_PI/cant;
  for (int i = 0; i < cant; i++) {
    puntos.add(new Punto(width/2-cos(da*i)*280, height/2-sin(da*i)*280));
  }
}

void draw() {
  background(255);
  noStroke();
  for (int i = 0; i < puntos.size(); i++) {
    Punto aux = puntos.get(i);
    aux.x += random(-0.5,0.5);
    aux.y += random(-0.5,0.5);
  }
  for (int i = cant; i < puntos.size(); i++) {
    Punto aux = puntos.get(i);
    for (int j = 0; j < cant; j++) {
      Punto p1 = puntos.get(j);
      Punto p2 = puntos.get((j+1)%cant);
      int n = int(aux.x + aux.y + p1.x + p1.y + p2.x + p2.y);
      fill(paleta[n%5], (n%256)*0.85);
      beginShape();
      vertex(aux.x, aux.y);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      endShape(CLOSE);
    }
  }
}

void mousePressed() {
  puntos.add(new Punto(mouseX, mouseY));
}

class Punto {
  boolean eliminar;
  float x, y;
  Punto(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}
