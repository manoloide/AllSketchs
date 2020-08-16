class Key { 
  boolean press, click, release;
  int clickCount;
  void update() {
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
  Key ENTER, BACKSPACE, ALT, CTRL, SHIFT, UP, DOWN, LEFT, RIGHT;
  Input() {
    click = dclick = released = press = false;
    kclick = kreleased = kpress = false;
    pressCount = 0;

    ENTER = new Key();
    BACKSPACE = new Key();
    ALT = new Key();
    CTRL = new Key();
    SHIFT = new Key();
    UP = new Key();
    DOWN = new Key();
    LEFT = new Key();
    RIGHT = new Key();
	}
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = false;
    kclick = kreleased = false;

    ENTER.update();
    BACKSPACE.update();
    ALT.update();
    CTRL.update();
    SHIFT.update();
    UP.update();
    DOWN.update();
    LEFT.update();
    RIGHT.update();
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
      press = false;
    }
    if (keyCode == 10) ENTER.event(estado);
    if (keyCode == 8) BACKSPACE.event(estado);
    if (keyCode == 18) ALT.event(estado);
    if (keyCode == 17) CTRL.event(estado);
    if (keyCode == 16) SHIFT.event(estado);
    if (keyCode == 38) UP.event(estado);
    if (keyCode == 40) DOWN.event(estado);
    if (keyCode == 37) LEFT.event(estado);
    if (keyCode == 39) RIGHT.event(estado);
  }
};