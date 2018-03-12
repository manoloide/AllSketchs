ArrayList puntos, cubos;

void setup() {
  size(400, 400);
  background(0);
  colorMode(HSB, 100);
  noStroke();
  puntos = new ArrayList();
  cubos = new ArrayList();

  for (int i = 0; i < height/20; i++) {
    for (int j = 0; j < width/20; j++) {
      cubos.add(new cubo(i*20,j*20,20));
    }
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < cubos.size(); i++) {
    
    cubo aux = (cubo) cubos.get(i);
    aux.act();
    if (!aux.vivo) {
      cubos.remove(i);
      i--;
    }
  }

  for (int i = 0; i < puntos.size(); i++) {
    punto aux = (punto) puntos.get(i);
    aux.act();
    if (aux.vida == 0) {
      puntos.remove(i);
      i--;
    }
  }
}

class cubo {
  float x, y, tam;
  color c;
  boolean vivo;

  cubo(float nx, float ny, float nt) {
    x = nx;
    y = ny;
    tam = nt;
    c = color(random(100), 100, 100);
    vivo = true;
  }

  void act() {

    if (vivo) {
      if (mousePressed) {
        if (mouseX >= x && mouseX <= x+tam) {
          if (mouseY >= y && mouseY <= y+tam) {
            vivo = false;
            crearP();
          }
        }
      }
      draw();
    }
  }

  void draw() {
    fill(c);
    rect(x, y, tam, tam);
  }

  void crearP() {
    for (int i = 0; i < tam; i++) {
      for (int j = 0; j < tam; j++) {
        puntos.add(new punto(x+j, y+i, mouseX, mouseY, c));
      }
    }
  }
}

class punto {
  float x, y, mx, my, vida;
  color c;

  punto(float nx, float ny, float xm, float ym, color nc) {
    x = nx;
    y = ny;
    c = nc;
    vida = 100;

    float ang = atan2(y-ym, x-xm);
    mx = cos(ang);
    my = sin(ang);
  }

  void act() {
    x += mx;
    y += my;
    vida--;
    draw();
  }

  void draw() {
    fill(c, vida);
    rect(x, y, 1, 1);
  }
}

