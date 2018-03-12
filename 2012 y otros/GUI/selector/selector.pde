Selector s1, s2, s3, s4;

void setup() {
  size(400, 400);
  frameRate(60);
  smooth(); 

  background(80);

  s1 = new Selector(10, 10, 60, 20, 3, 2, "b1");
  s2 = new Selector(40, 40, 400, 80, 5, 1, "b2");
  s3 = new Selector(200, 10, 25, 5, 5, 0, "b3");
  s4 = new Selector(220, 210, 500, 100, 5, 4, "b4");
}

void draw() {
  s1.act();
  s2.act();
  s3.act();
  s4.act();
}

class Selector {
  int cant, val;
  float x, y, width, height;
  boolean aux;
  String name;

  Selector(float nx, float ny, float nw, float nh, int nc, int nv, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    cant = nc;
    val = nv;
    name = n;
    aux = false;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x  && mouseX < x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          val = int((mouseX - x)/(width/cant));
        }
      }
    }
    draw();
  }

  void draw() {
    noStroke();
    for (int i = 0; i < cant; i++) {
      if (val == i) {
        fill(150);
      }
      else {
        fill(120);
      }
      rect(x+(width)/cant*i, y, width/cant, height);
    }
    fill(255);
    text(name, x+2, y+height-4);
  }
}

