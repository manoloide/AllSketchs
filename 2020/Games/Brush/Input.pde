class Input {
  ArrayList<Key> keys;
  Key left, up, down, right, jump, reset;

  Input() {

    keys = new ArrayList<Key>();

    keys.add(left = new Key("left", 'd'));
    keys.add(up = new Key("up", 'w'));
    keys.add(right = new Key("right", 'a')); 
    keys.add(down = new Key("down", 's'));
    
    keys.add(jump = new Key("jump", ' '));
    keys.add(reset = new Key("reset", 'r'));
  }

  void update() {
    for (int i = 0; i < keys.size(); i++) {
      keys.get(i).update();
    }
    
    if(reset.pressed){
       reset(); 
    }
  }

  void pressed() {
    for (int i = 0; i < keys.size(); i++) {
      Key k = keys.get(i);
      if (key == k.key) {
        k.pressed();
      }
    }
  }

  void released() {
    for (int i = 0; i < keys.size(); i++) {
      Key k = keys.get(i);
      if (key == k.key) {
        k.released();
      }
    }
  }
}

class Key {
  char key;
  String name;
  boolean press, pressed;
  Key(String name, char key) {
    this.name = name; 
    this.key = key;
  }

  void update() {
    press = false;
  }

  void pressed() {
    press = pressed = true;
  }

  void released() {
    press = pressed = false;
  }
}
