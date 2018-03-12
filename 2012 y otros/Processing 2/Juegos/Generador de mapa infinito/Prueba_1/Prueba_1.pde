int x, y; 

Pedazo pedazos[][];

void setup() {
  size(600, 600); 
  x = 0; 
  y = 0;
}

void draw() {
  background(0);
  text(x+" "+y,10,20);
}

void keyPressed() {
  switch(keyCode) {
  case DOWN :
    y++;
    break;
  case UP:
    y--;
    break;
  case RIGHT :
    x++;
    break;
  case LEFT:
    x--;
    break;
  }
}

class Pedazo {
  int val;
  Pedazo(int val){
     this.val = val; 
  }
}

