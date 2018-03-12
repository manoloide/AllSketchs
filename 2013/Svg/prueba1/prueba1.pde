BEstrella b1, b2, b3, b4;
PShape estrella;
void setup() {
  size(600, 800);
  estrella = loadShape("estrella.svg");
  b1 = new BEstrella(200, 200, 100);
  b2 = new BEstrella(100, 100, 50);
  b3 = new BEstrella(200, 400, 239);
  b4 = new BEstrella(400, 60, 200);
  println(TWO_PI/80);
}
void draw() {
  background(0);
  b1.act();
  b2.act();
  b3.act();
  b4.act();
}

class BEstrella {
  boolean sobre, press; 
  float x, y, dim, sca, at, ar, ang;
  BEstrella(float x, float y, float dim) {
    this.x = x; 
    this.y = y;
    this.dim = dim;
    sca = dim/100;
    ang = 0;
    at = 0;
    ar = 0;
    sobre = false;
    press = false;
  }
  void act() {
    sobre = false;
    press = false;
    if (dist(mouseX, mouseY, x, y) < dim/2) {
      if (ar < 0.022) {
        ar += 0.001;
      }
      if (at < 0.1) {
        at += 0.01;
      }
      sobre = true;
      if (mousePressed) {
        if (at < 0.2) {
          at += 0.02;
        }
        press = true;
      }
    }
    else {
      if (ar > 0) {
        ar -= 0.001;
      }
      if (at > 0) {
        at -= 0.02;
      }
    }
    ang += ar;
    dibujar();
  }
  void dibujar() {
    estrella.resetMatrix();
    estrella.scale(sca+at);
    estrella.rotate(ang); 
    shape(estrella, x, y);
  }
}

