ArrayList<Particula> particulas;
PFont font;
float  dmin, dmax;
String name = "";
void setup() {
  size(851, 315);
  font = loadFont("bebas.vlw");
  textFont(font);
  textSize(70);
  textAlign(CENTER, CENTER);
  background(0);
  noStroke();
  blendMode(EXCLUSION);
  particulas = new ArrayList<Particula>();
  dmin = -3;
  dmax = 3;
}

void draw() {
  background(255);
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    aux.act();
    if (aux.eliminar) {
      particulas.remove(i--);
    }
  }

  float alp = 2;
  fill(255, 0, 0);
  text(name, width/2+random(dmin, dmax), height/2+random(dmin, dmax));
  fill(0, 255, 0);
  text(name, width/2+random(dmin, dmax), height/2+random(dmin, dmax));
  fill(0, 0, 255);
  text(name, width/2+random(dmin, dmax), height/2+random(dmin, dmax));
}

void mouseMoved() {
  if (frameCount%2 ==  0) {
    //particulas.add(new Particula(random(90, width-90), -10));
  }
}

void mousePressed() {
  saveFrame(name+".png");
  //particulas = new ArrayList<Particula>();
}

void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (name.length() > 0) {
      name = name.substring(0, name.length()-1);
    }
  }
  else {
    name += key;
  }
  //println(name);
}

class Particula {
  boolean eliminar; 
  float x, y, vel, tam;
  Particula(float x, float y) {
    eliminar = false;
    this.x = x; 
    this.y = y; 
    vel = random(0.1);
    tam = random(8, 32);
  }
  void act() {
    vel += 0.015;
    y += vel; 
    tam -= (0.1);
    if (y > height+tam || tam < 0) {
      eliminar = true;
    }
    dibujar();
  }
  void dibujar() {
    fill(255, 0, 0);
    rect(x-tam/2+random(dmin, dmax), y-tam/2+random(dmin, dmax), tam, tam);
    fill(0, 255, 0);
    rect(x-tam/2+random(dmin, dmax), y-tam/2+random(dmin, dmax), tam, tam);
    fill(0, 0, 255);
    rect(x-tam/2+random(dmin, dmax), y-tam/2+random(dmin, dmax), tam, tam);
  }
}

