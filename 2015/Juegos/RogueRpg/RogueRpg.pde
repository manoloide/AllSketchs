/*
- añadir trompada
 - añadir enemigo 
 - añadir experiencia
 - añadir levelups
 */

Camera camera;
Level level;
PGraphics render;
PImage sprites;
Player player;

void setup() {
  size(600, 600);
  sprites = loadImage("sprites.png");
  camera = new Camera(0, 0);
  level = new Level();
  player = new Player(100, 100);

  render = createGraphics(width/2, height/2);
  noSmooth();
}

void draw() {
  player.update();
  camera.setTarget(player.x, player.y);
  camera.update();
  level.update();
  level.show();
  player.show();
  image(render, 0, 0, width, height);
}

void keyPressed() {
  player.press();
}

void keyReleased() {
  player.release();
}

