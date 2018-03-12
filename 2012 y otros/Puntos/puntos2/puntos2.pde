ArrayList puntos;
int maxima = 100;
int cantida = 5;

void setup() {
  size(600, 600);
  puntos = new ArrayList();
  stroke(255,20);
}
void draw() {
  background(0);
  for (int j = 0; j < puntos.size();j++) {
    Punto aux = (Punto) puntos.get(j);
    for (int i = j+1; i < puntos.size();i++) {
      Punto aux2 = (Punto) puntos.get(i);
      float dis = dist(aux.x,aux.y,aux2.x,aux2.y);
      if (dis < maxima){
         line(aux.x,aux.y,aux2.x,aux2.y); 
      }
    }
  }
}

void mousePressed() {
  puntos.add(new Punto(mouseX, mouseY));
}
class Punto {
  float x, y;
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
}

