class Gui {
  boolean visible;
  ArrayList<Elemento> elementos;
  ArrayList<Pestana> pestanas;
  float px, py, w, h;
  String titulo; 
  Gui(String titulo) {
    this.titulo = titulo;
    visible = true;
    elementos = new ArrayList<Elemento>();
    pestanas = new ArrayList<Pestana>();
    px = py = w = h = 20;
  }
  void act() {
    if (visible) {
      if (input.click && getValor("Esconder menu") == 1 && ((mouseX < px || mouseX > px+w) ||(mouseY < py || mouseY > py+h))) {
        visible = false;
      } 
      float dh = 30;
      for (int i = 0; i < pestanas.size(); i++) {
        Pestana  aux = pestanas.get(i);
        aux.act(px, py+dh);
        if (aux.eliminar) {
          elementos.remove(i);
        }
        dh += aux.h;
      }
      dibujar();
    }
  }
  void dibujar() {
    noStroke();
    fill(80);
    rect(px, py, w, h);
    fill(20);
    rect(px, py, w, 30);
    fill(255);
    textSize(16);
    text(titulo, px+8, py+22);
    textSize(12);
    float dh = 30;
    for (int i = 0; i < pestanas.size(); i++) {
      Pestana aux = pestanas.get(i);
      aux.dibujar(px, py+dh);
      dh += aux.h;
    }
  }
  void agregarPestana(Pestana pes) {
    pestanas.add(pes);
    pes.gui = this;
    actTamano();
  }
  void agregarElemento(Elemento ele, String pestanea) {
    elementos.add(ele);
    ele.gui = this;
    Pestana aux = getPestana(pestanea);
    aux.agregarElemento(ele);
    actTamano();
  }
  void actTamano() {
    if (elementos.size() == 0) return;
    Elemento aux = elementos.get(0);
    float xmax = aux.x+aux.w;
    for (int i = 1; i < elementos.size(); i++) {
      aux = elementos.get(i);
      if (aux.x+aux.w > xmax) {
        xmax = aux.x+aux.w;
      }
    }
    h = 30;
    for (int i = 0; i < pestanas.size(); i++) {
      Pestana a = pestanas.get(i);
      a.actTamano();
      h += a.h;
    }
    w = xmax+10;
  }
  void setVisible(boolean visible) {
    this.visible = visible;
    if (getValor("Menu fijo") == 1) {
      px = 20;
      py = 20;
      return;
    }
    if (mouseX + w > width) {
      px = mouseX - w;
    }
    else {
      px = mouseX;
    }
    if (mouseY + h > height) {
      py = mouseY - h;
    }
    else {
      py = mouseY;
    }
  }
  float getValor(String nombre) {
    float res = -1; 
    for (int i = 0; i < elementos.size(); i++) {
      Elemento aux = elementos.get(i);
      if (aux.nombre.equals(nombre)) {
        res = aux.val;
        break;
      }
    }
    return res;
  }
  void setValor(String nombre, float val) {
    for (int i = 0; i < elementos.size(); i++) {
      Elemento aux = elementos.get(i);
      if (aux.nombre.equals(nombre)) {
        aux.val = val;
        break;
      }
    }
  }
  Pestana getPestana(String nombre) {
    Pestana res = null; 
    for (int i = 0; i < pestanas.size(); i++) {
      Pestana aux = pestanas.get(i);
      if (aux.nombre.equals(nombre)) {
        res = aux;
        break;
      }
    }
    return res;
  }
}

class Pestana {
  ArrayList<Elemento> elementos;
  boolean desplagada, eliminar, margen;
  float w, h;
  Gui gui;
  String nombre;
  Pestana(String nombre) {
    this.nombre = nombre;
    eliminar = false;
    elementos = new ArrayList<Elemento>();
    desplagada = true;
    margen = true;
  }
  void act(float px, float py) {
    w = gui.w;
    if (input.click && mouseX >= px && mouseX < px+w &&mouseY > py && mouseY <= py+20) {
      desplagada = !desplagada; 
      gui.actTamano();
    }
    if (desplagada) {
      for (int i = 0; i < elementos.size(); i++) {
        Elemento  aux = elementos.get(i);
        aux.act(px, py+20);
        if (aux.eliminar) {
          elementos.remove(i);
        }
      }
    }
  }
  void dibujar(float px, float py) {
    fill(60);
    rect(px, py, w, 20);
    fill(255);
    if (desplagada) {
      triangle(px+10, py+7, px+15, py+13, px+20, py+7);
      text(nombre, px+24, py+14);
    }
    else {
      triangle(px+12, py+5, px+18, py+10, px+12, py+15);
      text(nombre, px+24, py+14);
    }
    if (desplagada) {
      for (int i = 0; i < elementos.size(); i++) {
        Elemento  aux = elementos.get(i);
        aux.dibujar(px, py+20);
      }
    }
  }
  void actTamano() {
    if (elementos.size() == 0) return;
    if (!desplagada) {
      h = 20;
      return;
    }
    Elemento aux = elementos.get(0);
    float ymax = aux.y+aux.h;
    for (int i = 1; i < elementos.size(); i++) {
      aux = elementos.get(i);
      if (aux.y+aux.h > ymax) {
        ymax = aux.y+aux.h;
      }
    }
    if (margen) {
      h = ymax+30;
    }
    else {
      h = ymax+20;
    }
  }
  void agregarElemento(Elemento ele) {
    elementos.add(ele);
    ele.gui = gui;
    actTamano();
  }
}

abstract class Elemento {
  Gui gui; 
  boolean eliminar;
  float x, y, w, h, val;
  String nombre;
  void act(float cx, float cy) {
  }
  void dibujar(float cx, float cy) {
  }
}

class scrollH extends Elemento {
  boolean move; 
  float max, min;
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    nombre = n;
    move = false;
    eliminar = false;
  }

  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (mousePressed) {
      if ( mouseX + 8 >= x + h/2 && mouseX - 8 <= x + w - h/2+ 8 && mouseY > y && mouseY <= y+h) {
        move = true;
      }
    }
    else {
      move = false;
    }
    if (move) {
      float posX = mouseX;
      if (posX < x) {
        posX = x;
      }
      else if (posX > x +w) {
        posX = x + w;
      }
      val =(min + (max-min) * ((posX- h/2 - x )/(w - h)));
      if (val < min) {
        val =min;
      }
      else if (val > max) {
        val =max;
      }
    }
  }

  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    fill(120);
    rect(x, y, w, h);

    fill(150);
    float pos = x + ((w-h) * (val-min)/(max-min));
    rect(pos, y, h, h);
    fill(255);
    if (abs(max-min) >= 20) {
      text(nombre+" "+int(val), x+2, y+9);
    }
    else {
      text(nombre+" "+val, x+2, y+9);
    }
  }
}

class Boton extends Elemento {
  boolean aux;
  Boton(float nx, float ny, float nw, float nh, int nv, String n) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    val = nv;
    nombre = n;
    aux = false;
    eliminar = false;
  }

  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (mousePressed && !aux) {
      aux = true;
      if ( mouseX >= x  && mouseX <= x + w ) {
        if ( mouseY >= y  && mouseY <= y + h ) {
          if (val == 1) {
            val = 0;
          }
          else {
            val = 1;
          }
        }
      }
    }
    if (aux && !mousePressed) {
      aux = false;
    }
  }

  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    noStroke();
    if (val == 1) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, w, h);
    fill(255);
    text(nombre, x+w+2, y+9);
  }
}

class Pulsador extends Elemento {
  Pulsador(float nx, float ny, float nw, float nh, String n) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    val = 0;
    nombre = n;
  }

  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (mousePressed) {
      if ( mouseX >= x  && mouseX <= x + w ) {
        if ( mouseY >= y  && mouseY <= y + h ) {
          val = 1;
        }
      }
    }
    else {
      val = 0;
    }
  }

  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    noStroke();
    if (val == 1) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, w, h);
    fill(255);
    text(nombre, x+w+2, y+9);
  }
}

class Selector extends Elemento {
  int cant;
  boolean aux;
  Selector(float nx, float ny, float nw, float nh, int nc, int nv, String n) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    cant = nc;
    val = nv;
    nombre = n;
    aux = false;
  }

  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (mousePressed) {
      if ( mouseX >= x  && mouseX < x + w ) {
        if ( mouseY >= y  && mouseY < y + h ) {
          val = int((mouseX - x)/(w/cant));
        }
      }
    }
  }

  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    noStroke();
    for (int i = 0; i < cant; i++) {
      if (val == i) {
        fill(150);
      }
      else {
        fill(120);
      }
      rect(x+(w)/cant*i, y, w/cant, h);
    }
    fill(255);
    text(nombre, x+w+2, y+9);
  }
}

class Comentario extends Elemento {
  String texto;
  Comentario(float x, float y, float w, float h, String nombre, String texto) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nombre = nombre;
    this.texto = texto;
  }
  void act(float cx, float cy) {
  }
  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    text(texto, x, y+9);
  }
}

class Presset extends Elemento {
  boolean click, sobre;
  Presset(float x, float y, float w, float h, String nombre) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nombre = nombre;
  }
  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    sobre = false;
    click = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
      if (input.click) {
        click = true;
      }
    }
  }

  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (sobre) {
      fill(100);
    }
    else {
      fill(80);
    }
    rect(x, y, w, h);
    fill(255);
    text(nombre, x+24, y+14);
  }
}

class MenuPressets extends Elemento {
  ArrayList<Presset> pressets;
  boolean scroll;
  int max, ind;
  MenuPressets(float x, float y, float w, int max, String nombre) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.nombre = nombre;
    this.max = max;
    ind = 0;
    scroll = false;
    pressets = new ArrayList<Presset>();
  }
  void act(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    int maxval = ind+max;
    if (maxval > pressets.size()) maxval = pressets.size();
    if (scroll) {
      float px = x+w-10;
      float py = y;
      if (input.click && ind > 0 && mouseX >= px && mouseX < px+20 && mouseY >= py && mouseY < y+20) {
        ind--;
      }
      if (input.click && maxval < pressets.size() && mouseX >= px && mouseX < px+20 && mouseY >= py+h-20 && mouseY < y+h) {
        ind++;
      }
    }
    for (int i = ind; i < maxval; i++) {
      Presset aux = pressets.get(i);
      aux.act(cx, cy-ind*20);
    }
  }
  void dibujar(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (scroll) {
      float px = x+w-10;
      float py = y;
      fill(110);
      rect(px, py, 20, h);
      if (ind > 0 && mouseX >= px && mouseX < px+20 && mouseY >= py && mouseY < y+20) {
        fill(240);
      }
      else {
        fill(180);
      }
      triangle(px+5, py+10, px+10, py+4, px+15, py+10);
      if (ind+max < pressets.size() && mouseX >= px && mouseX < px+20 && mouseY >= py+h-20 && mouseY < y+h) {
        fill(240);
      }
      else {
        fill(180);
      }
      triangle(px+5, py+h-10, px+10, py+h-4, px+15, py+h-10);
    }
    int maxval = ind+max;
    if (maxval > pressets.size()) maxval = pressets.size();
    for (int i = ind; i < maxval; i++) {
      Presset aux = pressets.get(i);
      aux.dibujar(cx, cy-ind*20);
    }
  }
  void agregarPresset(Presset pre) {
    pressets.add(pre);
    pre.gui = gui;
    actTamano();
  }
  void actTamano() {
    if (pressets.size() > max) {
      scroll = true;
      h = max * 20;
      for (int i = 0; i < pressets.size(); i++) {
        Presset aux = pressets.get(i);
        aux.w = w-10;
      }
    }
    else {
      scroll = false;
      h = (pressets.size()) * 20;
      for (int i = 0; i < pressets.size(); i++) {
        Presset aux = pressets.get(i);
        aux.w = w+10;
      }
    }
  }
}
