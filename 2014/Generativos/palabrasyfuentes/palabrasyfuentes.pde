Paleta paleta;
PFont mohave;

void setup() {
  size(600, 800);
  paleta = new Paleta("Quick color sketch49", #4F525F, #FB5772, #FFBF26, #B0E420, #A4E4BF);
  mohave = createFont("Mohave Bold", 108, true);
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
  int cant = int(random(500, 1000));
  for (int i = 0; i < cant; i++) {
    float x = random(width);
    float y = random(height);
    float t = random(20, 220);
    int c = int(random(3, 8));
    float ang = random(TWO_PI);
    float hun = random(0.5, 1);
    boolean estrella = (random(1) < 0.5)? false : true;
    noFill();
    for (int j = 0; j < 10 ; j++) {
      strokeWeight(j);
      stroke(0, 4);
      if (estrella) estrella(x, y, t, c, ang, hun);
      else forma(x, y, t, c, ang);
    }
    noStroke();
    fill(paleta.rcol());
    if (estrella) estrella(x, y, t, c, ang, hun);
    else forma(x, y, t, c, ang);
  }
  float tam = random(8, 20);
  float esp = random(tam*0.2, tam*0.5);
  int cc = int(random(-2, 40));
  strokeWeight(tam/2);
  stroke(paleta.rcol());
  for (int i = 0; i < cc; i++) {
    line(-10+(tam+esp)*i, -10, -10, -10+(tam+esp)*i);
  }
  color col = paleta.rcol();
  colorMode(HSB);
  fill(hue(col), 50, 300);
  colorMode(RGB);
  textAlign(LEFT,TOP);
  textFont(mohave);
  text("MOHAVE", 20, 20);
}

void forma(float x, float y, float d, int c, float ang) {
  float r = d/2;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    vertex(x+cos(da*i+ang)*r, y+sin(da*i+ang)*r);
  }
  endShape(CLOSE);
}

void estrella(float x, float y, float d, int c, float ang, float hun) {
  float r = d/2;
  float da = TWO_PI/c;
  beginShape();
  for (float i = 0; i < c; i+=0.5) {
    if (i%1 == 0)
      vertex(x+cos(da*i+ang)*r, y+sin(da*i+ang)*r);
    else 
      vertex(x+cos(da*i+ang)*r*hun, y+sin(da*i+ang)*r*hun);
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
