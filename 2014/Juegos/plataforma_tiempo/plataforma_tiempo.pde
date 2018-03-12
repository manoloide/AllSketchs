Input input;
Nivel nivel;

void setup(){
   size(800,600); 
   nivel = new Nivel();
   input = new Input();
}

void draw(){
  input.act();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

void mousePressed(){
   input.mEvent(true);
}

void mouseReleased(){
   input.mEvent(false); 
}

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
  boolean press, click;
  Key SALTAR, IZQUIERDA, DERECHA; 
  Input() {
    SALTAR = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
  }
  void act() {
    click = false;
    SALTAR.act();
    IZQUIERDA.act();
    DERECHA.act();
  }
  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) SALTAR.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
  }
  void mEvent(boolean estado){
     if(estado){
        if(!press) click = true;
        press = true;
     }else{
        press = false;
     } 
  }
}
