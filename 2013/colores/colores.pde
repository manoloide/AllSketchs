ArrayList<Componente> componentes; 

void setup() {
  size(600, 400);
  componentes = new ArrayList<Componente>();
  componentes.add(new ColorView(200, 80, color(255, 136, 15)));
}

void draw() {
  background(50);
  for (int i = 0; i<componentes.size(); i++){
    Componente aux = componentes.get(i);
    aux.act();
    aux.dibujar();
  }
}

void mousePressed(){
  componentes.add(new Box(mouseX,mouseY));
}

class Componente {
  boolean edit, select, eliminar;
  float x, y, w, h;
  void act() {
  }
  void dibujar() {
  }
}

class Box extends Componente {
  String text; 
  Box(float x, float y){
    this.x = x; 
    this.y = y;
    text = "Hola";
    w = 50;
    h = 26;
    edit = false;
    eliminar = false; 
  }
  void act() {
    if(mouseX >= x && mouseX < x +w && mouseY >= y && mouseY < y+h){
      /*if(e.click){

      }*/
    }
  }
  void dibujar() {
    strokeWeight(2);
    stroke(200);
    fill(160);
    rect(x,y,w,h,2);
    fill(40);
    textAlign(LEFT, CENTER);
    textSize(18);
    text(text, x, y, w, h);
  }
}

class ColorView extends Componente {
  color col;
  Componente in, out;
  ColorView(float x, float y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
    w = h = 60;
  }
  void act() {
  }
  void dibujar() {
    stroke(200);
    strokeWeight(3);
    fill(col);
    rect(x, y, w, h, 5);
    noStroke();
    fill(200);
    rect(x+w/2-4,y-6,8,6);
    rect(x+w/2-4,y+h,8,6);
  }
}
