void keyPressed() {
  input.event(true);
  //if (key == ESC) key=0;
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

class Key { 
  boolean press, click, release;
  int clickCount;
  void act() {
    if (!focused) release();
    click = release = false;
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
    release = true;
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
};

class Input {
  boolean click, dclick, press, released, kclick, kpress, kreleased;
  int amouseX, amouseY;
  int pressCount, mouseWheel, timepress;
  Key ARRIBA, IZQUIERDA, DERECHA, ABAJO, ATACAR;
  Key CONTROL, ENTER, BACKSPACE; 
  Input() {
    click = dclick = released = press = false;
    kclick = kreleased = kpress = false;
    pressCount = 0;

    ARRIBA = new Key();
    IZQUIERDA = new Key();
    ABAJO = new Key();
    DERECHA = new Key();
    ATACAR = new Key();
    CONTROL = new Key();
    ENTER = new Key();
    BACKSPACE = new Key();
  }
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = false;
    kclick = kreleased = false;

    ARRIBA.act();
    IZQUIERDA.act();
    ABAJO.act();
    DERECHA.act();
    ATACAR.act();
    CONTROL.act();
    ENTER.act();
    BACKSPACE.act();
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
    if (estado) {
      kclick = true;
      kpress= true;
    }
    else {
      kreleased = true;
      kpress = false;
    }
    if (key == 'w' || key == 'W' || keyCode == UP) ARRIBA.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (key == 'x' || key == 'X' || keyCode == 10) ATACAR.event(estado);
    if (keyCode == 17) CONTROL.event(estado);
    if (keyCode == 10) ENTER.event(estado);
    if (keyCode == 8) BACKSPACE.event(estado);
  }
};
