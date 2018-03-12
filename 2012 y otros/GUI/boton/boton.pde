Boton b1, b2, b3, b4;

void setup() {
  size(400, 400);
  frameRate(60);
  smooth(); 

  background(80);

  b1 = new Boton(10, 10, 20, 20, true, "b1");
  b2 = new Boton(40, 40, 80, 80, true, "b2");
  b3 = new Boton(200, 10, 5, 5, true, "b3");
  b4 = new Boton(220, 210, 100, 100, true, "b4");
}

void draw() {
  b1.act();
  b2.act();
  b3.act();
  b4.act();
}

class Boton {
  float x, y, width, height;
  boolean val,aux;
  String name;

  Boton(float nx, float ny, float nw, float nh, boolean nv, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    val = nv;
    name = n;
    aux = false;
  }

  void act() {
    if (mousePressed && !aux) {
      aux = true;
      if ( mouseX >= x  && mouseX <= x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          if (val) {
            val = false;
          }
          else {
            val = true;
          }
        }
      }
    }
    if (aux && !mousePressed){
       aux = false; 
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+width+2, y+height-2);
  }
}
