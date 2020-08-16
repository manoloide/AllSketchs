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
};

class Input {
  boolean click, dclick, press, released, kclick;
  int amouseX, amouseY, pressCount, mouseWheel, timepress;
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
    amouseX = mouseX;
    amouseY = mouseY;
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