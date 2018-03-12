Paleta paleta;

void setup() {
  size(800, 600);
  paleta = new Paleta("Quick color sketch49", #4F525F, #FB5772, #FFBF26, #B0E420, #A4E4BF);
  //paleta = new Paleta(#F72828, #EA112A);
  background(paleta.rcol());
  thread("generar");
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
  for (int i = 0; i < 10; i++) {
    int w = width;//int(random(100, 500));
    int h = int(random(w/10, w/1.5));
    int tam = int(random(1, 20))*10; 
    int x = 0;//int(random(-tam, width));
    int y = int(random(-tam, height));
    float cant = random(1, 10);
    //rectDe(x, y, tam, tam, paleta.get(0), paleta.get(1));
    ola(x, y, w, h, cant, color(paleta.rcol(), 200), color(paleta.rcol(), 20), color(paleta.rcol()));
  }
}

void rectDe(int x, int y, int w, int h, color c1, color c2) {
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      color col = lerpColor(c1, c2, map(j, 0, h, 0, 1));
      fill(col, 20);
      point(x+i, y+j);
    }
  }
}

void ola(int x, int y, int w, int h, float cant, color c1, color c2, color c3) {
  float da = (TWO_PI*cant)/w; 
  for (int i = 0; i < w; i++) {
    float hh = h/4*3+cos(da*i)*(h/4);
    for (float j = -hh/2; j <= hh/2;  j++) {
      color col;
      float val = map(abs(j), 0, hh/2, 0, 1);
      if (val < 0.3) {
        col = lerpColor(c1, c2, map(val, 0, 0.3, 0, 1));
      }else{
        col = lerpColor(c2, c3, map(val, 0.3, 1, 0, 1));
      }
      stroke(col);
      point(x+i, y+j);
    }
    stroke(c3,map((-hh/2)%1, 0, -1, 0, 255));
    point(int(x+i), int(y+(-hh/2))-1);
    point(int(x+i), int(y+(hh/2)));
  }
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
