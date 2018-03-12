ArrayList<Particula> particulas;
color col;

void setup() {
  size(600, 600);
  smooth();
  col = nuevoColor();
  particulas = new ArrayList();
  for (int i = 0; i < 60; i++) {
    particulas.add(new Particula(random(width), random(height)));
    particulas.get(i).setCol(colorComplementario(col));
  }
}

void draw() {
  noStroke();
  fill(col, 5);
  rect(0, 0, width, height);

  for (int i = 0; i < 60; i++) {
    particulas.get(i).act();
  }
  fill(colorComplementario(col));
  ellipse(mouseX, mouseY, 50, 50);
}

void mousePressed() {
  col = nuevoColor();
  for (int i = 0; i < 60; i++) {
    particulas.get(i).setCol(colorComplementario(col));
  }
} 

color colorComplementario(color col) {
  pushStyle();
  colorMode(HSB);
  float h, s, b, a; 
  h = (hue(col)+128)%256;
  s = saturation(col);
  b = brightness(col);
  a = alpha(col);
  color nue = color(h, s, b, a);
  popStyle();
  return nue;
}

color nuevoColor() {
  pushStyle();
  colorMode(HSB);
  int r, g, b; 
  r = int(random(256));
  g = int(random(255-r, 256));
  int inter = (r+g)/2;
  b = int(random(inter-64, inter+64));
  popStyle();
  return color(r, g, b);
}

class Particula {
  float x, y, tam, ang, vel;
  color col;
  Particula(float x, float y) {
    this.x = x;
    this.y = y;
    tam = 4;
    ang = random(TWO_PI);
    vel = random(1, 4);
  }

  void act() {
    mover();
    dibujar();
  }

  void mover() {
    ang += radians(random(-10, 10));
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    x = (x > width+tam)? -tam: x;
    x = (x < -tam)? width+tam: x;
    y = (y > height+tam)? -tam: y;
    y = (y < -tam)? height+tam: y;
  }

  void dibujar() {
    noStroke();
    fill(col);
    ellipse(x, y, tam, tam);
  }

  void setCol(color col) {
    this.col = col;
  }
}

