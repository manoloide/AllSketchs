Paleta paleta;
PFont helve;
PGraphics aux;
String[] palabras = {
  "trash", "amor", "hola", "viejo", "modern", "happy"
};

void setup() {
  size(600, 800);
  paleta = new Paleta(#5624C3, #F62021, #FEC225, #0E02FD, #12E4EF);
  helve = createFont("Helvetica Bold", 100, true);
  aux = createGraphics(width, height);
  thread("generar");
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("######");
  } 
  else {
    thread("generar");
  }
}

void generar() {
  //background(paleta.rcol());
  background(0);
  noStroke();
  for (int i = 0; i < 8; i++) {
    grilla(0, 0, width, height, random(3, 20));
  }
  stroke(paleta.rcol());
  int cant = int(random(1, 50));
  float dd = random(10, 50);
  float gro = random(10, 20);
  for (int i = 0; i < cant; i++) {
    linea(-10, i*dd, i*dd, -10, gro, paleta.rcol(), paleta.rcol());
  }
  aux.beginDraw();
  aux.background(255);
  aux.textAlign(LEFT, TOP);
  aux.textFont(helve);
  aux.fill(0);
  int c = int(random(1, 5));
  for (int i = 0; i < c; i++) {
    String txt = palabras[int(random(palabras.length))];
    aux.text(txt, 80, 60+i*100);
  }
  aux.endDraw();
  fill(paleta.rcol(), 120);
  for (int i = 0; i < 200000; i++) {
    float x = random(width);
    float y = random(height);
    float tam = random(1, 8);
    float ang = random(TWO_PI);
    if (aux.get(int(x), int(y)) == color(0)) {
      forma(x, y, tam, 3, ang);
    }
  }
}

void linea(float x1, float y1, float x2, float y2, float gro, color c1, color c2) {
  stroke(c1);
  strokeWeight(gro);
  line(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float dist = dist(x1, y1, x2, y2);
  float dd = gro/(sqrt(3)/2);
  float tam = gro;
  noStroke();
  fill(c2);
  for (int i = 0; i < dist; i+=dd) {
    forma(x1+cos(ang)*i, y1+sin(ang)*i, tam, 3, ang+PI/2);
  }
}

void grilla(float x, float y, float w, float h, float tam) {
  float dw = sqrt(3)*tam/2;
  float dh = sqrt(3)/2*dw;
  float dx = x+random(-dw, 0);
  float dy = y+random(-dh, 0);
  for (float j = dy; j < y+h+dh; j+=dh) {
    for (float i = dx; i < x+w+dw; i+=dw) {
      fill(paleta.rcol());
      forma(i, j, tam, 3, PI/2*3);
    }
  }
}

void forma(float x, float y, float dim, int cant, float ang) {
  float r = dim/2;
  float da = TWO_PI/cant;
  beginShape();
  for (int i = 0; i < cant; i++) {
    vertex(x+cos(da*i+ang)*r, y+sin(da*i+ang)*r);
  }
  endShape(CLOSE);
}

class Paleta {
  color colores[];
  String nombre;
  Paleta() {
    this.nombre = "";
    colores = null;
  }
  Paleta(color... colores) {
    this.nombre = ""; 
    this.colores = colores;
  }
  Paleta(String nombre) {
    this.nombre = nombre;
    colores = null;
  }
  Paleta(String nombre, color... colores) {
    this.nombre = nombre; 
    this.colores = colores;
  }
  void agregar(color c) {
    if (colores == null) {
      colores = new color[1]; 
      colores[0] = c;
    }
    else {
      int l = colores.length;
      colores = expand(colores, l+1);
      colores[l] = c;
    }
  }
  color get(int i) {
    return colores[i];
  }
  color rcol() {
    int r = int(random(colores.length));
    return colores[r];
  }
  void eliminar(int c) {
    int l = colores.length;
    color aux[] = new color[l-1];
    for (int i = 0; i < l; i++) {
      if (i < c) aux[i] = colores[i]; 
      if (i > c) aux[i-1] = colores[i];
    }
    colores = aux;
  }
}
