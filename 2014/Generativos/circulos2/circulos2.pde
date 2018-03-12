 //<>//
ArrayList<Cubo> cubos;
color paleta[];
float rotx = PI/4;
float roty = PI/4;

void setup() {
  size(640, 360, P3D);

  paleta = new color[4];
  paleta[0] = color(#F73F09);
  paleta[1] = color(#004D51);
  paleta[2] = color(#008280);
  paleta[3] = color(#00B9B5);

  textureMode(NORMAL);
  cubos = new ArrayList<Cubo>();
  for (int i = 0; i < 40; i++) {
    cubos.add(new Cubo(random(width), random(height), random(1000)));
  }
}

void draw() {
  background(#008280);

  noStroke();
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  scale(90);
  for (int i = 0; i < cubos.size(); i++) {
    pushMatrix();
    cubos.get(i).act();
    popMatrix();
  }
}

class Cubo {
  float x, y, z;
  PImage caras[];
  Cubo(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;
    caras = new PGraphics[6];
    for (int i = 0; i < 6; i++) {
      caras[i] = crearCuadrito(200, 200);
    }
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    translate(x/90, y/90, z/90);
    beginShape(QUADS);
    texture(caras[0]);
    vertex(-1, -1, 1, 0, 0);
    vertex( 1, -1, 1, 1, 0);
    vertex( 1, 1, 1, 1, 1);
    vertex(-1, 1, 1, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(caras[1]);
    vertex( 1, -1, -1, 0, 0);
    vertex(-1, -1, -1, 1, 0);
    vertex(-1, 1, -1, 1, 1);
    vertex( 1, 1, -1, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(caras[2]);
    vertex(-1, 1, 1, 0, 0);
    vertex( 1, 1, 1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex(-1, 1, -1, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(caras[3]);
    vertex(-1, -1, -1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, -1, 1, 1, 1);
    vertex(-1, -1, 1, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(caras[4]);
    vertex( 1, -1, 1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex( 1, 1, 1, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(caras[5]);
    vertex(-1, -1, -1, 0, 0);
    vertex(-1, -1, 1, 1, 0);
    vertex(-1, 1, 1, 1, 1);
    vertex(-1, 1, -1, 0, 1);
    endShape();
  }
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}

PImage crearTexturilla(int w, int h, color col) {
  PImage aux = createImage(w, h, RGB);
  aux.loadPixels();
  for (int i = 0; i < aux.pixels.length; i++) {
    color c = lerpColor(col, color(random(80, 256)), 0.03);
    aux.set(i%w, i/w, c);
  }
  return aux;
}


PGraphics crearCuadrito(int w, int h) {
  PImage f = crearTexturilla(w, h, #F2F2EB);
  PGraphics aux = createGraphics(w, h);
  float ang, dist, tam;
  aux.beginDraw();
  aux.smooth();
  aux.image(f, 0, 0);
  aux.noStroke();
  for (int i = 0; i < 22; i++) {
    tam = random(0.5, 2);
    aux.fill(paleta[int(random(paleta.length))]);
    aux.ellipse(random(w), random(h), tam, tam);
  }
  aux.noFill();
  for (int i = 0; i < 8; i++) {
    ang = random(TWO_PI);
    dist = random(30, 120);
    tam = random(30, 160);
    aux.strokeWeight(random(3, 8));
    aux.stroke(paleta[int(random(paleta.length))]);
    aux.ellipse(80+cos(ang)*dist, 80+sin(ang)*dist, tam, tam);
  }
  aux.endDraw();
  return aux;
}
