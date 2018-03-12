import manoloide.Color.*;

final int borde_externo = 20;
final int borde_interno = 3;
final int cantidad_w = 16;
final int cantidad_h = 20;
final int tamano_matriz = 30;
final int pasadas_division = 2;

ArrayList<Zona> zonas;
Paleta paleta;

void setup() {
  size(borde_externo*2+cantidad_w*tamano_matriz+(cantidad_w-1)*borde_interno, borde_externo*2+cantidad_h*tamano_matriz+(cantidad_h-1)*borde_interno); 
  paleta = new Paleta(#765664, #EC7D88, #F4EC84, #62B681, #ECB973);
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
  background(paleta.rcol());
  zonas = new ArrayList<Zona>();
  zonas.add(new Zona(0, 0, cantidad_w, cantidad_h));
  //rect(borde_externo, borde_externo, width-borde_externo*2, height-borde_externo*2);
  for (int j = 0; j < cantidad_h; j++) {
    for (int i = 0; i < cantidad_w; i++) {
      rect(borde_externo+(tamano_matriz+borde_interno)*i, borde_externo+(tamano_matriz+borde_interno)*j, tamano_matriz, tamano_matriz);
    }
  }
  for (int j = 0; j < pasadas_division; j++) {
    for (int i = 0; i < zonas.size(); i++) {
      Zona aux = zonas.get(i);
      if (random(1) < 1-(1./pasadas_division)*i) {
        aux.dividir();
        if (aux.eliminar) zonas.remove(i);
      }
    }
  }
  noStroke();
  for (int i = 0; i < zonas.size(); i++) {
    Zona aux = zonas.get(i);
    aux.act();
    rect1(borde_externo+(tamano_matriz+borde_interno)*aux.x, borde_externo+(tamano_matriz+borde_interno)*aux.y, aux.w*(tamano_matriz+borde_interno)-borde_interno, aux.h*(tamano_matriz+borde_interno)-borde_interno, int(random(aux.h/2, aux.h/6)), paleta.rcol(), paleta.rcol());
  }
}

void rect1(int x, int y, int w, int h, int cant, color c1, color c2) {
  noStroke();
  if (w > h) {
    float tam = h*1./cant;
    for (int i = 0; i < cant; i++) {
      if (i%2 == 0) fill(c1);
      else fill(c2);
      rect(x, y+tam*i, w, tam);
    }
  }
  else {
    float tam = w*1./cant;
    for (int i = 0; i < cant; i++) {
      if (i%2 == 0) fill(c1);
      else fill(c2);
      rect(x+tam*i, y, tam, h);
    }
  }
}

class Zona {
  boolean eliminar;
  int x, y, w, h;
  Zona(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    eliminar = false;
  }
  void act() {
    dibujar();
  }

  void dibujar() {
    fill(paleta.rcol());
    int xx = borde_externo+(tamano_matriz+borde_interno)*x;
    int yy = borde_externo+(tamano_matriz+borde_interno)*y;
    int ww = (tamano_matriz+borde_interno)*w-borde_interno;
    int hh = (tamano_matriz+borde_interno)*h-borde_interno;
    rect(xx, yy, ww, hh);
  }
  boolean dividir() {
    boolean horizontal = false, vertical = false;
    if (w < 2 && h < 2) return false; 
    Zona z1, z2;
    if (w < 2) horizontal = true;
    if (h < 2) vertical = true;
    if (!vertical && !horizontal) {
      if (random(1) < 0.5) horizontal = true;
      else vertical = true;
    }
    if (horizontal) {
      int c = int(random(1, h));
      float a = map(c, 1, h, -1, 1);
      z1 = new Zona(x, y, w, c);
      z2 = new Zona(x, y+c, w, h-c);
    }
    else {
      int c = int(random(1, w));
      z1 = new Zona(x, y, c, h);
      z2 = new Zona(x+c, y, w-c, h);
    }
    zonas.add(z1);
    zonas.add(z2);
    eliminar = true;
    return true;
  }
}

/*

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
*/
