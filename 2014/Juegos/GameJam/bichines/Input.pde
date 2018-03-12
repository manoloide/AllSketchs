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
  boolean click, press, released;
  int pressCount;
  Key ARRIBA, ABAJO, IZQUIERDA, DERECHA; 
  Input() {
    click = released = press = false;
    pressCount = 0;
    ARRIBA = new Key();
    ABAJO = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
  }
  void act() {
    if (press) {
      pressCount++;
    }
    click = released = false;

    ARRIBA.act();
    ABAJO.act();
    IZQUIERDA.act();
    DERECHA.act();
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
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
  }
}
