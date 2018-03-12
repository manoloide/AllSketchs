ArrayList<Circulo> circulos;

void setup() {
  size(800, 600);
  colorMode(HSB, 256);
  noStroke();
  circulos = new ArrayList<Circulo>();
  //circulos.add(new Circulo(width/2,height/2,30,height));
  for (int j = 0; j < 6; j++) {
    for (int i = 0; i < 8; i++) {
      circulos.add(new Circulo(62+i*95, 65+j*95, 10, 10));
    }
  }
}

void draw() {
  background(#171535);
  //Circulo uno = circulos.get(0);
  //uno.x += (mouseX-uno.x)/3.5;
  //uno.y += (mouseY-uno.y)/3.5;
  for (int i = 0; i < circulos.size(); i++) {
    Circulo aux = circulos.get(i);
    aux.act();
    aux.dim += random(0.01,0.05);
  }
  saveFrame("#####");
  if (frameCount == 60*120) {

    //delay(2000);
    exit();
  }
}


class Circulo {
  ArrayList<Arco> arcos;
  float x, y, dim; 
  int cant;
  Circulo(float x, float y, int cant, float dim) {
    this.x = x; 
    this.y = y;
    this.cant = cant;
    this.dim = dim;
    arcos = new ArrayList<Arco>();
    for (int i = 0; i < cant; i++) {
      arcos.add(new Arco(this, x, y, dim));
    }
  }
  void act() {
    for (int i = 0; i < arcos.size(); i++) {
      Arco aux = arcos.get(i);
      aux.act();
      aux.dim = dim;
    }
  }
}

class Arco {
  Circulo c;
  color ocol, col;
  float x, y, tam, ang1, ang2, dim;
  float otam, oang1, oang2, odim, objetivo;
  int tiempo;
  Arco(Circulo c, float x, float y, float dim) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.dim = dim;
    tiempo = int(random(400));
    tam = random(dim*0.08, dim);
    ang1 = random(TWO_PI);
    ang2 = random(TWO_PI);
    col = color(random(255), random(180, 255), random(240, 255), 256-(random(1)*random(256)));
  }
  void act() {
    tiempo--;
    if (tiempo <= 0) cambiar();
    objetivo -= random(0.01, 0.05);
    if (objetivo <= 0) {
      tam = otam;
      ang1 = oang1;
      ang2 = oang2;
      col = ocol;
    }
    dibujar();
  }
  void dibujar() {
    //println(x, y, tam, tam, ang1, ang2);
    if (objetivo <= 0) {
      fill(col);
      arc(c.x, c.y, tam, tam, ang1, ang2);
    }
    else {
      fill(lerpColor(ocol, col, objetivo));
      float atam = map(objetivo, 0, 1, otam, tam);
      float aang1 = map(objetivo, 0, 1, oang1, ang1);
      float aang2 = map(objetivo, 0, 1, oang2, ang2);
      arc(c.x, c.y, atam, atam, aang1, aang2);
    }
  }
  void cambiar() {
    otam = random(dim*0.08, dim);
    oang1 = random(TWO_PI)+TWO_PI;
    oang2 = random(TWO_PI)+TWO_PI;
    if (oang1 > oang2) {
      oang2 += TWO_PI;
    }
    ocol = color(random(255), random(180, 255), random(240, 255), 256-(random(1)*random(256)));
    tiempo = int(random(60, 600));
    objetivo = 1;
  }
}
