Punto ps1, ps2;
PGraphics lienzo;

void setup() {
  size(800, 400);
  //frameRate(1);
  ps1 = new Punto(random(width/4), random(height));
  ps2 = new Punto(width-random(width/4), random(height));
  lienzo = createGraphics(width, height);
  lienzo.beginDraw();
  lienzo.background(255);
  lienzo.endDraw();
}

void draw() {
  rectes();
  image(lienzo, 0, 0);
  ellipse(ps1.x, ps1.y, 2, 2);
  ellipse(ps2.x, ps2.y, 2, 2);
}

void mousePressed() {

}

void rectes(){
   Punto p1 = new Punto(random(width+200)-100, random(height+200)-100);
  float al = random(-180, 180);
  float dis = dist(p1.x, p1.y, ps1.x, ps1.y);
  float an1 = random(dis-10);
  dis = dist(p1.x, p1.y, ps2.x, ps2.y);
  float an2 = random(dis-10);
  Punto p4 = new Punto(p1.x, p1.y+al);
  Punto p2 = new Punto(ps1.x, ps1.y);
  Punto p3 = new Punto(ps1.x, ps1.y);
  lienzo.beginDraw();
 // lienzo.stroke(0, random(256));
  //lienzo.line(p1.x, p1.y, ps1.x, ps1.y);
  //lienzo.line(p1.x, p1.y, ps2.x, ps2.y);
  //lienzo.line(p4.x, p4.y, ps1.x, ps1.y);
  //lienzo.line(p4.x, p4.y, ps2.x, ps2.y);
  lienzo.fill(random(56));
  lienzo.triangle(ps1.x,ps1.y,ps2.x,ps2.y,p1.x,p1.y);
  lienzo.triangle(ps1.x,ps1.y,ps2.x,ps2.y,p4.x,p4.y);
  lienzo.fill(random(56)+200);
  lienzo.quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
  p2 = new Punto(ps2.x, ps2.y);
  p3 = new Punto(ps2.x, ps2.y);
  lienzo.fill(random(56)+100);
  lienzo.quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
  lienzo.endDraw(); 
}

class Punto {
  float x, y;
  Punto() {
    x = 0;
    y = 0;
  } 

  Punto(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

