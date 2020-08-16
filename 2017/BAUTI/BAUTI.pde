/*
import themidibus.*; //Import the library
 
 MidiBus midi; // The MidiBus
 */

//probar fft
//corregir shader mosaico o borrar
//añadir shaders
//añadir particulas firpo

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

float time;

PImage mask;

void setup() {

  //println(displayWidth, displayHeight);
  size(displayWidth, displayHeight, P2D); 
  noCursor();
  smooth(4);

  render = createGraphics(1024, 600, P2D);

  //MidiBus.list();      |
  //midi = new MidiBus(this, 0, -1); 

  cs = new ColorSchemes(this);

  aberration = loadShader("aberration.glsl");
  mirror = loadShader("mirror.glsl");
  mosaico = loadShader("mosaico.glsl");

  mask = loadImage("data/mask.png");

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

  strobe = new Strobe();
}

void draw() {

  background(0);

  //if (frameCount%20 == 0) frame.setTitle(str(frameRate));

  time = millis()*0.001;
  if (cs.view) {
    cs.show();
  } else {
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
    /*
    if (mosaicoOn) {
     textureMode(NORMAL);
     mosaico = loadShader("mosaico.glsl");
     mosaico.set("time", time);
     mosaico.set("resolution", float(width), float(height));
     filter(mosaico);
     }
     */

    if (aberrationOn) {
      aberration.set("time", time);
      aberration.set("resolution", float(width), float(height));
      render.filter(aberration);
    }
    strobe.update();

    /*
    render.background(0);
     render.strokeWeight(3);
     
     float sw = render.width/10.;
     float sh = render.height/10.;
     render.stroke(255);
     render.noFill();
     for (int j = 0; j < 10; j++) {
     for (int i = 0; i < 10; i++) {
     render.rect(i*sw, j*sh, sw, sh);
     }
     }
     */

    //render.ellipse(render.width/2, height/2, 200, 200);

    render.endDraw();

    image(render, 0, 0, width, height);
    /*
    float dy = 48;
     float x1 = 45; //0 
     float y1 = 29+dy; // 0
     float x2 = 440; // 0.41
     float y2 = 34+dy; //0
     float x3 = 1201; //1
     float y3 = -43+dy; // 0
     float x4 = 1264; // 1
     float y4 = 464+dy; // 0.41
     float x5 = 434; // 0.1
     float y5 = 522+dy; // 1
     float x6 = 0; // 0
     float y6 = 515+dy; // 1
     
     noStroke();
     textureMode(NORMAL);
     beginShape();
     texture(render);
     vertex(x1, y1, 0, 0);
     vertex(x2, y2, 0.42, 0);
     vertex(x5, y5, 0.42, 1);
     vertex(x6, y6, 0, 1);
     endShape();
     
     
     beginShape();
     texture(render);
     vertex(x2, y2, 0.42, 0);
     vertex(x3, y3, 1, 0);
     vertex(x4, y4, 1, 1);
     vertex(x5, y5, 0.42, 1);
     endShape();
     */
  }
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
  void setControl(int num, int val) {
  }
}
/*
void controllerChange(ControlChange change) {
 // Receive a controllerChange
 println();
 println("Controller Change:");
 println("--------");
 println("Channel:"+change.channel());
 println("Number:"+change.number());
 println("Value:"+change.value());
 visual.setControl(change.number(), change.value());
 }
 */

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
    prot = random(-8, 8);
    pamp = 0.8;
    pang = random(0.12);
    psize = 0.1;

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

    float ss = render.height*map(cos(time*psize), -1, 1, 0.05, 0.5);

    render.noStroke();
    render.fill(cs.getColor(time));

    float dd = render.width*random(0.3, 0.5);
    for (int j = -2; j <= 2; j++) {
      for (int i = -2; i <= 2; i++) {
        float ddx = i*dd;
        float ddy = j*dd;
        render.ellipse(xx+ddx, yy+ddy, ss, ss);
      }
    }
  }
  /*
  void setControl(int num, int val) {
   if (num == 0) {
   psca = map(val, 0, 127, -4, 4);
   } else if (num == 1) {
   prot = map(val, 0, 127, -8, 8);
   } else if (num == 2) {
   pamp = map(val, 0, 127, 0, 1.2);
   } else if (num == 3) {
   pang = map(val, 0, 127, 0, 0.2);
   } else if (num == 4) {
   psize = map(val, 0, 127, 0, 0.2);
   }
   }
   */
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
  ArrayList<PImage> image;
  void init() {
    //background(cs.rcol());
    File f = new File(dataPath("lugares/"));
    File[] files = f.listFiles();
    image = new ArrayList<PImage>();
    for (int i = 0; i < files.length; i++) {
      PImage img = loadImage(files[i].getPath());
      if (img != null) image.add(img);
    }
  }

  void reset() {
    seed = int(random(9999999));
  }

  void update() {
  }

  void show() {

    randomSeed(seed);
    noiseSeed(seed);

    render.imageMode(CENTER);
    int cc = int(random(4, 11));
    for (int i = 0; i < cc; i++) {
      float vel = random(0.4);
      float x = render.width*map(noise(i*17.1, time*vel), 0, 1, 0.2, 0.8);
      float y = render.height*map(noise(i*47.13, time*vel), 0, 1, 0.2, 0.8);
      float scl = random(0.1, 2.6)*random(1);
      int img = int(random(image.size()));
      float ic = random(100);
      float dc = random(0.8);
      render.pushMatrix();
      render.translate(x, y);
      render.rotate(time*random(-0.6, 0.6));
      //tint(255);
      render.tint(cs.getColor(ic+dc*time), map(random(1)*random(1), 0, 1, 255, 0));
      render.image(image.get(img), 0, 0, render.width*scl, render.height*scl);
      render.popMatrix();
    }
    render.noTint();
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

    render.background(cs.rcol());

    randomSeed(seed);
    noiseSeed(seed);
    //noiseDetail(1);
    float xx = render.width*0.5;
    float yy = render.height*0.5;
    float ic = random(100)+time*random(10);
    float dc = random(10)*random(1);
    float ps = random(1, 10);
    float ang = noise(time*random(0.5))*TWO_PI;
    render.noStroke();
    int cc = 18;
    render.rectMode(CENTER);
    float det = noise(time*random(0.1))*random(0.01);
    float des = random(0.1)*random(1);
    for (int i = 0; i < cc; i++) {
      float s = pow(map(i, 0, cc, 1, 0), ps);
      render.fill(cs.getColor(ic+dc*i));
      render.rect(xx, yy, render.width*s, render.height*s);
      ang += noise(i*det);
      xx += cos(ang)*render.width*s*des;
      yy += sin(ang)*render.height*s*des;
    }
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
    render.rotate(time*random(-12, 12));
    render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);

    float w = render.width*random(2)*random(1);
    float h = render.height*random(2)*random(1);

    float a1 = time*random(-1, 1);
    float a2 = time*random(-1, 1);
    float a3 = time*random(-1, 1);

    float x = cos(a1)*sin(a2)*cos(a3)*render.width*random(0.5);
    float y = sin(a1)*cos(a2)*cos(a3)*render.width*random(0.5);


    render.noStroke();
    render.rectMode(CENTER);
    render.fill(cs.getColor(time*random(10)), 150);
    render.pushMatrix();
    render.translate(x, y);
    render.rect(0, -h*0.5, w, h);
    render.fill(cs.getColor(time*random(10)), 150);
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
      dc = random(10)*random(1)*random(1)*random(1);
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
      particles.add(new Particle(random(width), random(height)));
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
      fade = map(actTime, 0, 2000, 0, 1);
      fade = constrain(fade, 0, 1);
    } else {
      fade = map(actTime, 0, 2000, 1, 0);
      fade = constrain(fade, 0, 1);
    }
    if (fade > 0) {
      render.fill(0, pow(fade, 1.2)*256);
      //render.rect(0, 0, render.width, render.height);
      render.tint(255, pow(fade, 1.2)*256);
      render.image(mask, 0, 0, render.width, render.height);
      //render.mask(mask);
      render.noTint();
    }
    /*
    if (on) {
     int actTime = int(millis()-lastTime)%time;
     float val = map(actTime, time, 0, 0, 1);
     if (val < 0.1) {
     fill(0);
     rect(0, 0, width, height);
     }
     }
     */
  }
  void press() {
    /*
    long newTime = millis();
     if (newTime-lastTime < 2000) {
     time = int(newTime-lastTime);
     on = true;
     } else {
     on = false;
     }
     lastTime = newTime;
     */
  }
  void outIn() {
    out = !out;
    lastTime = millis();
  }
}