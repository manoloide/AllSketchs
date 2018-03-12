ArrayList<Circulo> circulos;

void setup() {
  size(600, 600);
  circulos = new ArrayList<Circulo>();
}

void draw() {
  background(40);
  boolean agregar = false;
  float tam = width/3;
  while (!agregar && tam >= 8 && frameCount%4 == 0) {
    Circulo aux = new Circulo(random(width), random(height), tam);
    agregar = true;
    for (int i = 0; i < circulos.size(); i++) {
      Circulo com = circulos.get(i);
      if (dist(com.x, com.y, aux.x, aux.y) < (aux.tam+com.tam)/2) {
        agregar = false;
        break;
      }
    }
    if (agregar) {
      circulos.add(aux);
    }
    tam *= 0.95;
  }
  for (int i = 0; i < circulos.size(); i++) {
    Circulo aux = circulos.get(i);
    aux.dibujar();
    if (aux.eliminar) {
      //circulos.remove(i--);
    }
  }
}

class Circulo {
  boolean eliminar, explotar;
  color col;
  float x, y, tam;
  Circulo(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    int r = int(random(3));
    switch(r) {
    case 0:
      col = color(random(180, 256), random(120), random(120));
      break;
    case 1:
      col = color(random(120), random(180, 256), random(120));
      break;
    case 2:
      col = color(random(120), random(120), random(80, 256));
      break;
    }
  }
  void dibujar() {
    noStroke();
    fill(240);
    ellipse(x, y, tam, tam);
    float ang = atan2(mouseY-y, mouseX-x);
    float dis = dist(mouseX, mouseY, x, y);
    if (dis < tam/2) eliminar = true;
    if (dis > tam/3) dis = tam/3;
    dis /= tam/3;
    fill(col);
    ellipse(x+cos(ang)*tam/3*dis, y+sin(ang)*tam/3*dis, tam*0.3, tam*0.3);
    fill(20);
    ellipse(x+cos(ang)*tam/3*dis, y+sin(ang)*tam/3*dis, tam*0.2, tam*0.2);
  }
}
