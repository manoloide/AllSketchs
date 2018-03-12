int op = -1;
PFont helve, helveC;
String title = "THE TITLE";
String opciones[] = {
  "Nuevo", "Cargar", "Opciones", "Exit"
};

int state = 0;
int MENU = 0, EDITOR = 1;

int paleta[] = {
  #4693AB, 
  #FFAC4B, 
  #E6614C, 
  #E3E3E3, 
  #50B690
};

void setup() {
  size(800, 600, P3D); 
  smooth(8); 
  helve = createFont("Helvetica Neue Bold", 52, true);
  helveC = createFont("Helvetica Neue Condensed Black", 108, true);
}

void draw() {
  if (state == MENU) {
    drawMenu();
  } else if (state == EDITOR) {
    drawEditor();
  }
}

void drawMenu() {
  background(5);

  translate(width/2, height/2, 10);
  //rotateX(cos(frameCount*0.02)*0.08);
  rotateY(cos(frameCount*0.008)*0.1);
  textFont(helveC);
  textAlign(LEFT, TOP);
  fill(255, 140+cos(frameCount*0.04)*10);
  text(title, 0, -opciones.length/2.*68, -240, 600);
  textFont(helve);
  textAlign(LEFT, TOP);
  for (int i = 0; i < opciones.length; i++) {
    if (i == op) fill(255, 250);
    else fill(255, 140+cos(frameCount*0.04)*10);
    text(opciones[i], 30, (i-opciones.length/2.)*68);
  }
}

void drawEditor() {
  beginShape();
  fill(220);
  vertex(0, 0);
  vertex(width, 0);
  fill(210);
  vertex(width, height);
  vertex(0, height);
  endShape();
}

void keyPressed() {
  if (keyCode == UP) {
    op--;
    if (op < 0) op = opciones.length-1;
  }
  if (keyCode == DOWN) {
    op++;
    if (op >= opciones.length) op = 0;
  }

  if (keyCode == ENTER) {
    if (op == 0) state = EDITOR;
  }
}

