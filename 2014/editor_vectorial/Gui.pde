class Menu {
  boolean sobre;
  Consola consola;
  int x, y, w, h, dy;
  PImage fondo;
  Menu(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
    consola = new Consola();
    fondo = crearDegrade(w, h, color(40), color(26));
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y+dy-8 && mouseY < y+dy+h) {
      sobre = true;
      if (dy > -h)dy -= 2;
    }
    else {
      sobre = false;
      if (dy < 0) dy += 2;
    }
    consola.y = y+dy-consola.h;
    consola.act();
    dibujar();
  }
  void dibujar() {
    image(fondo, x, y+dy);
  }
}

class Consola {
  ArrayList<String> ant;
  boolean visible;
  int x, y, w, h, tiempo, indice;
  String act;
  PImage fondo, fondo2; 
  Consola() {
    ant = new ArrayList<String>();
    act = "";
    visible = true;
    w = width; 
    h = 30;
    x = 0;
    y = height;
    fondo = crearDegrade(w, h, color(40), color(26));
    fondo2 = crearDegrade(w-10, h-10, color(0), color(10));
  }
  void act() {
    if (visible && act.equals("")) {
      tiempo--;
      if (tiempo <= 0) visible = false;
    }
    dibujar();
  }
  void dibujar() {
    if (!visible) return;
    image(fondo, x, y);
    image(fondo2, x+5, y+5);
    fill(255); 
    text(act, x+10, y+20);
  }
  void press() {
    if (!visible) indice = ant.size();
    visible = true;
    tiempo = 60;
    if (keyCode == UP) {
      if (indice == ant.size()) ant.add(act);
      if (indice > 0) indice--;
      act = ant.get(indice);
    }
    else if (keyCode == DOWN) {
      if (indice != ant.size()) {
        if (indice < ant.size()-1) indice++;
        act = ant.get(indice);
      }
    }
    else if (keyCode == ENTER) {
      String comando[] = split(act, ' ');
      int cant = comando.length;
      if (comando[0].equals("ellipse")) {
        if (cant == 4) elementos.add(new Ellipse(float(comando[1]), float(comando[2]), float(comando[3])));
        if (cant == 5) elementos.add(new Ellipse(float(comando[1]), float(comando[2]), float(comando[3]), float(comando[4])));
      }
      else if (comando[0].equals("line") && comando.length > 4) {
        elementos.add(new Line(float(comando[1]), float(comando[2]), float(comando[3]), float(comando[4])));
      }
      else if (comando[0].equals("rect") && comando.length > 4) {
        elementos.add(new Rect(float(comando[1]), float(comando[2]), float(comando[3]), float(comando[4])));
      }
      else if (comando[0].equals("move") && comando.length > 1) {
        for (int i = 0; i < seleccionado.seleccionados.size(); i++) {
          seleccionado.seleccionados.get(i).move(float(comando[1]), float(comando[2]));
        }
      }
      else if (comando[0].equals("deselect")) {
        seleccionado.deseleccionar();
      }
      if (!act.equals("")) {
        if (ant.size() > 0 && indice != ant.size()) ant.remove(ant.size()-1);
        ant.add(act);
        indice = ant.size();
        act = "";
      }
    }
    else if (keyCode == BACKSPACE) {
      if (act.length() > 0) {
        act = act.substring(0, act.length()-1);
      }
    }
    else if (key >= 32 && key < 127) {
      act += key;
    }
  }
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
      color ac = c;
      if ((i+j)%2 == 0) ac = lerpColor(c, color(#325E93), 0.04);
      aux.set(i, j, ac);
    }
  }
  return aux;
}
