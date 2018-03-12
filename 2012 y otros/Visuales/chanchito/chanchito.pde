PImage img1, img2;
boolean lin, cir, ima, ima2, rat, sup, asu;
color fondo;
int fram = 0;
int count = 0;

void setup() {
  size(screen.width, screen.height);
  frameRate(60);
  noCursor();
  lin = true;
  cir = false;
  ima = false;
  ima2 = false;
  sup = false;
  rat = false;
  asu = false;
  fondo = color (0, 255);
  img1 = loadImage("img1.jpg");
  img2 = loadImage("img2.jpg");
  smooth();
}
void draw() {
  count++;
  if (count > fram) {
    noStroke();
    fill(fondo);
    rect(0, 0, width, height);
    if (lin) {
      lineas();
    }
    if (cir) {
      circulos();
    }
    if (ima) {
      imagen();
    }
    if (ima2) {
      imagen2();
    }
    if (rat) {
      ratonsuelo();
    }
    if (sup) {
      superpelotitas();
    }
    if (asu) {
      superpelotitas2();
    }
    count = 0;
  }
}

void keyPressed() {
  if (key == 'l') {
    lin = !lin;
  }
  if (key == 'c') {
    cir = !cir;
  }
  if (key == 'f') {
    background(0);
    fondo = color(random(255), random(255), random(255), random(10));
  }
  if (key == 'o') {
    ima = !ima;
  }
  if (key == 'p') {
    ima2 = !ima2;
  }
  if (key == 'r') {
    rat = !rat;
  }
  if (key == 'i') {
    imagen();
  }
  if (key == 's') {
    sup = !sup;
  }
  if (key == 'a') {
    asu = !asu;
  }
  if (key == '1') {
    fram = 30;
    count = fram;
  }
  if (key == '2') {
    fram = 12;
    count = fram;
  }
  if (key == '3') {
    fram = 6;
    count = fram;
  }
  if (key == '4') {
    fram = 2;
    count = fram;
  }
  if (key == '5') {
    fram = 1;
    count = fram;
  }
}

