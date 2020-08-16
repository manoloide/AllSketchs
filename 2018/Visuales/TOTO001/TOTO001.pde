/////////////////////////
// manoloide@gmail.com //
// @manoloidee         //
/////////////////////////

/*
Keys: 
 - change visual        (0, 1, 2, 3, 4, 5, 6, 7, 8)
 - change seed visual   (SPACEBAR) 
 - fade in/out          (o)
 - change pallete       (UP DOWN)
 - palleter editor      (e)
 - aberration on/off    (a)
 - clear background     (b)
 - mirror effect on/off (m)
 - velocity up          (+)
 - velocity down        (ç)
 */


import codeanticode.syphon.*;
SyphonServer server;


ArrayList<Visual> visuals;
ColorSchemes cs;
Strobe strobe;
Visual visual;

PGraphics render;
PImage toto;
PImage flowers[];
PImage select[];
PShader aberration, dither, mirror, mosaico;

boolean clearBack = false;
boolean aberrationOn = false;
boolean ditherOn = false;
boolean mirrorOn = false;
boolean mosaicoOn = false;

float time, prevTime, velocity;
boolean syphon = true;

void settings() {
  size(800, 600, P2D);
  PJOGL.profile=1;
}

void setup() {

  if (syphon)
    server = new SyphonServer(this, "FORMICA 001");

  //noCursor();
  smooth(2);

  render = createGraphics(800, 600, P2D);

  toto = loadImage("images/toto.png");
  flowers = new PImage[4];
  for (int i = 0; i < 4; i++) {
    flowers[i] = loadImage("images/toto0"+str(i+1)+".png");
  }

  select = new PImage[1];
  select[0] = toto;

  cs = new ColorSchemes(this);

  aberration = loadShader("aberration.glsl");
  dither = loadShader("dither.glsl");
  mirror = loadShader("mirror.glsl");
  mosaico = loadShader("mosaico.glsl");

  visuals = new ArrayList<Visual>();
  visuals.add(new Visual1());
  visuals.add(new Visual2());
  visuals.add(new Visual3());
  /*
   visuals.add(new Visual4());
   visuals.add(new Visual5());
   visuals.add(new Visual6());
   visuals.add(new Visual7());
   visuals.add(new Visual8());
   */

  for (int i = 0; i < visuals.size(); i++) {
    visuals.get(i).init();
  }
  visual = visuals.get(0);

  velocity = 1;

  strobe = new Strobe();
}

void draw() {

  int newTime = millis();
  time += (newTime-prevTime)*0.001*velocity;
  prevTime = newTime;

  render.beginDraw();
  if (clearBack) {
    render.background(cs.rcol());
    clearBack = false;
  }

  render.pushMatrix();
  render.pushStyle();
  visual.update();
  visual.show();
  render.popStyle();
  render.popMatrix();
  if (ditherOn) {
    dither.set("time", time);
    dither.set("resolution", float(width), float(height));
    render.filter(dither);
  }   
  if (aberrationOn) {
    aberration.set("time", time);
    aberration.set("resolution", float(width), float(height));
    render.filter(aberration);
  } 
  if (mirrorOn) {
    mirror.set("time", time);
    mirror.set("resolution", float(width), float(height));
    render.filter(mirror);
  }
  strobe.update();
  render.endDraw();

  if (syphon) {
    server.sendImage(render);
    image(render, 0, 0, width, height);
  } else {
    image(render, 0, 0);
  }

  if (cs.view) cs.show();
}


void keyPressed() {
  if (key == 'e') cs.view = !cs.view;
  if (key == '1') {
    visual = visuals.get(0);
    visual.reset();
  }
  if (key == '2') {
    visual = visuals.get(1);
    visual.reset();
  }
  if (key == '3') {
    visual = visuals.get(2);
    visual.reset();
  }

  if (keyCode == UP) {
    cs.prev();
  }
  if (keyCode == DOWN) {
    cs.next();
  }

  if (key == 'c') {
    select = new PImage[1];
    select[0] = toto;
  }
  if (key == 'f') {
    if (random(1) < 0.4) {
      select = new PImage[flowers.length];
      for (int i = 0; i < flowers.length; i++) {
        select[i] = flowers[i];
      }
    } else {
      select = new PImage[1];
      select[0] = flowers[frameCount%flowers.length];
    }
  }
  if (key == 'c') {
    select = new PImage[1];
    select[0] = toto;
  }

  if (key == ' ') visual.reset();
  if (key == 'o') strobe.outIn();
  if (key == 'p') strobe.press();
  if (key == 'b') clearBack = true;
  if (key == 'a') aberrationOn = !aberrationOn;
  if (key == 'd') ditherOn = !ditherOn;
  //if (key == 'n') mosaicoOn = !mosaicoOn;
  if (key == 'm') mirrorOn = !mirrorOn;
  if (key == 'ç') velocity -= 0.1;
  if (key == '+') velocity += 0.1;
  if (key == 's') saveFrame("####.png");
  velocity = constrain(velocity, 0, 100);
}

class Visual {
  int seed;
  void init() {
  }
  void reset() {
  }
  void update() {
  }
  void show() {
  }
}



PImage getImage() {
  return select[int(random(select.length))];
}

class Strobe {
  boolean on, out;
  int time, outTime;
  float outValue;
  long lastTime;
  Strobe() {
    out = false;
    lastTime = millis();
    time = 0;
  }
  void update() {
    int actTime = int(millis()-lastTime);
    float fade = 0;
    if (out) {
      fade = map(actTime, 0, 2400, 0, 1);
      fade = constrain(fade, 0, 1);
    } else {
      fade = map(actTime, 0, 2000, 1, 0);
      fade = constrain(fade, 0, 1);
    }
    if (fade > 0) {
      render.fill(0, pow(fade, 1.1)*256);
      render.rect(0, 0, render.width, render.height);
      render.noTint();
    }
  }
  void press() {
  }
  void outIn() {
    out = !out;
    lastTime = millis();
  }
}