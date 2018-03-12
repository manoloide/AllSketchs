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
    text(name, x+3, y+height-3);
  }
}
