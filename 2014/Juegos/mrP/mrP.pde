/* //<>//
Cosas a hacer:
 -corregir json cargar json que no funciona
 -expandir y contraer mapa
 -selecion y mover
 -varias metas y elegir a que nivel va
 -copiar y pegar
 Bugs:
 -cuadrilla
 Ideas:
 -listado de niveles
 */

Boton2 b1, b2, b3, b4, b5;
boolean mostrarinfo;
Camara camara = new Camara();
Editor editor;
Input input;
int TAMTILE = 10;
Nivel nivel;
String estado = "editor"; // menu, juego, editor

void setup() {
  size(800, 600);
  frameRate(60);
  noStroke();
  colorMode(HSB, 256);
  smooth();

  background(0);
  mostrarinfo = false;
  input = new Input();
  nivel = new Nivel();
  editor = new Editor();

  b1 = new Boton2(15, height-30, 60, 20, "JUGAR");
  b2 = new Boton2(85, height-30, 60, 20, "NUEVO");
  b3 = new Boton2(155, height-30, 60, 20, "CARGAR");
  b4 = new Boton2(225, height-30, 60, 20, "GUARDAR");
  b5 = new Boton2(295, height-30, 60, 20, "SAVE AS");
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("mrP - FPS:"+frameRate);
  camara.act();
  background(0);
  if (estado.equals("menu")) {
  }
  else if (estado.equals("juego")) {
    translate(int(width/2-camara.x), int(height/2-camara.y));
    nivel.act();
    if (input.INFO.click) {
      mostrarinfo = !mostrarinfo;
    }
    if (mostrarinfo) {
      monitor();
    }
    resetMatrix();
    b1.act();
    if (input.EDITAR.click || b1.click) {
      b1.nombre = "JUGAR";
      estado = "editor";
    }
  }
  else if (estado.equals("editor")) {
    translate(int((width-200)/2-camara.x), int(height/2-camara.y));
    editor.act();
    fill(180, 160);
    resetMatrix();
    b1.act();
    b2.act();
    b3.act();
    b4.act();
    b5.act();
    if (input.EDITAR.click || b1.click) {
      b1.nombre = "EDITAR";
      nivel.actualizar();
      estado = "juego";
    }

    if (b2.click) {
      nivel = new Nivel();
    }
    if (b3.click) {
      selectInput("Seleciona el mapa", "cargarNvl");
    }

    if (b4.click) {
      if (nivel.src.equals("")) nivel.guardarComo();
      else nivel.guardar();
    }
    if (b5.click) {
      nivel.guardarComo();
    }
  }
  input.act();
}

void cargarNvl(File f) {
  if (f == null) {
  }
  else {
    String ruta = f.toString();
    String extension = ruta.substring(ruta.lastIndexOf(".") + 1, ruta.length());
    if (extension.equals("nvl")) {
      nivel.cargar(f.toString());
    }
  }
}


void guardarSelecionar(File sel) {
  if (sel != null) {
    nivel.src = sel.toString();
    nivel.guardar();
  }
}

void mousePressed() {
  if (mouseEvent.getClickCount()==2) input.dclick = true;
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void mouseWheel(MouseEvent event) {
  int e = (int)event.getAmount();
  input.mouseWheel = e;
}

void keyPressed() {
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
  Key ARRIBA, IZQUIERDA, DERECHA, ABAJO, INFO, REINICIAR, EDITAR; 
  Input() {
    click = dclick = released = press = false;
    pressCount = 0;

    ARRIBA = new Key();
    IZQUIERDA = new Key();
    ABAJO = new Key();
    DERECHA = new Key();
    INFO = new Key();
    REINICIAR = new Key();
    EDITAR = new Key();
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
    INFO.act();
    REINICIAR.act();
    EDITAR.act();
  }
  void mpress() {
    click = true;
    press = true;
  }
  void mreleased() {
    released= true;
    press = false;
  }

  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) ARRIBA.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (key == 'i' || key == 'I') INFO.event(estado);
    if (key == 'r' || key == 'R') REINICIAR.event(estado);
    if (key == 'e' || key == 'E') EDITAR.event(estado);
  }
}

class Camara {
  float x, y, xd, yd;
  Camara() {
    x = 0; 
    y = 0;
  }
  void act() {
    if (estado.equals("juego")) {
      xd = nivel.jugador.x;
      yd = nivel.jugador.y;
      x += (xd-x)/5;
      y += (yd-y)/5;
    }
  }
}
