ArrayList<Particula> particulas;
PImage img; 

void setup() {
  img = loadImage("../thom.jpg");
  size(img.width/2, img.height/2);
}

void draw() {
  for (int i = 0; i < 2000; i++) {
    float x = random(width);
    float y = random(height);
    particulas = new ArrayList<Particula>();
    Particula aux = new Particula(x/2, y/2, img.get(int(x), int(y)));
    particulas.add(aux);
  }
  for(int i = 0; i < particulas.size(); i++){
    Particula aux = particulas.get(i);
    aux.act();
    
  }
}


class Particula {
  boolean eliminar;
  color col;
  float ix, iy, x, y, ang, tam, cre, tam_max, vel;
  Particula(float x, float y, color col) {
    ix = x;
    iy = y;
    this.x = x;
    this.y = y;
    this.col = col;
    ang = random(TWO_PI);
    tam = random(2);
    cre = random(1.05, 1.2);
    tam_max = random(2, 12);
    vel = random(0.01, 1);
    eliminar = false;
  }
  void act() {
    ang += random(-0.1, 0.1);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    if (cre >= 0)
      tam *= cre;
    else 
      tam -= 0.2;
    if (tam < 0) {
      eliminar = true;
    }
    if (tam > tam_max) {
      cre = -1;
    }
    dibujar();
  }
  void dibujar() {
    /*
    strokeWeight(0.5);
    stroke(100);
    line(ix, iy, x, y);
    */
    noStroke();
    fill(col);
    ellipse(x, y, tam, tam);
  }
}
