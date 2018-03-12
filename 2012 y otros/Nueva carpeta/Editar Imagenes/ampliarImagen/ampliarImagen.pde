Boton b1, b2;

PImage img;
PGraphics pg;
int es = 2;

void setup() {
  size(180, 280);

  b1 = new Boton(20, 20, 140, 40, "cargar");
  b2 = new Boton(20, 220, 140, 40, "guardar");
}

void draw() {
  background(80);

  if (img!=null) {
    image(img, 20, 70, 140, 140);
  }
  b1.draw();
  b2.draw();
}

void mousePressed() {
  b1.act();
  b2.act();

  if (b1.press) {
    selectInput("Cargar Imagen", "cargarImage");
  }
  if (b2.press && img!=null) {
    int es = 12;
    int w = img.width*es;
    int h = img.height*es;
    pg = createGraphics(w, h);
    PImage expandida = expandirImage(img, es);
    /*
    pg.beginDraw();
    pg.image(expandida, 0, 0);
    pg.endDraw();
    */
    expandida.save("expandida.png");
  }
}

class Boton {
  float x, y, w, h;
  String name;
  boolean press;
  Boton(float x, float y, float w, float h, String name) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    press = false;
    this.name = name;
  }

  void act() {
    if (sobre()) {
      press = true;
    }
    else {
      press = false;
    }
  }

  void draw() {
    noStroke();
    if (sobre()) {
      if (press) {
        fill(140);
      }
      else {
        fill(120);
      }
    }
    else {
      fill(100);
    }
    rect(x, y, w, h);
    textAlign(CENTER);
    fill(255);
    text(name, x+w/2, y+24);
    press = false;
  }

  boolean sobre() {
    int mx = mouseX;
    int my = mouseY;
    if (mx >= x && mx < x+w && my >= y && my < y+h ) {
      return true;
    }
    else {
      return false;
    }
  }
}

