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
  Key SALTAR, IZQUIERDA, DERECHA; 
  Input() {
    SALTAR = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
  }
  void act() {
    SALTAR.act();
    IZQUIERDA.act();
    DERECHA.act();
  }
  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) SALTAR.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
  }
}
