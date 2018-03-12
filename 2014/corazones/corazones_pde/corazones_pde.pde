ArrayList<Corazon> corazones;

void setup() {
  size(600,600);
  colorMode(HSB);
  corazones = new ArrayList<Corazon>();
}

void draw() {
  if(frameCount%30 == 0) corazones.add(new Corazon(width/2, height*0.25));
  background(30);
  for(int i = 0; i < corazones.size(); i++){
     Corazon c = corazones.get(i);
     c.act();
     if(c.eliminar) corazones.remove(i--);
  }
}

class Corazon {
  boolean eliminar;
  color col; 
  float x, y,tam;
  Corazon(float x, float y) {
    this.x = x;
    this.y = y;
    this.tam = 0.1;
    col = color(random(20), random(256), random(100,256));
  }
  void act() {
    tam *= 1.018;
    if(tam > 500) eliminar = true;
    dibujar();
  }
  void dibujar() {
    noStroke();
    fill(col);
    beginShape();
    vertex(x, y);
    bezierVertex( x, y-30*tam, x-50*tam, y-30*tam, x-50*tam, y);
    bezierVertex( x-50*tam, y+30*tam, x, y+35*tam, x, y+60*tam );
    bezierVertex( x, y+35*tam, x+50*tam, y+30*tam, x+50*tam, y );  
    bezierVertex( x+50*tam, y-30*tam, x, y-30*tam, x, y );  
    endShape();
  }
}
