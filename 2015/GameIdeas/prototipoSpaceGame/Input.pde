class Key {
  boolean click, press, release;
  Key() {
    click = press = release = false;
  }
  
  void update() {
    click = false;
    release = false;
  }
  
  void pressed() {
    click = true;
    press = true;
  }
  
  void released() {
    release = true;
    press = false;
  }
}

class Input {
  boolean click, press, release;
  Key left, right, up, down;
  Input(){
    click = press = release = false;
    left = new Key();
    right = new Key();
    up = new Key();
    down = new Key();
  }
  
  void update() {
    click = false;
    release = false;
    
    left.update();
    right.update();
    up.update();
    down.update();
  }
  
  void pressed() {
    click = true;
    press = true;
    
    if(key == 'a' || keyCode == LEFT) left.pressed();
    if(key == 'd' || keyCode == RIGHT) right.pressed();
    if(key == 'w' || keyCode == UP) up.pressed();
    if(key == 's' || keyCode == DOWN) down.pressed();
  }
  
  void released() {
    release = true;
    press = false;
    
    if(key == 'a' || keyCode == LEFT) left.released();
    if(key == 'd' || keyCode == RIGHT) right.released();
    if(key == 'w' || keyCode == UP) up.released();
    if(key == 's' || keyCode == DOWN) down.released();
  }
}

