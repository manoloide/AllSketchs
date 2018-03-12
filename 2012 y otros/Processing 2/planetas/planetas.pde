ArrayList<Planeta> planetas;
ArrayList<Entidad> seleccion;

void setup() {
  size(800, 600);
  iniciar();
}

void draw() {
  background(0);
  for (int i = 0; i < planetas.size(); i++) {
    planetas.get(i).act();
  }
  gui();
}

void mousePressed() {
  if (mouseX < 600) {
    for (int i = 0; i < seleccion.size(); i++) {
      seleccion.get(i).seleccionado = false;
    }
    seleccion = new ArrayList();
    for (int i = planetas.size()-1; i >= 0; i--) {
      Planeta aux = planetas.get(i);
      if (aux.seleccionar()) {
        seleccion.add(aux);
        aux.seleccionado = true;
        break;
      }
    }
  }
}

void iniciar() {
  planetas = new ArrayList();
  seleccion = new ArrayList();
  for (int i = 0; i < 10; i++) {
    planetas.add(new Planeta(random(width-200-120)+120, random(height-120)+120));
  }
}
void gui() {
  noStroke();
  fill(80);
  rect(600, 0, 200, height);
}

class Entidad {
  boolean seleccionado = false;
  boolean seleccionar() {
    return false;
  }
}

class Planeta extends Entidad {
  color col;
  float x, y, tam;
  Planeta(float x, float y) {
    this.x = x;
    this.y = y;
    tam = int(random(40, 120));
    col = color(random(256), random(256), random(256));
  }
  void act() {
    draw();
  }
  void draw() {
    fill(col);
    if (seleccionado) {
      strokeWeight(2);
      stroke(0, 255, 0);
    }
    else {
      strokeWeight(1);
      stroke(0);
    }

    ellipse(x, y, tam, tam);
  }

  boolean seleccionar() {
    if (dist(mouseX, mouseY, x, y)<tam/2) {
      return true;
    }
    else {
      return false;
    }
  }
}

