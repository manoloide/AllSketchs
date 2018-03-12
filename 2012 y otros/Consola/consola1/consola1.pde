String todo = "";

void setup() {
  size(400, 400);
  fill(255);
}

void draw() {
  background(0);
  text(todo, 10, 10);
}

void keyPressed() {
  if (key == '\n' ) {
  } 
  else if (keyCode == BACKSPACE) {
    int lar = todo.length();
    if (lar > 0) {
      todo = todo.substring(0, lar-1);
    }
  }
  else {
    todo += key;
  }
}

