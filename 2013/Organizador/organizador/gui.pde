class Menu {
  ArrayList<Proyecto> proyectos;
  boolean scrolling, moviendo;
  BotonIcono bnuevo, beliminar, bconfig;
  float x, y, w, h;
  int cant;
  Scroll scroll;
  Proyecto mover;
  Menu() {
    x = 0;
    y = (height-80);
    w = 480;
    h = 80;
    bnuevo = new BotonIcono(w/2, y+44, 40, nuevo);
    beliminar = new BotonIcono(88, y+44, 40, eliminar);
    bconfig = new BotonIcono(w-88, y+44, 40, config);
    proyectos = new ArrayList<Proyecto>();
    moviendo = false;
    mover = null;
    cargar();
    scroll = new Scroll(460, 8, 16, height-96 );
    if (proyectos.size() > (height-80)/80) {
      scrolling = true;
    } else {
      scrolling = false;
    }
  }
  void act() {
    if (scrolling) {
      scroll.act(proyectos.size()*80);
    }
    bnuevo.act();
    beliminar.act();
    bconfig.act();
    if (bnuevo.press) {
      nuevoProyecto();
      actScroll();
    }
    if (moviendo && !e.move) {
      if (beliminar.released) {
        eliminarProyecto();
      } else if (bnuevo.released) {
        copiarProyecto();
        proyectos.add(mover.id, mover);
      } else {
        int pos =  proyectos.size();
        for (int i = 0; i < proyectos.size(); i++) {
          float apos = h*i + scroll.val * (y-cant*h);
          if (mover.y+mover.dy > apos-40 && mover.y+mover.dy < apos+40) {
            pos = i;
          }
        }
        proyectos.add(pos, mover);
      }
      for (int i = 0; i < proyectos.size(); i++) {
        Proyecto aux = proyectos.get(i);
        aux.id = i;
        aux.guardar();
      }
      moviendo = false;
      mover = null;
      actScroll();
    }
    cant = proyectos.size();
    for (int i = 0; i < proyectos.size(); i++) {
      Proyecto aux = proyectos.get(i);
      if (scrolling) {
        aux.w = 456;
        aux.y = h*i + scroll.val * (y-cant*h);
      } else {
        aux.w = 480;
        aux.y = h*i;
      }
      aux.act();
      if (moviendo) {
        aux.moviendo = false;
      }
      if (aux.press) {
        actual = aux;
        ep = new EditarProyecto(actual);
        estado = "transicion";
        count = cantcount;
      }
      if (aux.moviendo && mover == null) {
        moviendo =  true;
        mover = aux; 
        proyectos.remove(i);
        actScroll();
      }
    }
    if (moviendo) {
      mover.act();
    }
    dibujar();
  }
  void dibujar() {
    for (int i = 0; i < proyectos.size(); i++) {
      Proyecto aux = proyectos.get(i);
      aux.dibujar();
    }
    noStroke();
    fill(230);
    rect(x, y, w, h);
    stroke(240);
    line(x, y, w, y);
    stroke(220);
    line(x, y-1+h, w, y-1+h);
    if (scrolling) {
      noStroke();
      fill(230);
      rect(456, 0, 24, height-80);
      stroke(220);
      line(456, height-81, 480, height-81);
      scroll.dibujar();
    }
    bnuevo.dibujar();
    beliminar.dibujar();
    bconfig.dibujar();
    if (moviendo) {
      mover.dibujar();
    }
  }

  void cargar() {
    //guarda acaaaa
    xml = loadXML(tconfig[1]);
    aproyecto = xml.getChildren("proyecto");
    for (int i = 0; i < aproyecto.length; i++) {
      int id = aproyecto[i].getInt("id");
      String contenido = aproyecto[i].getString("contenido");
      String fecha = aproyecto[i].getString("fecha");
      String nombre = aproyecto[i].getContent();
      proyectos.add(new Proyecto(id, contenido, nombre, fecha));
    }
  }
  void nuevoProyecto() {
    xml.addChild("proyecto");
    aproyecto = xml.getChildren("proyecto");
    int id = aproyecto.length-1;
    aproyecto[id].setInt("id", id);
    String contenido = "";
    aproyecto[id].setString("contenido", contenido);
    String fecha = "";
    aproyecto[id].setString("fecha", fecha);
    String nombre = "Nuevo Proyecto";
    aproyecto[id].setContent(nombre);
    proyectos.add(new Proyecto(id, contenido, nombre, fecha));
    saveXML(xml, "data/proyectos.xml");
  }
  void eliminarProyecto() {
    aproyecto = xml.getChildren("proyecto");
    xml.removeChild(aproyecto[mover.id]);
  }
  void copiarProyecto() {
    xml.addChild("proyecto");
    aproyecto = xml.getChildren("proyecto");
    int id = aproyecto.length-1;
    aproyecto[id].setInt("id", id);
    String contenido = mover.contenido;
    aproyecto[id].setString("contenido", contenido);
    String fecha = "";
    aproyecto[id].setString("fecha", fecha);
    String nombre = mover.nombre;
    aproyecto[id].setContent(nombre);
    proyectos.add(new Proyecto(id, contenido, nombre, fecha));
    saveXML(xml, "data/proyectos.xml");
  }
  void actScroll() {
    if (proyectos.size() > (height-80)/80) {
      scrolling = true;
    } else {
      scrolling = false;
      scroll.val = 0;
    }
    for (int i = 0; i < proyectos.size(); i++) {
      Proyecto aux = proyectos.get(i);
      if (scrolling) {
        aux.w = 456;
      } else {
        aux.w = 480;
      }
    }
  }
}

class Boton {
  boolean press;
  float x, y, tam, ang;
  int sobre;
  Boton(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    ang = TWO_PI/4;
  }
  void act() {
    press = false;
    if (dist(mouseX, mouseY, x, y) < tam/2) {
      if (e.click) {
        press = true;
      }
      if (sobre < 10) {   
        sobre += 1;
      }
    } else {
      if (sobre > 0) {   
        sobre -= 1;
      }
    }
  }
  void dibujar() {
    stroke(128);
    fill(204);
    ellipse(x, y, tam, tam);
    color ca = lerpColor(color(128, 128, 128), color(214, 39, 97), sobre/10.);
    fill(ca);
    stroke(ca);
    triangulo(x, y, 16, ang);//+sobre*0.2
  }
}

class BotonIcono {
  boolean press, released;
  color col;
  float x, y, tam;
  int sobre;
  PShape ico; 
  BotonIcono(float x, float y, float tam, PShape ico) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    this.ico = ico;
  }
  void act() {
    released = false;
    press = false;
    if (dist(mouseX, mouseY, x, y) < tam/2) {
      if (e.click) {
        press = true;
      }
      if (e.released) {
        released = true;
      }
      if (sobre < 10) {   
        sobre += 1;
      }
    } else {
      if (sobre > 0) {   
        sobre -= 1;
      }
    }
  }
  void dibujar() {
    col = lerpColor(color(204, 204, 204), color(214, 39, 97), sobre/10.);
    fill(col);
    noStroke();
    shape(ico, x, y);
  }
}
class Scroll {
  boolean moviendo;
  float x, y, w, h, val, min, max, alto, py, aval;
  Scroll(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    val = 0;
    min = 0;
    max = 1;
    moviendo = false;
  }
  void act(float total) {
    alto = (h-w)*(h/total);
    if (e.press) {
      if (mouseX >= x && mouseX <x+w && mouseY >= y && mouseY < y+h) {
        moviendo = true;
        py = mouseY;
        aval = val;
      }
    }
    if (e.rueda && total > h) {
      val += e.mrueda/5.;  
      if (val < min) {
        val = min;
      } else if (val > max) {
        val = max;
      }
    }
    if (moviendo && e.move) {
      val = aval+((mouseY-py)/(h-alto-w));
      if (val < min) {
        val = min;
      } else if (val > max) {
        val = max;
      }
    } else {
      moviendo = false;
    }
  }
  void dibujar() {
    noStroke();
    fill(204);
    ellipse(x+w/2, y+w/2, w, w);
    ellipse(x+w/2, y-w/2+h, w, w);
    rect(x, y+w/2, w, h-w);
    fill(230);
    float d = (h-alto-w) * val;
    ellipse(x+w/2, y+w/2+d, 10, 10);
    rect(x+3, y+w/2+d, 10, alto);
    ellipse(x+w/2, y+w/2+alto+d, 10, 10);
  }
}
class TextE {
  boolean edit, tab, scrolling;
  color col, colsel;
  float x, y, w, h, lx, ly, htext;
  PFont font;
  int apos, pos, ttam;
  Scroll scroll;
  String text;
  TextE(float x, float y, float w, float h, String text, PFont font, int ttam, color col) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.font = font;
    this.ttam = ttam;
    this.col = col;
    edit = false;
    tab = false;
    pos = 0;
    scroll = new Scroll(460, 88, 16, height-96 );
    scrolling = false;
    pushStyle();
    colorMode(HSB, 256);
    colsel = color(hue(col), saturation(col)-150, brightness(col)+100);
    popStyle();
  }
  void act() {
    actAlto();
    if (scrolling) {
      scroll.act(htext);
    }
    if (e.press) {        
      if (mouseX >= x-10 && mouseX < x+w+10 && mouseY >= y && mouseY < y+h) {
        buscarPos(mouseX, mouseY);
        apos = pos;
        edit = true;
      } else {
        apos = pos;
        edit = false;
      }
    }
    if (edit) {
      textFont(font, ttam);
      if (e.move) {
        buscarPos(mouseX, mouseY);
        actPos();
      }
      if (e.press) {
        apos = pos;
      }
      if (e.keypress) {
        int lar = text.length();
        if (e.ctrl) {
          if (int(key) == 3 && apos != pos) {
            cp.copyString(text.substring(min(apos, pos), max(apos, pos)));
          }
          if (key == 22) {
            text = text.substring(0, min(apos, pos))+cp.pasteString()+text.substring(max(apos, pos), lar);
            pos = min(apos, pos)+cp.pasteString().length();
            actPos();
            apos = pos;
          }
          if (key == 24 && apos != pos) {
            cp.copyString(text.substring(min(apos, pos), max(apos, pos)));
            text = text.substring(0, min(apos, pos))+text.substring(max(apos, pos), lar);
            pos = min(apos, pos);
            actPos();
            apos = pos;
          }
        } else {
          if ((key >= 32 && key <= 126) || key == ENTER) {
            if (key == ENTER && !tab) {
              edit = false;
            } else {
              text = text.substring(0, min(apos, pos))+key+text.substring(max(apos, pos), lar);
              pos++;
              actPos();
              apos = pos;
            }
          }
          if (key == BACKSPACE) {
            if (lar > 0 && pos >= 0) {
              if (apos == pos) {
                pos--;
                actPos();
              }
              text = text.substring(0, min(apos, pos))+text.substring(max(apos, pos), lar);
              pos = min(apos, pos);
              actPos();
              apos = pos;
            }
          }
          if (keyCode == RIGHT) {
            if (pos < text.length()) {
              pos++;
              actPos();
              if (!e.shift) {
                apos = pos;
              }
            }
          }
          if (keyCode == LEFT) {
            if (pos > 0) {
              pos--;
              actPos();
            }
            if (!e.shift) {
              apos = pos;
            }
          }
        }
      }
    }
  }

  void dibujar() {
    dibujar(0, 0);
  }

  void dibujar(float nx, float ny) {
    float y = this.y + scroll.val * (h - htext);
    textFont(font, ttam);
    noFill();
    stroke(190);
    float hl = textAscent()+textDescent();
    fill(col);
    if (tab) {
      if (text.length() > 0) {
        float px = 0;
        float py = 0;
        char ant = text.charAt(0);
        for (int i = 0; i < text.length(); i++) {
          char car = text.charAt(i);
          if (px > w || car == 10) {
            px = 0;
            py += 20;
          }
          if (car != 10) {
            if (i >= min(apos, pos) && i < max(apos, pos)) {
              fill(colsel);
            } else {
              fill(col);
            }
            text(car, x+px+nx, y+py+ny);
          }
          px += textWidth(car);
          ant = car;
        }
      }
    } else {
      if (apos == pos) {
        text(text, x+nx, y+ny, w, h);
      } else {
        int minp = min(apos, pos);
        int maxp = max(apos, pos);
        fill(col);
        String tx = text.substring(0, minp);
        text(tx, x+nx, y+ny, w, h);
        fill(colsel);
        float dx = textWidth(tx);
        tx = text.substring(minp, maxp);
        text(tx, int(x+nx+dx), y+ny, w, h);
        fill(col);
        dx += textWidth(tx);
        tx = text.substring(maxp);
        text(tx, int(x+nx+dx), y+ny, w, h);
      }
    }
    if (edit && millis()%1000 < 500) {
      stroke(20);
      line(x+lx+nx, y-2+ly+ny, x+lx+nx, y+hl+2+ly+ny);
    }
    if (scrolling) {
      scroll.dibujar();
    }
  }

  void buscarPos(int nx, int ny) {
    float y = this.y + scroll.val * (h - htext);
    if (ny < y) {
      pos = 0;
      return;
    }
    float ant = 0;
    pos = text.length();
    float px = 0;
    float py = 0;
    for (int i = 0; i < text.length();i++) {
      char car = text.charAt(i);
      px += textWidth(car);
      if (ny >= y+py && ny < y+py+20) {
        pos = i+1;
        if (nx >= x+ant && nx < x+px) {
          break;
        }
        if (nx < x) {
          pos = i;
          break;
        }
      }
      ant = px;
      if (px > w || car == 10) {
        px = 0;
        py += 20;
        ant = 0;
      }
    }
  }

  void actPos() {
    float px = 0;
    float py = 0;
    for (int i = 0; i < pos;i++) {
      char car = text.charAt(i);
      px += textWidth(car);
      if (px > w || car == 10) {
        px = 0;
        py += 20;
      }
    }
    ly = py;
    lx = px;
  }
  void actAlto() {
    float px = 0;
    float py = 0;
    for (int i = 0; i < text.length();i++) {
      char car = text.charAt(i);
      px += textWidth(car);
      if (px > w || car == 10) {
        px = 0;
        py += 20;
      }
    }
    htext = py;  
    if (htext > h+20) {
      scrolling = true;
    } else {
      scrolling = false;
      scroll.val = 0;
    }
  }
}


void triangulo(float x, float y, float tam, float ang) {
  tam = tam/2;
  float da = TWO_PI/3;
  triangle(x+cos(ang)*tam, y+sin(ang)*tam, x+cos(ang+da)*tam, y+sin(ang+da)*tam, x+cos(ang+da*2)*tam, y+sin(ang+da*2)*tam);
}

void archivo(float x, float y, float w, float h, float t) {
  beginShape();
  vertex(x, y);
  vertex(x, y+h);
  vertex(x+w, y+h);
  vertex(x+w, y+t);
  vertex(x+w-t, y);
  endShape(CLOSE);
}

