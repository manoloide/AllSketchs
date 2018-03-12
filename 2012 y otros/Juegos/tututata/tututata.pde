ArrayList disparos, malos;
PFont fuente;
int puntos;


void setup() {
  size(400, 400);
  frameRate(60);
  smooth();
  noStroke();
  //
  puntos = 0;
  //fuente
  fuente = loadFont("CenturyGothic-Bold-48.vlw");
  textFont(fuente, 14);
  //listas 
  disparos = new ArrayList();
  malos = new ArrayList();
  for (int i = 0; i < 10; i++){
    malos.add(new Malo(random(400), random(-400,0)));
  }
}

void draw() {
  background(80, 20, 120);
  actDis();
  actMalo();
  fill(80, 120, 20);
  ellipse(width/2, height/2, 20, 20);
  //vision();
  fill(255);
  text(puntos, 4, 14);
}

void mousePressed() {
  disparos.add(new Disparo(width/2, height/2, mouseX, mouseY));
}

