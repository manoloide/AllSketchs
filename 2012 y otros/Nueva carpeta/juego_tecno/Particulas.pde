class Particula {
  boolean eliminar;
  int x, y, tiempo;
  void act(int x, int y) {
  }
}

class PTexto extends Particula {
  String texto;
  color col;
  float mx, my, ax, ay;
  PTexto(String texto, int x, int y) {
    this.x = x - fchica.tamano(texto)/2;
    this.y = y;
    this.texto = texto;
    eliminar = false;
    col = color(255);
    tiempo = int(random(40, 50));
    //movimiento;
    ax = (random(100) < 50)?random(0.2, 0.7):random(-0.7, -0.2);
    ay = random(-3, -2);
    mx = 0; 
    my = 0;
  }
  void act(int px, int py) {
    //mover;
    ax /= 0.99;
    ay += 0.1;
    mx += ax;
    my += ay;
    tiempo--;
    if (tiempo <= 0) {
      eliminar = true;
    }
    fchica.escribir(texto, int(x+px+mx), int(y+py+my), col);
  }
}

class PPixel extends Particula {
  color col;
  float mx, my, ax, ay;
  PImage pixel;
  PPixel(PImage img, int x, int y) {
    this.x = x -1;
    this.y = y -1;
    eliminar = false;
    col = img.get(int(random(img.width)), int(random(img.height)));
    pixel = createImage(2, 2, ARGB);
    pixel.loadPixels();
    for (int i = 0; i < pixel.pixels.length; i++) {
      pixel.pixels[i] = col;
    }
    pixel.updatePixels();
    tiempo = int(random(30, 40));
    //movimiento;
    ax = (random(100) < 50)?random(0.1, 0.6):random(-0.6, -0.1);
    ay = random(-2, -1);
    mx = 0; 
    my = 0;
  }
  void act(int px, int py) {
    //mover;
    ax /= 0.99;
    ay += 0.1;
    mx += ax;
    my += ay;
    tiempo--;
    if (tiempo <= 0) {
      eliminar = true;
    }
    image(pixel,int(x+px+mx), int(y+py+my));
  }
}

