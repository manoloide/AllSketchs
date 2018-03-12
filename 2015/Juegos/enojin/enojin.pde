import java.util.Collections;

/*
 agregar tiempo de vida
 agregar deltatime
 agregar vida
*/

ArrayList<Entity> entities;
boolean click;
PImage bicho, mbicho;
void setup() {
  size(560, 920);
  bicho = loadImage("bicho1.png");
  bicho.resize(80, 80);
  /*
  mbicho = createImage(80, 80, ARGB);
   mbicho.copy(bicho, 0, 0, 80, 80, 0, 0, 80, 80);
   */
  entities = new ArrayList<Entity>();
}

void draw() {
  if (frameCount%50 == 0) {
    float a = random(TWO_PI);
    float diag = dist(0, 0, width, height)*0.6;
    float x = width/2+cos(a)*diag;
    float y = height/2+sin(a)*diag;
    entities.add(new Bobo(x, y));
  }
  background(120, 180, 220);
  Collections.sort(entities);
  for (int i = 0; i < entities.size (); i++) {
    Entity e = entities.get(i);
    e.update();
    e.show();
    if (e.remove) entities.remove(i--);
  }
  click = false;
}

void mousePressed() {
  click = true;
}

