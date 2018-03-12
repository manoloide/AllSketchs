Nivel n1;
Selector s1;
PFont font;
Pulsador p1, p2;
int w, h, es;

void setup() {
  size(640, 520);
  w = 40;
  h = 30;
  es = 16;
  frameRate(60);
  noStroke();

  font = loadFont("font.vlw");
  textFont(font);

  s1 = new Selector(10, 490, 180, 20, 9, 0, "s1");
  p1 = new Pulsador(200, 500, 10, 10, "S");
  p2 = new Pulsador(220, 500, 10, 10, "L");

  n1 = new Nivel(w, h);
  n1.cargar();
}

void draw() {
  //fondo
  background(0);
  stroke(40);
  for (int i = 1; i < w; i++) {
    line(i*es, 0, i*es, height);
    line(0, i*es, width, i*es);
  }
  //
    if (mousePressed && mouseX > 0 && mouseX < w*es && mouseY > 0 &&  mouseY < h*es) {
    n1.mapa[mouseX/es][mouseY/es] = s1.val;
  }
  //
  n1.draw();
  //menu
  menu();
}


