int seed;
PFont font;

void setup() {
  size(600, 500);
  font = createFont("Sawasdee", 80, true);
  thread("generar");
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame(""+seed);
  else thread("generar");
}

void generar() {
  seed = int(random(99999));
  randomSeed(seed);
  PGraphics gra = createGraphics(width, height);
  PGraphics aux = createGraphics(width, height);
  gra.beginDraw();
  gra.background(128);
  gra.rectMode(CENTER);
  gra.noStroke();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float tam = random(20, 120);
    gra.fill(random(10, 160), random(10, 100));
    gra.rect(x, y, tam, tam);
  }
  gra.endDraw();
  gra.tint(#36417C);
  gra.image(gra, 0, 0);
  gra.filter(BLUR, 2.5);
  image(gra, 0, 0);


  gra = createGraphics(width, height);
  aux = createGraphics(width, height);
  aux.beginDraw();
  aux.stroke(255);
  int cant = int(random(90, 200));
  int dd = int(random(2, 20));
  aux.stroke(0, 60);
  for (int i = 0; i < cant; i++) {
    aux.line(-8, i*dd, i*dd, -8);
  }
  aux.endDraw();
  gra.beginDraw();
  gra.image(aux, 0, 0);
  gra.filter(BLUR, 1.8);
  gra.image(aux, 0, 0);
  gra.endDraw();
  image(gra, 0, 0);

  gra = createGraphics(width, height);
  aux = createGraphics(width, height);
  aux.beginDraw();
  aux.rectMode(CENTER);
  aux.noStroke();
  aux.fill(#FCE50F, 200);
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    float tam = random(8, 40);
    aux.rect(x, y, tam, tam);
  }
  aux.endDraw();
  gra.beginDraw();
  gra.image(aux, 0, 0);
  gra.filter(BLUR, 2);
  gra.endDraw();
  image(gra, 0, 0);


  gra = createGraphics(width, height);
  PGraphics aux2 = createGraphics(width, height);
  aux2.beginDraw();
  for (int j = 0; j < 3; j++) {
    aux = createGraphics(width, height);
    aux.beginDraw();
    aux.stroke(255);
    aux.strokeWeight(2);
    aux.noFill();
    for (int i = 0; i < 50; i++) {
      float x = random(width);
      float y = random(height);
      float tam = random(10, 50);
      aux.line(x-tam/2, y, x+tam/2, y);
      aux.line(x, y-tam/2, x, y+tam/2);
      aux.ellipse(x, y, tam*1.2, tam*1.2);
    }
    aux.endDraw();
    gra.beginDraw();
    gra.tint(255, 110, 140);
    gra.image(aux, 0, 0);
    gra.filter(BLUR, 3);
    gra.tint(255, 140, 180);
    gra.image(aux, 0, 0);
    gra.endDraw();
    aux2.filter(BLUR, 0.05);
    aux2.image(gra, 0, 0);
  }
  aux2.endDraw();
  image(aux2, 0, 0);
  //filter(BLUR, 1.2);
  gra = createGraphics(width, height);
  aux = createGraphics(width, height);
  aux.beginDraw();
  aux.textFont(font);
  aux.textAlign(CENTER, CENTER);
  aux.fill(#FCE50F);
  for (int i = 0; i < 6; i++) {
    float x = random(width);
    float y = random(height);
    float tam = int(random(2, 4)*20);
    aux.textSize(tam);
    aux.text("Neon", x, y);
  }
  aux.endDraw();
  gra.beginDraw();
  gra.image(aux, 0, 0);
  gra.filter(BLUR, 4);
   gra.image(aux, 0, 0);
  gra.filter(BLUR, 3);
  gra.image(aux, 0, 0);
  gra.endDraw();
  image(gra, 0, 0);
}

PGraphics copiar(PGraphics ori) {
  PGraphics aux; 

  aux = createGraphics(ori.width, ori.height); 
  aux.loadPixels(); 
  arrayCopy(ori.pixels, aux.pixels); 
  aux.updatePixels();
  return aux;
}

