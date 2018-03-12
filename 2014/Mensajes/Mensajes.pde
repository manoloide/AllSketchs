Mensaje msj;
PFont helve;
PImage fondo;

void setup() {
  size(600, 800);
  helve = createFont("Helvetica Neue Bold", 48, true);
  fondo = crearDegrade(width, height, #A3F1F8, #2BBFBF);
  msj = new Mensaje(50, 50, 280, 220);
}

void draw() {
  image(fondo, 0, 0);
  msj.act();
}

void mousePressed() {
  msj.tiempo = 0;
}

class Mensaje {
  int x, y, w, h, tiempo;
  PGraphics img, mask;
  Mensaje(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    tiempo = 0;
    img = createGraphics(w, h);
    mask = createGraphics(w, h);
  }
  void act() {
    x = mouseX;
    y = mouseY;
    tiempo++;
    dibujar();
  }
  void dibujar() {
    img.beginDraw();
    img.background(0, 0);
    img.stroke(255);
    for (int i = 0; i < 40; i++) {
      img.strokeWeight((tiempo+(40-i)*5)/20.);
      img.line(-10, tiempo*3-20*i, tiempo*3-20*i, -10);
    }
    img.endDraw();
    mask.beginDraw();
    mask.background(0);
    mask.fill(255);
    mask.textFont(helve);
    mask.text("bastaaa\nno jodas", 22, 60);
    mask.endDraw();
    img.mask(mask);
    image(img, x, y);
  }
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
      aux.set(i, j, c);
    }
  }
  return aux;
}
