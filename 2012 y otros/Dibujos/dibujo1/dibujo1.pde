ArrayList dibujadores;
PFont font;
Boton b1;
scrollH s1, s2, s3, s4, s5, s6, s7, s8;
Pulsador p1, p2;

void setup() {
  size(600, 800);
  frameRate(60);
  smooth();

  font = loadFont("font.vlw");
  textFont(font);

  s1 = new scrollH(410, 30, 180, 10, 1, 50, 6, "stroke max");
  s2 = new scrollH(410, 50, 180, 10, 0, 30, 5, "variacion color");
  s3 = new scrollH(410, 70, 180, 10, -50, 50, 5, "caida");
  s4 = new scrollH(410, 90, 180, 10, 0, 255, 100, "alpha min");
  s5 = new scrollH(410, 110, 180, 10, 0, 255, 200, "alpha max");
  s6 = new scrollH(410, 130, 180, 10, 0, 20, 2, "movimiento x");
  s7 = new scrollH(410, 150, 180, 10, 0, 255, 0, "s4");
  s8 = new scrollH(410, 170, 180, 10, 0, 255, 0, "s4");

  p1 = new Pulsador(410, 270, 10, 10, "reiniciar");
  p2 = new Pulsador(510, 270, 10, 10, "random");

  b1 = new Boton(410, 290, 10, 10, true, "RGB/HSB");

  iniciar();
}

void draw() {
  Dibujador aux;
  for (int i = 0; i < dibujadores.size(); i++) {
    aux = (Dibujador) dibujadores.get(i);
    aux.act();
  }
  menu();
}

void iniciar() {
  fill(255);
  noStroke();
  rect(0, 0, 400, 800);
  dibujadores = new ArrayList();
  for (int i = 0; i < 100; i++) {
    dibujadores.add(new Dibujador(random(width-200), 0));
  }
}

void menu() {
  noStroke();
  fill(60);
  rect(400, 0, 200, height);
  fill(255);
  text("SUPER PARAMETROS", 410, 15);
  s1.act();
  s2.act();
  s3.act();
  s4.act();
  s5.act();
  s6.act();
  s7.act();
  s8.act();
  p1.act();
  p2.act();
  b1.act();
  if (p1.val) {
    iniciar();
  }
  if (p2.val) {
    s1.val = random(s1.min, s1.max);
    s2.val = random(s2.min, s2.max);
    s3.val = random(s3.min, s3.max);
    s4.val = random(s4.min, s4.max);
    s5.val = random(s5.min, s5.max);
    s6.val = random(s6.min, s6.max);
  }
  if (b1.val) {
    colorMode(RGB,256,256,256);
  }
  else {
    colorMode(HSB,256,256,256);
  }
}

