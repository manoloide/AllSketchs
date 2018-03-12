boolean press;
color col;
float grosor;
scrollH scr1, scr2, scr3, scr4, scr5;
PFont font;

void setup() {
  size(800, 600);
  frameRate(60);

  //fuente
  font = loadFont("font.vlw");
  textFont(font);

  //booleans
  press = false;

  //scroles y gui
  scr1 = new scrollH(700, 10, 90, 16, 0, 255, 0, "red");
  scr2 = new scrollH(700, 31, 90, 16, 0, 255, 0, "green");
  scr3 = new scrollH(700, 52, 90, 16, 0, 255, 0, "blue");
  scr4 = new scrollH(700, 73, 90, 16, 0, 255, 255, "alpha");
  scr5 = new scrollH(610, 100, 180, 16, 1, 30, 1, "grosor");

  col = color(0);
  grosor = 1;
}

void draw() {
  gui();
  if (press && mouseX >= 0 && mouseX <600 && mouseY >= 0 && mouseY <600) {
    stroke(col);
    strokeWeight(grosor);
    line(pmouseX,pmouseY,mouseX,mouseY);
  }
}

void mousePressed() {
  press = true;
}
void mouseReleased() {
  press = false;
}

