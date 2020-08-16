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
    server = new SyphonServer(this, "Processing Syphon");

  //noCursor();
  smooth(2);

  render = createGraphics(800, 600, P2D);

  cs = new ColorSchemes(this);

  aberration = loadShader("aberration.glsl");
  mirror = loadShader("mirror.glsl");
  mosaico = loadShader("mosaico.glsl");

  visuals = new ArrayList<Visual>();
  visuals.add(new Visual1());
  visuals.add(new Visual2());
  visuals.add(new Visual3());
  visuals.add(new Visual4());
  visuals.add(new Visual5());
  visuals.add(new Visual6());
  visuals.add(new Visual7());
  visuals.add(new Visual8());

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
  if (key == '4') {
    visual = visuals.get(3);
    visual.reset();
  }
  if (key == '5') {
    visual = visuals.get(4);
    visual.reset();
  }
  if (key == '6') {
    visual = visuals.get(5);
    visual.reset();
  }
  if (key == '7') {
    visual = visuals.get(6);
    visual.reset();
  }
  if (key == '8') {
    visual = visuals.get(7);
    visual.reset();
  }
  if (keyCode == UP) {
    cs.prev();
  }
  if (keyCode == DOWN) {
    cs.next();
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
  velocity = constrain(velocity, 0, 100);

  if (key == 's') saveFrame("####.png");
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

  float psca, prot, pamp, pang, psize;
  void show() {

    noiseSeed(seed);
    randomSeed(seed);


    psca = random(-4, 4);
    prot = random(-2, 2);
    pamp = 0.8;
    pang = random(0.12);
    psize = random(0.1);

    int sca = int(psca);
    render.translate(render.width/2, render.height/2);
    render.rotate(time*prot);
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);

    float amp = render.width*map(cos(time*pamp), -1, 1, 0, 0.3);
    float ang = time*TWO_PI*pang;

    float dx = cos(ang)*amp;
    float dy = sin(ang)*amp;

    float xx = dx;
    float yy = dy;

    render.noStroke();
    render.fill(cs.getColor(time));

    int cc = 8;//int(random(10));
    float dd = render.width*2./cc;
    float ss = dd*map(cos(time*psize), -1, 1, 0.05, 0.8)*random(0.6, 1);

    for (int j = -1; j < cc; j++) {
      for (int i = -1; i < cc; i++) {
        float ddx = (i-cc*0.5)*dd;
        float ddy = (j-cc*0.5)*dd;
        render.ellipse(xx+ddx, yy+ddy, ss, ss);
      }
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

    int sca = int(random(-8, 9));
    float dx = random(0.3, 0.7);
    float dy = random(0.3, 0.7);
    render.translate(render.width*dx, render.height*dy);
    render.rotate(time*cos(time*random(-0.02, 0.02))*0.1);
    //translate(-width/2, -width/2);
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);

    noiseSeed(seed);
    randomSeed(seed);

    float ss = map(cos(time*random(1)), -1, 1, 20, 100);
    int cw = int(render.width/30);
    int ch = cw;//int(height/ss);
    float det = random(100);
    //stroke(0, 10);
    render.noStroke();
    render.rectMode(CENTER);
    for (int j = -ch; j < ch; j++) {
      for (int i = -cw; i < cw; i++) {
        float amp = constrain(map(noise(i*det, j*det, time*random(2.)*random(1)), 0, 1, -0.2, 1), 0, 1);
        //amp = 1;
        float ic = random(100);
        float dc = random(10);
        render.fill(cs.getColor(ic+dc*time));
        render.rect(i*ss, j*ss, ss*amp, ss*amp);
      }
    }
  }
}  

class Visual3 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    render.fill(0, 20);
    render.rect(0, 0, render.width, render.height);

    randomSeed(seed);
    noiseSeed(seed);

    float ss = width*random(0.04, 0.3);

    int cw = int(render.width/ss)+1;
    int ch = int(render.height/ss)+1;

    int min = int(random(min(cw, ch)*0.5));

    render.translate(render.width*0.5, render.height*0.5);

    float dx = -cw*ss*0.5;
    float dy = -ch*ss*0.5;
    for (int j = min; j < ch-min; j++) {
      for (int i = min; i < cw-min; i++) {
        render.noStroke();
        render.fill(cs.getColor(time*random(10)));
        //render.rect(i*ss+dx, j*ss+dy, ss, ss);
        float aw = noise(time*random(1));
        float ah = noise(time*random(1));
        float mdx = map(cos(time*random(20)*random(1)), -1, 1, 0, ss*(1-aw));
        float mdy = map(cos(time*random(20)*random(1)), -1, 1, 0, ss*(1-ah));
        render.fill(cs.getColor(time*random(20)*random(0.2, 1)));
        render.rect(i*ss+dx+mdx, j*ss+dy+mdy, ss*aw, ss*ah);
      }
    }
  }
}  

class Visual4 extends Visual {
  void init() {
    //background(cs.rcol());
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    int sca = int(random(-8, 9));
    float dx = random(0.3, 0.7);
    float dy = random(0.3, 0.7);
    render.pushMatrix();
    render.translate(render.width*dx, render.height*dy);
    render.rotate(time*cos(time*random(-0.02, 0.02))*0.1);
    render.popMatrix();
    //translate(-width/2, -width/2);
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);

    randomSeed(seed);
    noiseSeed(seed);
    noiseDetail(2);

    float ss = render.width*(random(0.15, 0.3)+map(cos(time*random(10)*random(1)), -1, 1, 0.02, 1));

    int res = 100;
    float da = TWO_PI/res;

    float des = random(10000)+time*random(0.2)*random(10);
    float det = random(0.5);

    render.translate(render.width*0.5, render.height*0.5);

    render.noStroke();
    render.fill(cs.getColor(time*random(2)*random(1)));
    float sss = cos(time*random(20))*render.width*0.06;
    render.ellipse(0, 0, sss, sss);

    render.noStroke();
    float str = random(1, 120);
    render.beginShape();
    render.fill(cs.getColor(time*random(0.01, 3)));
    for (int i = 0; i <= res; i++) {
      float a = da*i;
      float d = ss*noise(des+cos(a)*det, des+sin(a)*det);
      render.vertex(cos(a)*d, sin(a)*d);
    }
    for (int i = res; i >= 0; i--) {
      float a = da*i;
      float d = ss*noise(des+cos(a)*det, des+sin(a)*det)+str;
      render.vertex(cos(a)*d, sin(a)*d);
    }
    render.endShape(CLOSE);
  }
}


class Visual5 extends Visual {
  void init() {
    //background(cs.rcol());
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    int sca = int(random(-20, 10*random(1)));
    render.translate(render.width/2, render.height/2);
    render.rotate(time*random(-1, 1));
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);

    float w = render.width*random(1, 2.6)*random(0.6, 1);
    float h = w*random(0.01, random(0.1, 0.2));

    float vel = random(0.1, 2);
    float a1 = time*random(-1, 1)*vel;
    float a2 = time*random(-1, 1)*vel;
    float a3 = time*random(-1, 1)*vel;

    float x = cos(a1)*sin(a2)*cos(a3)*render.width*random(0.2, 0.6);
    float y = sin(a1)*cos(a2)*cos(a3)*render.width*random(0.2, 0.6);


    render.noStroke();
    render.rectMode(CENTER);
    render.fill(cs.getColor(time*random(10)*random(0.5, 1)), 150);
    render.pushMatrix();
    render.translate(x, y);
    render.rect(0, -h*0.5, w, h);
    render.fill(cs.getColor(time*random(10)*random(0.5, 1)), 150);
    render.rect(0, +h*0.5, w, h);
    render.popMatrix();
  }
} 



class Visual6 extends Visual {
  class Particle {
    boolean remove;
    float x, y, a, s, s1, s2, v; 
    float ms, ma;
    float ic, dc; 
    Particle(float x, float y) {
      this.x = x; 
      this.y = y; 
      this.a = random(TWO_PI); 
      this.s1 = random(2, 150)*random(1);
      this.s2 = random(2, 150)*random(1);
      ms = random(1);
      ma = random(0.2);
      v = random(s1)*random(0.2);
      ic = random(100);
      dc = random(3)*random(1)*random(1)*random(1);
      remove = false;
    }
    void update() {
      a += random(-ma, ma);
      s = map(cos(time*ms), -1, 1, s1, s2);
      x += cos(a)*v;
      y += sin(a)*v;
      ic += dc;

      if (x < -s) x += render.width+s*2;
      if (y < -s) y += render.height+s*2;
      if (x > render.width+s)  x -= render.width+s*2;
      if (y > render.height+s) y -= render.height+s*2;
    }
    void show() {
      render.noStroke();
      render.fill(cs.getColor(ic));
      render.ellipse(x, y, s, s);
    }
  }
  ArrayList<Particle> particles;
  void init() {
    particles = new ArrayList<Particle>();
    int cc = int(random(300));
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
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).update();
    }
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).show();
    }
  }
} 

class Visual7 extends Visual {
  class Particle {
    boolean remove;
    float x, y, a, s, v; 
    float ic, dc; 
    Particle(float x, float y) {
      this.x = x; 
      this.y = y; 
      this.s = random(2, 20)*random(1);
      v = random(s*0.4)*random(0.1, 1);
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
      render.fill(cs.getColor(ic+dc*time), 100);
      render.ellipse(x, y, s, s);
    }
  }
  ArrayList<Particle> particles;
  void init() {
    particles = new ArrayList<Particle>();
    int cc = int(random(1800));
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


class Visual8 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
    init();
  }

  void update() {
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    int sca = int(random(-20, 20));
    float dd = random(20);
    int dx = int(random(dd)-dd*0.5);
    int dy = int(random(dd)-dd*0.5);
    render.pushMatrix();
    render.translate(render.width*0.5, render.height*0.5);
    render.rotate(time*random(-1, 1));
    render.copy(dx, dy, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);
    render.popMatrix(); 

    float diag = dist(0, 0, render.width, render.height);

    render.noStroke();
    render.fill(0, random(30));
    render.rect(0, 0, render.width, render.height);

    int sub = int(random(5, random(5, 100)));
    float ss = diag*1./sub;
    float amp = random(0.1, 0.95)*random(0.5, 1);
    float des = (time*random(60))%ss;
    float hh = render.height*random(0.8, 3);

    float ic = time*random(100)*random(0.1);
    float dc = random(1)*random(1)*random(1);
    render.translate(render.width*0.5, render.height*0.5);
    render.rotate(time*random(-1, 1));
    for (int i = -1; i < sub+1; i++) {
      render.fill(cs.getColor(ic+dc*i));
      render.rect((i-sub*0.5)*ss+des, -hh*0.5, ss*amp, hh);
    }
  }
} 

class Visual9 extends Visual {
  void init() {
  }

  void reset() {
    seed = int(random(9999999));
    init();
  }

  void update() {
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    int sca = int(random(-20, 20));
    float dd = random(20);
    int dx = int(random(dd)-dd*0.5);
    int dy = int(random(dd)-dd*0.5);
    render.translate(render.width*0.5, render.height*0.5);
    render.rotate(time*random(-1, 1));
    render.copy(dx, dy, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);
    render.translate(-render.width*0.5, -render.height*0.5);

    float diag = dist(0, 0, render.width, render.height);

    render.noStroke();
    render.fill(0, random(30));
    render.rect(0, 0, render.width, render.height);

    int sub = int(random(5, random(5, 100)));
    float ss = diag*1./sub;
    float amp = random(0.05, 0.95)*random(1);
    float des = (time*random(60))%ss;

    float ic = time*random(100)*random(0.1);
    float dc = random(1)*random(1)*random(1);
    for (int i = 0; i < sub+1; i++) {
      render.fill(cs.getColor(ic+dc*i));
      render.rect(i*ss+des, 0, ss*amp, render.height);
    }
  }
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