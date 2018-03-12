/*
 ver como cargar todas las fuentes
 manipular las fuentes
 pasar a todos los elementos a vectores que sean todos iguales
 cambiar 
 exportar png y pdf
 */

ArrayList<Elemento> elementos;
Input input;
Menu menu;
Seleccionador seleccionado;

void setup() {
  size(600, 600);
  smooth(8);
  input = new Input();
  elementos = new ArrayList<Elemento>();
  menu = new Menu(0, height, width, 50);
  seleccionado  = new Seleccionador();
  //String[] fontList = PFont.list();
  //println(fontList);
}

void draw() {
  background(255);
  seleccionado.act();
  for (int i = 0; i < elementos.size(); i++) {
    Elemento aux = elementos.get(i);
    aux.act();
  }
  menu.act();
  input.act();
}

void mousePressed() {
  input.mpress();
}

void mouseReleased() {
  input.mreleased();
  seleccionado.seleccionar();
}

void keyPressed() {
  menu.consola.press();
  input.event(true);
}

void keyReleased() {
  input.event(false);
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
  boolean click, dclick, press, released;
  int pressCount, mouseWheel;
  int mouseXp, mouseYp;
  Key IZQUIERDA, DERECHA, ABAJO, ARRIBA, REINICIAR, INVISIBLE, EDITAR, ELIMINAR; 
  Input() {
    click = dclick = released = press = false;
    pressCount = 0;

    IZQUIERDA = new Key();
    ABAJO = new Key();
    ARRIBA = new Key();
    DERECHA = new Key();
    REINICIAR = new Key();
    INVISIBLE = new Key();
    EDITAR = new Key();
    ELIMINAR = new Key();
  }
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = false;

    ARRIBA.act();
    IZQUIERDA.act();
    ABAJO.act();
    DERECHA.act();
    REINICIAR.act();
    INVISIBLE.act();
    EDITAR.act();
    ELIMINAR.act();
  }
  void mpress() {
    click = true;
    press = true;
    mouseXp = mouseX;
    mouseYp = mouseY;
  }
  void mreleased() {
    released= true;
    press = false;
  }

  void event(boolean estado) {
    if (keyCode == UP) ARRIBA.event(estado);
    if (keyCode == DOWN) ABAJO.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (key == 'r' || key == 'R') REINICIAR.event(estado);
    if (key == ' ') INVISIBLE.event(estado);
    if (key == 'e' || key == 'E') EDITAR.event(estado);
    if (keyCode == 127) ELIMINAR.event(estado);
  }
}

class Seleccionador {
  ArrayList<Elemento> seleccionados;
  Seleccionador() {
    seleccionados = new ArrayList<Elemento>();
  }
  void act() {
  }
  void seleccionar() {
    deseleccionar();
    for (int i = elementos.size()-1; i >= 0 ; i--) {
      Elemento aux = elementos.get(i);
      if (aux.sobre(mouseX, mouseY, input.mouseXp, input.mouseYp)) {
        seleccionados.add(aux);
        aux.seleccionado = true;
        if (mouseX == input.mouseXp && mouseY == input.mouseYp) break;
      }
    }
  }
  void deseleccionar() {
    for (int i = 0; i < seleccionados.size(); i++) {
      seleccionados.get(i).seleccionado = false;
    }
    seleccionados = new ArrayList<Elemento>();
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}
