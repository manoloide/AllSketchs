Paleta paleta;

void setup() {
  size(600, 600);
  colorMode(HSB, 256);
  paleta = new Paleta(#9CAE84, #DE4F3A, #6F756A, #E4B302);
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
  /*
  float h = random(255);
  colorMode(HSB, 255);
  Paleta paleta = new Paleta();
  color col = #9CAE84;
  col = color((hue(col)+h)%256, saturation(col), brightness(col));
  paleta.agregar(col);
  col = #DE4F3A;
  col = color((hue(col)+h)%256, saturation(col), brightness(col));
  paleta.agregar(col);
  col = #6F756A;
  col = color((hue(col)+h)%256, saturation(col), brightness(col));
  paleta.agregar(col);
  col = #E4B302;
  col = color((hue(col)+h)%256, saturation(col), brightness(col));
  paleta.agregar(col);
  */
  noStroke();
  fill(paleta.rcol());
  rect(0, 0, width/2, height/2);
  fill(paleta.rcol());
  rect(0, height/2, width/2, height/2);
  fill(paleta.rcol());
  rect(width/2, 0, width/2, height/2);
  fill(paleta.rcol());
  rect(width/2, height/2, width/2, height/2);
  int cant = 22;//int(random(8, 16))*2;
  float dd = width*1./cant;
  for (int j = 0; j < dd; j++) {
    for (int i = 0; i < dd; i++) {
      float x = i*dd+dd/2;
      float y = j*dd+dd/2;
      if (dist(x, y, width/2, height/2) < (width/2)*0.8) {
        fill(paleta.rcol());
        ellipse(x, y, dd*0.8, dd*0.8);
        float ang = random(TWO_PI);
        fill(paleta.rcol());
        arc(x, y, dd*0.6, dd*0.6, ang, ang+random(TWO_PI));
      }
    }
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
