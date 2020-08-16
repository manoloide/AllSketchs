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
PImage fran;
PImage flowers[];
PImage select[];
PShader aberration, mirror, mosaico;

boolean clearBack = false;
boolean aberrationOn = false;
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

  fran = loadImage("images/fran.png");
  flowers = new PImage[8];
  for (int i = 0; i < 8; i++) {
    flowers[i] = loadImage("images/flower0"+str(i+1)+".png");
  }

  select = new PImage[1];
  select[0] = fran;

  cs = new ColorSchemes(this);

  aberration = loadShader("aberration.glsl");
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

  if (mirrorOn) {
    mirror.set("time", time);
    mirror.set("resolution", float(width), float(height));
    render.filter(mirror);
  }
  if (aberrationOn) {
    aberration.set("time", time);
    aberration.set("resolution", float(width), float(height));
    render.filter(aberration);
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
    select[0] = fran;
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
    select[0] = fran;
  }

  if (key == ' ') visual.reset();
  if (key == 'o') strobe.outIn();
  if (key == 'p') strobe.press();
  if (key == 'b') clearBack = true;
  if (key == 'a') aberrationOn = !aberrationOn;
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

class Visual1 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    noiseSeed(seed);
    randomSeed(seed);

    render.imageMode(CENTER);
    for (int i = 0; i < 20; i++) {
      float ss = cos(time*random(0.2, random(0.5, 3)))*0.5+0.5;
      ss *= height*random(0.2, 0.8);
      render.pushMatrix();
      render.translate(random(width), random(height));
      render.rotate(time*random(-0.1, 0.1));
      render.image(getImage(), 0, 0, ss, ss);
      render.popMatrix();
    }
  }
} 



class Visual2 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    noiseSeed(seed);
    randomSeed(seed);

    render.imageMode(CENTER);
    float tt = random(0.2, random(0.5, 3));
    int seg = int(random(4, 12));
    int div = int(random(1, 5));
    float da = time*random(-0.8, 0.8)*random(1);
    for (int j = 0; j < div; j++) {
      for (int i = 0; i < seg; i++) {
        float ang = map(i, 0, seg, 0, TAU)+da;
        float ss = width*(cos(time*tt)*0.5+0.5)*map(j, 0, 4, 0.1, 0.5);
        float xx = width*0.5+cos(ang)*ss;
        float yy = height*0.5+sin(ang)*ss;
        PImage img = getImage();
        render.pushMatrix();
        render.translate(xx, yy);
        render.image(img, 0, 0, ss, ss);
        render.popMatrix();
      }
    }
  }
} 

class Visual3 extends Visual {
  class Particle {
    boolean remove;
    float x, y, a, s, v; 
    float ic, dc; 
    Particle(float x, float y) {
      this.x = x; 
      this.y = y; 
      this.s = random(2, 180)*random(1);
      v = random(s*0.1)*random(0.1, 1);
      dc = random(20)*random(1)*random(1);
    }
    void update(float det, float time) {
      a = noise(x*det, y*det, time)*TWO_PI*2+random(-0.2, 0.2);
      x += cos(a)*v;
      y += sin(a)*v;

      if (x < -s) x += render.width+s*2;
      if (y < -s) y += render.width+s*2;
      if (x > render.width+s)  x -= render.width+s*2;
      if (y > render.width+s) y -= render.width+s*2;
    }
    void show() {
      render.noStroke();
      //render.tint(cs.getColor(ic+dc*time), 100);
      render.image(getImage(), x, y, s, s);
      //render.noTint();
    }
  }
  ArrayList<Particle> particles;
  void init() {
    particles = new ArrayList<Particle>();
    int cc = int(random(100));
    if (cc < 10) cc = 10;
    for (int i = 0; i < cc; i++) {
      particles.add(new Particle(random(render.width), random(render.height)));
    }
    //background(cs.rcol());
  }

  void reset() {
    seed = int(random(9999999));
    init();
  }

  void update() {
    randomSeed(seed);
    float det = random(0.01);
    float tt = time*random(0.01)*random(1)*random(1);
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).update(det, tt);
    }
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    int sca = int(random(-4, 4));
    render.translate(render.width/2, render.height/2);
    render.rotate(cos(time*random(-0.1, 0.1))*0.1);
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);
    render.translate(-render.width/2, -render.height/2);

    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).show();
    }
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