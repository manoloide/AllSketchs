/*
COSAS A HACER:
 -
 BUG:
 -
 OPTIMIZAR E IDEAS:
 -optimizar colisiones
 -deslizar al moverse
 -agregar aurelola de color
 */

Input input;
Jugador jugador;
Nivel nivel; 
PImage spritesPersonaje[];

void setup() {
  size(800, 600);
  jugador = new Jugador(width/2, height/2);
  nivel = new Nivel(width/40, height/40);
  input = new Input();
  spritesPersonaje = new PImage[8];
  for (int i = 1; i <= 8; i++) {
    spritesPersonaje[i-1] = loadImage("img/E_"+i+".png");
  }
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("GameJam -- FPS: "+frameRate);
  background(53, 52, 52);
  nivel.act();
  jugador.act();

  input.act();
}

void mousePressed() {
  int ax = mouseX/40; 
  int ay = mouseY/40;
  nivel.borraColor(nivel.tiles[ax][ay]);
}

void keyPressed() {
  input.event(true);
  if (key == 'r') {
    nivel.nivelAleatorio();
  }
}


void keyReleased() {
  input.event(false);
}


boolean colisionCua(float x1, float y1, float tam1, float x2, float y2, float tam2) {
  tam1 /= 2.;
  tam2 /= 2.;
  float dis = tam1 + tam2;
  if (abs(x1 - x2) < dis && abs(y1 - y2) < dis) {
    return true;
  }  
  return false;
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}
