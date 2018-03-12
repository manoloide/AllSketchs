class Pestana {
  boolean mover, mostrar, sobre, desplegar;  
  int x, y, w, h;
  PImage barra; 
  Pestana(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y; 
    mostrar = true;
    desplegar = true;
    resize(w, h);
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    }
    else sobre = false;
    if (input.click && mouseButton == LEFT) {
      if (sobre && mouseY < y+20) {
        mover = true;
        if (mouseX >= x+w-20) mostrar = false;
      }
    }
    if (input.released) {
      mover = false;
    }
    if (mover) {
      x += mouseX-pmouseX;
      y += mouseY-pmouseY;
    }
  }
  void dibujar() {
    noStroke();
    if (!mostrar) return;
    fill(30);
    rect(x, y+20, w, h-20);
    image(barra, x, y);
    stroke(200);
    line(x+w-14, y+3, x+w-3, y+14);
    line(x+w-14, y+14, x+w-3, y+3);
  }
  void resize(int nw, int nh) {
    this.w = nw; 
    this.h = nh+20;
    barra = crearDegrade(w, 20, color(20), color(10));
  }
}

public class PFrame extends Frame {
  public PFrame() {
    setBounds(100, 100, 800, 600);
    control = new secondApplet();
    add(control);
    control.init();
    show();
  }
}

public class secondApplet extends PApplet {
  ArrayList<Material> materiales;
  public void setup() {
    size(800, 600);
    materiales = new ArrayList<Material>();
    materiales.add(new MLineas(this, 120, random(TWO_PI), 0));
  }

  public void draw() {
    //if (frameCount%10 == 0) f.setTitle("FPS: "+frameRate);
    background(0);
    for (int i = 0; i < materiales.size(); i++) {
      Material aux = materiales.get(i);
      aux.act();
    }
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
  boolean click, dclick, press, released;
  int amouseX, amouseY;
  int pressCount, mouseWheel, timepress;
  Key SALTAR, IZQUIERDA, DERECHA, ABAJO, REINICIAR, INVISIBLE, EDITAR, ELIMINAR; 
  Input() {
    click = dclick = released = press = false;
    pressCount = 0;

    SALTAR = new Key();
    IZQUIERDA = new Key();
    ABAJO = new Key();
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

    SALTAR.act();
    IZQUIERDA.act();
    ABAJO.act();
    DERECHA.act();
    REINICIAR.act();
    INVISIBLE.act();
    EDITAR.act();
    ELIMINAR.act();
  }
  void mpress() {
    amouseX = mouseX;
    amouseY = mouseY;
    click = true;
    press = true;
  }
  void mreleased() {
    released= true;
    press = false;
    if (millis() - timepress < 400) dclick = true;
    timepress = millis();
  }

  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) SALTAR.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (key == 'r' || key == 'R') REINICIAR.event(estado);
    if (key == ' ') INVISIBLE.event(estado);
    if (key == 'e' || key == 'E') EDITAR.event(estado);
    if (keyCode == 127) ELIMINAR.event(estado);
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
