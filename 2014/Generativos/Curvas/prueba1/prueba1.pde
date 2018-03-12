Paleta paleta;

void setup() {
  size(600, 800);
  smooth(8);
  noFill();
  paleta = new Paleta(#D4FAF3, #33A691, #2D3A52, #B31750, #FF3F21);
  //paleta = new Paleta(#765664, #EC7D88, #F4EC84, #62B681, #ECB973);
  //paleta = new Paleta(#121106, #C98434, #94D173, #5BF0E1, #4BAD86); 
  generar();
}  
void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
  }
  else {
    thread("generar");
  }
}
void generar() {
  background(paleta.rcol());
  int cc = int(random(10, 40));
  for (int j = 0; j < cc; j++) {
    if (random(10) < 1) {
      noStroke();
      fill(paleta.rcol());
      float xc = random(width);
      float yc = random(height);
      float tc = random(40, 200);
      ellipse(xc, yc, tc, tc);
    }
    noFill();
    strokeWeight(int(random(1.5, 3)));
    float alp = 255;//random(100, 240);
    float x = random(width);
    float y = random(height);
    float dist = random(40, 200);
    float ang = random(TWO_PI);
    float x1 = x+cos(ang)*dist;
    float y1 = y+sin(ang)*dist;
    ang = random(TWO_PI);
    float x2 = x+cos(ang)*dist;
    float y2 = y+sin(ang)*dist;
    ang = random(TWO_PI);
    float x3 = x+cos(ang)*dist;
    float y3 = y+sin(ang)*dist;
    ang = random(TWO_PI);
    float x4 = x+cos(ang)*dist;
    float y4 = y+sin(ang)*dist;
    ang = random(TWO_PI);
    dist = random(2, 6)*random(2);
    int cant = int(random(80, 180));
    int tipo = int(random(2));
    stroke(paleta.get(int(random(paleta.colores.length))), alp);
    for (int i = 0; i < cant; i++) {
      if (tipo != 0) {
        stroke(paleta.get(i%paleta.colores.length), alp);
      }
      float dx = cos(ang)*i*dist;
      float dy = sin(ang)*i*dist;
      bezier(x1+dx, y1+dy, x2+dx, y2+dy, x3+dx, y3+dy, x4+dx, y4+dy);
    }
  }
}

class Paleta {
  color colores[];
  Paleta() {
  }
  Paleta(color... colores) {
    this.colores = colores;
  }
  void agregar(color c) {
    if (colores == null) {
      colores = new color[1]; 
      colores[0] = c;
    }
    int l = colores.length;
    colores = expand(colores, l+1);
    colores[l] = c;
  }
  color get(int i) {
    return colores[i];
  }
  color rcol() {
    int r = int(random(colores.length));
    return colores[r];
  }
}
