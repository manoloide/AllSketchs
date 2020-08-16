/*********************** //<>// //<>//
 + Manoloide 2014.     +
 + Gamboa Naon, Manuel +
 + manoloide.com.ar    +
 + manoloide@gmail.com +
 ***********************/


/*
cosas por hacer:
 picar
 recolectar materiales
 crafteos
 iluminacion
 gui
 
 ideas:
 chat
 rayo
 bugs:
 */

import manoloide.Input.Input;

final String nombre = "Mineria";
final String version = "Alpha 0.1";

Input input;
Jugador j1;
Mundo m;

void setup() {
  size(400, 300);
  noStroke();
  frame.setResizable(true);
  input = new Input(this);

  j1 = new Jugador(32, 32);
  m = new Mundo(128, 128);
}

void draw() {
  background(0);
  if (frameCount%10 == 0) {
    frame.setTitle(nombre + " " + version + " -- FPS: " + frameRate);
  }
  j1.act();
  m.act();
  m.dibujar();
  j1.dibujar();

  noStroke();
  fill(0, 120);
  rect(0, 0, 140, height);
  fill(250);
  for (int i = 0; i < 3; i++) {
    text("mineral"+(i+1)+": "+j1.materiales[i], 10, 20+i*18);
  }
  input.update();
}

void mousePressed() {
  input.mpress();
}

void mouseReleased() {
  input.mreleased();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}
