class Pulsador {
  float x, y, width, height;
  boolean val;
  String name;

  Pulsador(float nx, float ny, float nw, float nh, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    val = false;
    name = n;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x  && mouseX <= x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          val = true;
        }
      }
    }else{
      val = false;
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

