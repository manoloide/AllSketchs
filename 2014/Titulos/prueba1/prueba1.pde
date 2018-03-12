
int FPS = 60;
PGraphics fondo;

void setup() {
  size(800, 600);
  fondo = createGraphics(width, height);
  crearFondo();
}

void draw() {
  image(fondo, 0, 0);
}
void keyPressed() {
  crearFondo();
}
void crearFondo() {
  fondo.beginDraw();
  fondo.background(#FF0280);
  float diag = dist(0, 0, width, height);
  for (int i = 0; i < 80; i++) {
    float pos = random(diag);
    fondo.strokeWeight(random(1, 20));
    fondo.stroke(250, random(10, 180));
    fondo.line(-2, pos, pos, -2);
  }
  for (int i = 0; i < 120; i++) {
    float tt = random(6, 28);
    float x = random(width);
    float y = random(height);
    fondo.strokeWeight(random(1, 10));
    fondo.stroke(250, random(10, 180));
    fondo.noFill();
    float ttt = tt * random(1, 2);
    fondo.ellipse(x, y, ttt, ttt);
    tt = tt /2;
    fondo.line(x-tt, y-tt, x+tt, y+tt);
    fondo.line(x-tt, y+tt, x+tt, y-tt);
  }
  fondo.endDraw();
}

class Titulo {
  float x, y, w, h, time;
  String txt;
  PFont font;
  PGraphics ctx;
  Titulo(float x, float y, float w, float h, String txt, PFont font) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
    this.txt = txt;
    this.font = font;
  }
  void update(){
      
  }
  
  void draw(){
    
  }
}
