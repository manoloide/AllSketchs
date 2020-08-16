Level level;
PFont font;

void setup() {
  size(720, 720); 
  pixelDensity(2);
  smooth(8);
  font = createFont("Moon Bold.otf", 40, true);
  textFont(font);
  level = new Level();
}

void draw() {
  background(34);
  level.update();
  level.show();
}

void keyPressed() {
  if (key == 'w' || keyCode == UP) level.player.moved(0, -1);
  if (key == 's' || keyCode == DOWN) level.player.moved(0, +1);
  if (key == 'a' || keyCode == LEFT) level.player.moved(-1, 0);
  if (key == 'd' || keyCode == RIGHT) level.player.moved(+1, 0);
  if (key == 'g') level = new Level();
}
