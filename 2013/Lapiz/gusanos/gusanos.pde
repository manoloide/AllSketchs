ArrayList<Gusano> gusanos; 
float tx, ty, rot;
void setup() {
  size(800, 800);
  background(255);
  gusanos = new ArrayList<Gusano>();
}

void draw() {
  if(frameCount%10 == 0){
     frame.setTitle("FPS: "+frameRate+" Cantidad:"+gusanos.size()); 
  }
  for (int i = 0; i < gusanos.size(); i++) {
    Gusano aux = gusanos.get(i);
    aux.act();
    if(aux.eliminar){
       gusanos.remove(i--); 
    }
  }
}

void mousePressed() {
  gusanos.add(new Gusano(mouseX, mouseY, random(8, 20)));
}

class Gusano {
  boolean eliminar;
  float x, y, tam, ang, vel;
  Gusano(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    ang = random(TWO_PI);
    vel = random(0.6, 1.2);
    eliminar = false;
  }
  void act() {
    tam -= 0.01;
    ang += random(-0.15, 0.15); 
    x += cos(ang)*vel; 
    y += sin(ang)*vel;
    if(tam <= 0){
       eliminar = true;  
    }
    dibujar();
  }
  void dibujar() {
    resetMatrix();
    translate(x, y);
    rotate(ang);
    fill(0, 18);
    stroke(0, 18);
    ellipse(0, 0, tam/3, tam/3);
    rectangulo(-tam/2, -tam/2, tam, tam, 0.8, 1);
  }
}

void rectangulo(float x, float y, float w, float h, float noise, float det) {
  linea(x, y, x+w, y, noise, det);
  linea(x+w, y, x+w, y+h, noise, det);
  linea(x+w, y+h, x, y+h, noise, det);
  linea(x, y+w, x, y, noise, det);
}

void linea(float x1, float y1, float x2, float y2, float noise, float det) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float ax = x1;
  float ay = y1;
  for (int i = 1; i < dis; i+=det) {
    float ra = random(TWO_PI);
    float rd = random(noise);
    float x = x1+cos(ang)*i+cos(ra)*rd;
    float y = y1+sin(ang)*i+sin(ra)*rd;
    line(ax, ay, x, y);
    ax = x;
    ay = y;
  }
}
