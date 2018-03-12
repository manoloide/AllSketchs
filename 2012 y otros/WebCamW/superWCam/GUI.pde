void menu() {
  fill(80);
  rect(640, 0, 200, height);
  b1.act();
  s1.act();
  s2.act();
  s3.act();
  s4.act();
  s5.act();
  s6.act();
  s7.act();
  espejar = b1.val;
}

class scrollH {
  float x, y, w, h, max, min, val;
  String name;
  boolean move; 
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
    move = false;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX + 8 >= x + h/2 && mouseX - 8 <= x + w - h/2+ 8 && mouseY > y && mouseY <= y+h) {
        move = true;
      }
    }
    else {
      move = false;
    }
    if (move) {
      float posX = mouseX;
      if (posX < x) {
        posX = x;
      }
      else if (posX > x +w) {
        posX = x + w;
      }
      val = min + (max-min) * ((posX- h/2 - x )/(w - h));
      if (val < min) {
        val = min;
      }
      else if (val > max) {
        val = max;
      }
    }
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, w, h);

    fill(150);
    float pos = x + ((w-h) * (val-min)/(max-min));
    rect(pos, y, h, h);
    fill(255);
    text(name+" "+val, x+2, y+9);
  }
}

class Boton {
  float x, y, width, height;
  boolean val, aux;
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
    if (aux && !mousePressed) {
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
