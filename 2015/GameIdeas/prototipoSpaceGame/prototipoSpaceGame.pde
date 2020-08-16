Input input;
Ship ship;

void setup() {
  size(400, 600);
  input = new Input();
  ship = new Ship(width/2, height/2);
}

void draw() {
  background(10);
  ship.update();
  input.update();
}

void keyPressed(){
  input.pressed();
}

void keyReleased(){
  input.released();
}

