Pulsador p1, p2, p3, p4;

void setup() {
  size(400, 400);
  frameRate(60);
  smooth(); 

  background(80);

  p1 = new Pulsador(10, 10, 20, 20, "p1");
  p2 = new Pulsador(40, 40, 80, 80, "p2");
  p3 = new Pulsador(200, 10, 5, 5, "p3");
  p4 = new Pulsador(220, 210, 100, 100, "p4");
}

void draw() {
  p1.act();
  p2.act();
  p3.act();
  p4.act();
}

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


