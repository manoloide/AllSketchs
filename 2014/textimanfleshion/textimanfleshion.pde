ArrayList<Particula> particulas;
PFont helve;
PGraphics aux;
String txt;
String[] palabras;

void setup() {
  size(800, 600);
  particulas = new ArrayList<Particula>();
  //palabras = loadStrings("http://snowball.tartarus.org/algorithms/spanish/voc.txt");
  helve = createFont("Helvetica Bold", 100, true);
  aux = createGraphics(width, height);
  txt = "holaaaa como estas";
}

void draw() {
  //if(frameCount%90 == 0) txt = palabras[int(random(palabras.length))];
  for (int i = 0; i < 1200; i++) {
    float x = random(width);
    float y = random(height);
    if (aux.get(int(x), int(y)) == color(0)) {
      particulas.add(new Particula(x, y));
    }
  }
  aux.beginDraw();
  aux.background(255);
  aux.textAlign(CENTER, CENTER);
  aux.textFont(helve);
  aux.fill(0);
  aux.text(txt, 0, 0, width, height);
  aux.endDraw();
  image(aux, 0, 0);
  //colorMode(HSB, 100, 100, 100, 100);
  //background((frameCount/5)%100, 40, 100);
  background(255);
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    aux.act();
    if (aux.eliminar) particulas.remove(i--);
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("######");
  }
  if (keyCode == BACKSPACE) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  }
  else {
    txt += key;
  }
  //println(name);
}

class Particula {
  boolean eliminar;
  float ix, iy, x, y, ang, tam, cre, tam_max, vel;
  Particula(float x, float y) {
    ix = x;
    iy = y;
    this.x = x;
    this.y = y;
    ang = random(TWO_PI);
    tam = random(2);
    cre = random(1.05, 1.2);
    tam_max = random(2, 8);
    vel = random(0.01, 0.1);
    eliminar = false;
  }
  void act() {
    ang += random(-0.1, 0.1);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    if (cre >= 0)
      tam *= cre;
    else 
      tam -= 0.2;
    if (tam < 0) {
      eliminar = true;
    }
    if (tam > tam_max) {
      cre = -1;
    }
    dibujar();
  }
  void dibujar() {
    /*
    strokeWeight(0.5);
    stroke(100);
    line(ix, iy, x, y);
    */
    noStroke();
    fill(0);
    ellipse(x, y, tam, tam);
  }
}
