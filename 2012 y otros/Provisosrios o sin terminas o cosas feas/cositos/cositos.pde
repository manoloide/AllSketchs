ArrayList todo = new ArrayList();
cosita c;

void setup() {
  size(400, 400);
  c = new cosita(width/2, height/2);
  todo.add(c);
}

void draw() {
  c.act();
}

class cosita {
  ArrayList hijos = new ArrayList();
  float x, y, tam = 10;

  cosita(float nx, float ny) {
    x = nx;
    y = ny;
  }

  void act() {
    for (int i = 0; i < hijos.size(); i++) {
      cosita aux = (cosita) hijos.get(i);
      line(x, y, aux.x, aux.y);
      aux.act();
    }
    dibujar();
  }

  void dibujar() {
    ellipse(x, y, tam, tam);
  }
}


void mousePressed() {
  for (int c = 0; c < todo.size(); c++) {
    cosita papa = (cosita) todo.get(c);
    if (dist(mouseX, mouseY, papa.x, papa.y) < papa.tam && papa.hijos.size() == 0) {
      int v = int(random(1, 2));
      for (int i = 0; i < v; i++) {
        float ang = random(2*PI);
        float x = papa.x + cos(ang) * papa.tam *2;
        float y = papa.y + sin(ang) * papa.tam *2;
        cosita aux = new cosita(x, y);
        todo.add(aux);
        papa.hijos.add(aux);
      }
    }
  }
}

