//editar tareas
//agregar tareas
//agregar fecha de creacion
//completar tareas y guarlas en concretadas
//eliminar tareas
//rediseñar
//agregar scroll

ArrayList<Tarea> tareas;
JSONObject config, datos;
Input input;
PFont font;
PImage img_fondo, img_tareas;
Tarea sel;

void setup() {
  config = loadJSONObject("config.json");
  datos = loadJSONObject("datos.json");
  font = loadFont("bebas.vlw");
  textFont(font);
  size(config.getInt("width"), config.getInt("height"));
  input = new Input();
  tareas = new ArrayList<Tarea>();
  img_fondo = crearDegrade(width, height, color(#B9B9B9), color(#484848));
  img_tareas = crearDegrade(width, 52, color(#325E93), color(#284E7C));
  JSONArray jtareas = datos.getJSONArray("tareas");
  for (int i = 0; i < jtareas.size(); i++) {
    JSONObject jtarea = jtareas.getJSONObject(i);
    tareas.add(new Tarea(jtarea.getString("nombre"), 0, i*52, width, 52));
  }
}

void draw() {
  image(img_fondo, 0, 0);
  textSize(40);
  textAlign(CENTER, TOP);
  for (int i = 0; i < tareas.size(); i++) {
    Tarea aux = tareas.get(i);
    int des = 0;
    if (sel != null && i*52 > sel.y-26) {
      des = 52;
    }
    aux.y = i*52+des;
    aux.act();
    if (aux.sel && sel == null) {
      sel = aux;
      tareas.remove(i--);
    }
  }
  if (sel != null) {
    sel.y += mouseY-pmouseY;
    sel.act();
    if (!sel.sel) {
      if ((sel.y+26)/52 > tareas.size()) tareas.add(sel);
      else tareas.add((sel.y+26)/52, sel);
      sel = null;
    }
  }
  input.act();
}

void dispose() {
  guardar();
  println("se guardo");
}

void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}
void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void guardar() {
  JSONObject aux = new JSONObject();
  JSONArray jtareas = new JSONArray();
  for (int i = 0; i < tareas.size(); i++) {
    JSONObject jtarea = new JSONObject();
    jtarea.setString("nombre", tareas.get(i).nombre);
    jtareas.append(jtarea);
  }
  aux.setJSONArray("tareas", jtareas);
  datos = aux; 
  saveJSONObject(datos, "datos.json");
}

class Tarea {
  boolean click, editar, sel, sobre;
  CampoTexto ct; 
  int x, y, w, h;
  int sobreTiempo;
  String nombre;
  Tarea(String nombre, int x, int y, int w, int h) {
    this.nombre = nombre;
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    sobreTiempo = 0;
    click = editar = sel = sobre = false;
    ct = new CampoTexto(0, 0, w, h, nombre);
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobreTiempo++;
      if (sobreTiempo > 20) sobreTiempo = 20;
      sobre = true;
    } 
    else {
      sobreTiempo--;
      if (sobreTiempo < 0) sobreTiempo = 0;
      sobre = false;
    }
    if (sobre && input.click) {
      sel = true;
    }
    if (input.released) {
      sel = false;
    }
    if (input.dclick) editar = true;

    if (editar) {
    }
    ct.act(x, y);
    nombre = ct.val;
    dibujar();
  }
  void dibujar() {
    image(img_tareas, x, y);
    if (sobreTiempo != 0) {
      noStroke();
      fill(#EBEBF5, sobreTiempo*2.2);
      rect(x, y, w, h);
    }
    ct.dibujar(x, y);
  }
}

class Key { 
  boolean press, click;
  int clickCount;
  void act() {
    if (!focused) release();
    click = false;
    if (press) clickCount++;
  }
  void press() {
    if (!press) {
      click = true; 
      press = true;
      clickCount = 0;
    }
  }
  void release() {
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
}

class Input {
  boolean click, dclick, press, released, kclick;
  int pressCount, mouseWheel, timepress;
  Key ENTER, BACKSPACE, ARRIBA, ABAJO, IZQUIERDA, DERECHA;
  Input() {
    click = dclick = released = press = false;
    pressCount = 0;

    ENTER = new Key();
    BACKSPACE = new Key();
    ARRIBA = new Key();
    ABAJO = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
  }
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = kclick = false;

    ENTER.act();
    BACKSPACE.act();
    ARRIBA.act();
    ABAJO.act();
    IZQUIERDA.act();
    DERECHA.act();
  }
  void mpress() {
    click = true;
    press = true;
    pressCount = 0;
  }
  void mreleased() {
    released= true;
    press = false;
    if (millis() - timepress < 400) dclick = true;
    timepress = millis();
  }

  void event(boolean estado) {
    if (estado) kclick = true;
    if (keyCode == 10) ENTER.event(estado);
    if (keyCode == 8) BACKSPACE.event(estado);
    if (keyCode == UP) ARRIBA.event(estado);
    if (keyCode == DOWN) ABAJO.event(estado);
    if (keyCode == LEFT) IZQUIERDA.event(estado);
    if (keyCode == RIGHT) DERECHA.event(estado);
  }
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
      c = lerpColor(c, color(0), map(abs(w/2-i), 0, w/2, 0, 0.15));
      color ac = c;
      if ((i+j)%2 == 0) ac = lerpColor(c, color(#325E93), 0.04);
      aux.set(i, j, ac);
    }
  }
  return aux;
}

class CampoTexto {
  boolean sobre, press, click;
  boolean editar, numerico;
  int x, y, w, h, pos;
  String val;
  CampoTexto(int x, int y, int w, int h, String val) {
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    this.val = val;
  } 
  void act(int dx, int dy) {
    sobre = press = click = false;
    if (mouseX >= x+dx && mouseX < x+w+dx && mouseY >= y+dy && mouseY < y+h+dy) {
      sobre = true;
      if (input.press)press = true;
      if (input.released)click = true;
    }
    if (sobre && input.dclick) {
      buscarPos(x+dx, y+dy);
      editar = true;
    }
    if (editar) {
      if (input.ENTER.click) editar = false;
      if (input.click && !sobre) editar = false;
      if (input.click && sobre) buscarPos(x+dx, y+dy);
      if (pos > 0 && (input.IZQUIERDA.click || (input.IZQUIERDA.press && input.IZQUIERDA.clickCount%3 == 0 && input.IZQUIERDA.clickCount > 30))) pos--;
      if (pos < val.length() && (input.DERECHA.click || (input.DERECHA.press && input.DERECHA.clickCount%3 == 0 && input.DERECHA.clickCount > 30))) pos++;
      if (input.BACKSPACE.click || (input.BACKSPACE.press && input.BACKSPACE.clickCount%3 == 0 && input.BACKSPACE.clickCount > 30)) {
        int lar = val.length();
        if (lar > 0 && pos > 0) {
          val = val.substring(0, pos-1)+val.substring(pos, lar);
          pos--;
        }
      }
      if (input.kclick) {
        if (!numerico && key >= 32 && key <= 126) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
          //val += key;
        }
        else if (key >= 48 && key < 58) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
        }
      }
    }
  }
  void dibujar(int dx, int dy) {
    fill(#F2F7FC);
    text(val, x+w/2+dx, y+8+dy);
    if (editar && frameCount%60 < 30) {
      rect(textWidth(val.substring(0, pos))+(w-(textWidth(val)))/2+dx, y+4+dy, 2+dx, h-8);
    }
  }
  String getString() {
    return val;
  }
  int getInt() {
    return int(val);
  }
  float getFloat() {
    return float(val);
  }
  void buscarPos(int x, int y) {
    if (mouseX < x) {
      pos = 0;
      return;
    }
    if (mouseX >= x+textWidth(val)+(w-(textWidth(val)))/2) { 
      pos = val.length();
      return;
    }
    int at = 4;
    for (int i = 0; i <= val.length(); i++) {
      int tam = int(textWidth(val.substring(0, i))+(w-(textWidth(val)))/2);
      if (mouseX >= x+at && mouseX < x+tam) {
        pos = i-1;
        break;
      }
      at = tam;
    }
  }
}
