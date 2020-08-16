import codeanticode.tablet.*;
import manoloide.Gui.*;
import manoloide.Input.Input;

float mintam, maxtem;
Gui gui;
Input input;
Tablet tablet;
Window window;
PGraphics img;

void setup() {
  size(640, 480);

  tablet = new Tablet(this); 
  input = new Input(this);
  gui = new Gui(this, input);
  window = new Window("Configuracion", 10, 10, 200, 400);
  gui.add(window);
  
  img = createGraphics(width,height);
  img.beginDraw();
  img.background(250);
  img.endDraw();

  background(250);
  stroke(5);
}

void draw() {
  /*
  mouseX = (int) tablet.getPenX();
  mouseY = (int) tablet.getPenY();
  pmouseX = (int) tablet.getSavedPenX();
  pmouseY = (int) tablet.getSavedPenY();*/
  image(img, 0, 0);
  if (mousePressed) {
    //println( tablet.getSavedPenX(), tablet.getSavedPenY(), tablet.getPenX(), tablet.getPenY());
    //line(tablet.getSavedPenX(), tablet.getSavedPenY(), tablet.getPenX(), tablet.getPenY());
    noStroke();
    fill(5);
    lineStroke(img, pmouseX, pmouseY, tablet.getSavedPressure()*20, mouseX, mouseY, tablet.getPressure()*20);
  }
  gui.update();
  gui.draw();
  input.update();
  tablet.saveState();
  tablet.getSavedPressure();
}


void keyPressed(){
  input.event(true);
}

void keyReleased(){
  input.event(false);
}

void mousePressed(){
  input.mpress();
}

void mouseReleased(){
  input.mreleased();
}

void lineStroke(PGraphics p, float x1, float y1, float p1, float x2, float y2, float p2){
  float ang = atan2(y2-y1,x2-x1);
  float anc = 0.9;
  p.noStroke();
  p.fill(5);
  p.beginDraw();
  p.ellipse(x1, y1, p1*anc, p1*anc);
  p.ellipse(x2, y2, p2*anc, p2*anc);
  anc = 0.5;
  p.beginShape();
  p.vertex(x1+cos(ang-PI/2)*p1*anc,y1+sin(ang-PI/2)*p1*anc);
  p.vertex(x1+cos(ang+PI/2)*p1*anc,y1+sin(ang+PI/2)*p1*anc);
  p.vertex(x2+cos(ang+PI/2)*p2*anc,y2+sin(ang+PI/2)*p2*anc);
  p.vertex(x2+cos(ang-PI/2)*p2*anc,y2+sin(ang-PI/2)*p2*anc);
  p.endShape(CLOSE);
  p.endDraw();
}
