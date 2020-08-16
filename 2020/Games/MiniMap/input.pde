class Key {
  boolean press, pressed;
  Key() {
    press = pressed = false;
  }
  
  void update() {
    if (pressed)
      press = false;
  }
  void pressed() {
    press = true;
    pressed = true;
  }
  void released() {
    press = pressed = false;
  }
}

class Input {
  Key left, right, jump, select;

  Input() {
    left = new Key();
    right = new Key();
    jump = new Key();
    select = new Key();
  }

  void update() {
    left.update();
    right.update();
    jump.update();
    select.update();
  }

  void pressed() {
    if (key == 'a') left.pressed();
    if (key == 'd') right.pressed();          
    if (key == 'w') jump.pressed();
    if (keyCode == ENTER) select.pressed();
  }

  void released() {
    if (key == 'a') left.released();
    if (key == 'd') right.released();          
    if (key == 'w') jump.released();
    if (keyCode == ENTER) select.released();
  }
}
