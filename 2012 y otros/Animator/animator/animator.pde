ArrayList fotogramas;
boolean press, lop, play;
Boton b1, b2;
color col, fotograma[][];
int cantF, actF, vel;
scrollH scr1, scr2, scr3,scr4;
Selector sel1, sel2;
PFont font;

void setup() {
  size(600, 400);
  frameRate(60);
  noStroke();

  //fuente
  font = loadFont("font.vlw");
  textFont(font);

  //booleans
  press = false;
  lop = true;
  play = true;

  //scroles y gui
  b1 = new Boton(410, 130, 20, 20, play, "play");
  b2 = new Boton(460, 130, 20, 20, lop, "loop");
  scr1 = new scrollH(500, 10, 90, 16, 0, 255, 0, "red");
  scr2 = new scrollH(500, 31, 90, 16, 0, 255, 0, "green");
  scr3 = new scrollH(500, 52, 90, 16, 0, 255, 0, "blue");
  scr4 = new scrollH(500, 73, 90, 16, 0, 255, 255, "alpha");
  sel1 = new Selector(410, 100, 180, 20, 18, 0, "fotograma");
  sel2 = new Selector(410, 160, 120, 20, 6, 2, "velocidad");

  col = color(0);
  actF = 0;
  cantF = 20;
  vel = 0;
  fotogramas = new ArrayList();
  //crear forogramas y ponerlos en blanco
  for (int i = 0; i < cantF; i++) {
    color pro[][] = new color[40][40];
    for (int j = 0; j < 40; j++) {
      for (int k = 0; k < 40; k++) {
        pro[k][j] = color(255,0);
      }
    }
    fotogramas.add(pro);
  }
}

void draw() {
  //fondo 
  background(255);
  //carga fotograma 
  fotograma = (color[][]) fotogramas.get(actF);
  //gui
  gui();
  //dibujar 
  if (press && mouseX < 400 && mouseY < 400 && mouseX >= 0 && mouseY >= 0) {
    fotograma[int(mouseX/10)][int(mouseY/10)] = col;
    fotogramas.remove(actF);
    fotogramas.add(actF, fotograma);
  }
  //grafiocar
  rect(0, 0, 400, 400);
  for (int j = 0; j < 40; j++) {
    for (int i = 0; i < 40; i++) {
      fill(fotograma[i][j]);
      rect(i*10, j*10, 10, 10);
    }
  }
  //actualiza fotograma actual
  actF = sel1.val;
  vel++;
  vel = vel%(sel2.val+1);
  println(vel+ " " + (sel2.val+1));
  if (play && vel == 0) {
    actF++;
    if (actF >= cantF) {
      if (lop) {
        actF = 1;
      }
      else {
        actF = cantF-1; 
        play = false;
      }
    }
    sel1.val = actF;
  }
}

void mousePressed() {
  press = true;
}
void mouseReleased() {
  press = false;
}

