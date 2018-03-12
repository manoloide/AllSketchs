/*
agregar:
 -sensibilidad
 -suavizar trazo
 agregado:
 -deshacer
 -mejora opacidad
 -limpiar lienzo
 -guardar imagen
 
 */
ArrayList<PGraphics> lienzo;
boolean menu, dibujar, control;
GUI gui;
int maxDes = 20;
Jugador j; 
PGraphics trazo;

void setup() {
  size(720, 480);
  frameRate(30); 
  control = false;
  dibujar = false;
  menu = true;
  j = new Jugador();
  gui = new GUI(width/2-90, height/2-120, 180, 240);
  lienzo = new ArrayList<PGraphics>();
  lienzo.add(createGraphics(width, height));
  lienzo.get(0).beginDraw();
  lienzo.get(0).background(255);
  lienzo.get(0).endDraw();
  background(10, 10, 10);
}

void draw() {
 //println(frameRate);
  if (menu) {
    gui.act();
    if (gui.limpiar.val) {
      PGraphics aux = createGraphics(width, height);
      aux.beginDraw();
      aux.background(255);
      aux.endDraw();
      lienzo.add(aux);
      if (lienzo.size() > maxDes) {
        lienzo.remove(0);
      }
    }
    if (gui.guardar.val) {
      PGraphics aux = lienzo.get(lienzo.size()-1);
      aux.beginDraw();
      aux.save("lala.png");
      aux.endDraw();
    }
  }
  else {
    if (dibujar) {
      j.act(trazo);
      if (frameCount%1 == 0) {
        image(lienzo.get(lienzo.size()-1), 0, 0);
        tint(255, (gui.alfa/100)*255);
        image(trazo, 0, 0);
        noTint();
      }
    }
  }
}

void mousePressed() {
  if (menu) {
    if (mouseButton == LEFT) {
      if (mouseX < gui.x || mouseX > gui.x+gui.w || mouseY < gui.y || mouseY > gui.y+gui.h) {
        menu = false;
        image(lienzo.get(lienzo.size()-1), 0, 0);
      }
    }
  }
  else {
    if (mouseButton == LEFT) {
      trazo = createGraphics(width, height);
      trazo.beginDraw();
      trazo.noStroke();
      trazo.fill(0, 0);
      trazo.rect(0, 0, width, height);
      trazo.endDraw();
      dibujar = true;
    }
    else if (mouseButton == RIGHT) {
      menu = true;
      dibujar = false;
      image(lienzo.get(lienzo.size()-1), 0, 0);
      fill(0, 240);
      rect(0, 0, width, height);
    }
  }
}

void mouseReleased() {
  if (dibujar) {
    PGraphics aux = createGraphics(width, height);
    PGraphics ori = lienzo.get(lienzo.size()-1);
    ori.loadPixels();
    aux.loadPixels();
    for (int i = 0; i < ori.pixels.length; i++) {
      aux.pixels[i] =  ori.pixels[i];
    }
    aux.updatePixels();
    ori.updatePixels();
    aux.beginDraw();
    aux.tint(255, (gui.alfa/100)*255);
    aux.image(trazo, 0, 0);
    aux.noTint();
    aux.endDraw();
    lienzo.add(aux);
    if (lienzo.size() > maxDes) {
      lienzo.remove(0);
    }
    trazo = null;
    image(lienzo.get(lienzo.size()-1), 0, 0);
  }
  dibujar = false;
}

void keyPressed() {
  if (keyCode == CONTROL) {
    control = true;
  }
  //control = true;
  if (control) {
    if (keyCode == 90 && lienzo.size() > 1) {
      lienzo.remove(lienzo.size()-1);
      image(lienzo.get(lienzo.size()-1), 0, 0);
    }
  }
}

void keyReleased() {
  if (keyCode == CONTROL) {
    control = false;
  }
}

