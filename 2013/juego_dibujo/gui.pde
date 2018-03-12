class GUI {
  ArrayList<Elemento> elementos;
  Boton espv, esph;
  color col;
  int x, y, w, h;
  float alfa;
  scrollH r, g, b, alp, grosor, tono, sat, lum;
  Selector pincel;
  Pulsador limpiar, guardar;
  GUI(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    alfa = 100;
    elementos = new ArrayList<Elemento>();
    r = new scrollH(70, 10, 100, 10, 0, 255, random(256), "rojo");
    g = new scrollH(70, 30, 100, 10, 0, 255, random(256), "verde");
    b = new scrollH(70, 50, 100, 10, 0, 255, random(256), "azul");
    agregar(r);
    agregar(g);
    agregar(b);
    alp = new scrollH(10, 70, 160, 10, 0, 100, 100, "alfa");
    grosor = new scrollH(10, 90, 160, 10, 0, 100, random(100), "grosor");
    agregar(alp);
    agregar(grosor);
    espv = new Boton(10, 110, 10, 10, false, "espejar v");
    esph = new Boton(100, 110, 10, 10, false, "espejar h");
    agregar(espv);
    agregar(esph);
    pincel = new Selector(10, 130, 160, 10, 8, 0, "pincel");
    agregar(pincel);
    tono = new scrollH(10, 150, 160, 10, -100, 100, 0, "variacion tono");
    sat = new scrollH(10, 170, 160, 10, -100, 100, 0, "variacion saturacion");
    lum = new scrollH(10, 190, 160, 10, -100, 100, 0, "variacion luminosidad");
    agregar(tono);
    agregar(sat);
    agregar(lum);
    limpiar = new Pulsador(10, 210, 10, 10, "limpiar");
    agregar(limpiar);
    guardar = new Pulsador(100, 210, 10, 10, "guardar");
    agregar(guardar);
  }

  void act() {
    alfa = alp.val;
    noStroke();
    fill(80);
    rect(x, y, w, h);
    col = color(r.val, g.val, b.val);
    fill(col);
    rect(x+10, y+10, 50, 50);
    for (int i = 0; i < elementos.size(); i++) {
      elementos.get(i).act(x, y);
    }
  }

  void agregar(Elemento e) {
    elementos.add(e);
  }
}

class Elemento {
  void act(int xg, int yg) {
  }
}

class Boton extends Elemento {
  float xc, yc, width, height, x, y;
  boolean val, aux;
  String name;

  Boton(float nx, float ny, float nw, float nh, boolean nv, String n) {
    xc = nx;
    yc = ny;
    width = nw;
    height = nh;
    val = nv;
    name = n;
    aux = false;
  }

  void act(int xg, int yg) {
    x = xc + xg;
    y = yc + yg;
    if (mousePressed && !aux) {
      aux = true;
      if ( mouseX >= x  && mouseX <= x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          if (val) {
            val = false;
          }
          else {
            val = true;
          }
        }
      }
    }
    if (aux && !mousePressed) {
      aux = false;
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+width+2, y+height-2);
  }
}

class Pulsador extends Elemento {
  float xc, yc, x, y, width, height;
  boolean val, sobre, click;
  String name;

  Pulsador(float nx, float ny, float nw, float nh, String n) {
    xc = nx;
    yc = ny;
    width = nw;
    height = nh;
    val = false;
    name = n;
  }

  void act(int xg, int yg) {
    val = false;
    x = xc + xg;
    y = yc + yg;
    if ( mouseX >= x  && mouseX <= x + width &&  mouseY >= y  && mouseY <= y + height ) {
      sobre = true;
    }
    else {
      sobre = false;
    }
    if (mousePressed) {
      if (!click && sobre) {
        val = true;
      }
      click = true;
    }
    else {
      click = false;
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+width+2, y+height-2);
  }
}

class scrollH extends Elemento {
  float xc, yc, x, y, width, height, max, min, val;
  String name;
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    xc = nx;
    yc = ny;
    width = nw;
    height = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
  }

  void act(int xg, int yg) {
    x = xc + xg;
    y = yc + yg;
    if (mousePressed) {
      if ( mouseX >= x + height/2 && mouseX - 8 <= x + width - height/2+ 8) {
        if ( mouseY >= y  && mouseY <= y + height )
          val = min + (max-min) * ((mouseX- height/2 - x )/(width - height));
        if (val < min) {
          val = min;
        }
        else if (val > max) {
          val = max;
        }
      }
    } 
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, width, height);

    fill(150);
    float pos = x + ((width-height) * (val-min)/(max-min));
    rect(pos, y, height, height);
    fill(255);
    text(name+" "+int(val), x+2, y+8);
  }
}

class Selector extends Elemento {
  int cant, val;
  float xc, yc, x, y, width, height;
  boolean aux;
  String name;

  Selector(float nx, float ny, float nw, float nh, int nc, int nv, String n) {
    xc = nx;
    yc = ny;
    width = nw;
    height = nh;
    cant = nc;
    val = nv;
    name = n;
    aux = false;
  }

  void act(int xg, int yg) {
    x = xc + xg;
    y = yc + yg;
    if (mousePressed) {
      if ( mouseX >= x  && mouseX < x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          val = int((mouseX - x)/(width/cant));
        }
      }
    }
    draw();
  }

  void draw() {
    noStroke();
    for (int i = 0; i < cant; i++) {
      if (val == i) {
        fill(150);
      }
      else {
        fill(120);
      }
      rect(x+(width)/cant*i, y, width/cant, height);
    }
    fill(255);
    text(name, x+2, y+height-4);
  }
}

