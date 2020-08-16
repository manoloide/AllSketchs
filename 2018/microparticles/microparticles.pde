import themidibus.*; //Import the library

//AÑADIR OLITAS
// HACER QUE LLEGUEN LOS MENSAJE MIDIS
// ACOMODAR LOS AGUDOS
// AÑADIR UN NOISE DISPLACE GENERAL

//ARMAR FINAL
//MARDAR MAS PARAMETROS

import geomerative.*;

RShape grp;
RShape[] letters;


MidiBus myBus; // The MidiBus

ArrayList<Particle> particles;
float globalTime = 0;

void setup() {
  size(720, 720, P2D);
  pixelDensity(2);
  smooth(8);

  RG.init(this);
  grp = RG.getText("cellule", "font.ttf", 54, CENTER);
  int cc = grp.countChildren();
  letters = new RShape[cc];
  for (int i = 0; i < cc; i++) {
    letters[i] = grp.children[i];
  }

  //MidiBus.list();
  myBus = new MidiBus(this, 0, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  generate();
}

void draw() {

  if (frameCount%20 == 0) addParticle();

  globalTime = millis()*0.001;

  background(200);


  stroke(186);
  for (int i = 0; i < width*2; i+=20) {
    line(-2, i, i, -2);
  }

  calculateRep();

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }

  noStroke();
  fill(186);
  pushMatrix();
  translate(6, 8);
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.show();
  }
  popMatrix();

  noStroke();
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    fill(p.col);
    p.show();
  }

  translate(width*0.5, height*0.5);
  translate(1, 2);
  fill(110, 90, 0);
  water();
  fill(250, 155, 0);
  translate(-1, -2);
  water();
}

void calculateRep() {
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.rx = 0;
    p.ry = 0;
    for (int j = i+1; j < particles.size(); j++) {
      Particle r = particles.get(j);
      p.rep(r);
    }
  }
}

void keyPressed() {
  //generate();
  //addParticle();
  generate();
}

void generate() {
  seed = int(random(9999999));
  particles = new ArrayList<Particle>();
}

class Particle {
  ArrayList<PVector> vertex;
  boolean remove;
  color col;
  float osc, aos, dos;
  float x, y, s, ss;
  float or; 
  float rx, ry;
  float time, lifeTime;
  float iam, am;
  float vel;
  PVector center; 
  Particle(float x, float y) {
    this.x = x;
    this.y = y;

    col = rcol();


    vertex = new ArrayList<PVector>();

    s = random(50, 80);
    lifeTime = random(6, 14);
    time = 0;

    osc = int(random(3, 8));
    aos = random(0.08);
    dos = random(-1., 1)*random(0.2, 1);

    or = random(2, 8);

    iam = random(10000);
    am = random(0.1);
    vel = random(1)*random(0.8);
  }

  void update() {
    time += 1./60; 
    if (time > lifeTime) remove = true;

    float ang = noise(iam+am*time)*TWO_PI*2;

    x += rx;
    y += ry;

    rx = 0; 
    ry = 0;

    float mv = pow(cos(globalTime+time*20)*0.5+0.5, 0.8);
    float dv = vel*(1+mv*0.1);

    x += cos(ang)*dv;
    y += sin(ang)*dv;

    center = dis(x, y);
    if (center.x < -s || center.x > width+s || center.y < -s || center.y > height+s) remove = true;

    ss = s;
    if (time < lifeTime*0.4) ss *= Easing.ExpoOut(map(time, 0, lifeTime*0.4, 0, 1), 0., 1, 1.0);
    else if (time > lifeTime*0.5) ss *= Easing.ExpoOut(map(time, lifeTime*0.5, lifeTime, 1, 0), 0, 1, 1);
    if (time > lifeTime*0.90) {
      float tt = map(time, lifeTime*0.9, lifeTime, 0, 1);
      ss *= (1-tt*0.2)+abs(sin(tt*TWO_PI))*0.2;
    }
    calculeVertex();
  }

  PVector dis(float x, float y) {
    float d1 = 0.008;
    float n1 = noise(x*d1, y*d1, time*0.02)*TWO_PI;
    float a1 = ss*0.2; 
    float d2 = 0.001;
    float n2 = noise(x*d2, y*d2, time*0.02)*TWO_PI;
    float a2 = ss*1.0; 
    //return new PVector(x, y);
    return new PVector(x+cos(n1)*a1+cos(n2)*a2, y+sin(n1)*a1+sin(n2)*a2);
  }

  void calculeVertex() {
    vertex.clear();
    if (ss > 0 && ss < s*2) {
      float r = ss*0.5*(1+sin(time*or)*.06);
      int res = 48;

      float gro = 0.9+cos(time+globalTime*20)*0.01;
      float da = TWO_PI/res;

      for (int i = 0; i < res; i++) {
        float ao = cos(((i*1./res)*osc+time*dos)*TWO_PI)*0.5+0.5;
        float amp = r*(1+pow(ao*aos, 0.8))*gro;
        PVector p = dis(x+cos(da*i)*amp, y+sin(da*i)*amp);
        vertex.add(new PVector(p.x, p.y));
      }
    }
  }

  void show() {
    beginShape();
    PVector p;
    for (int i = 0; i < vertex.size(); i++) {
      p = vertex.get(i%vertex.size());
      vertex(p.x, p.y);
    }
    endShape(CLOSE);

    if (time > lifeTime*0.9) {
      pushStyle();
      float tt = Easing.BounceOut(map(time, lifeTime*0.9, lifeTime, 0, 1), 0, 1, 1);
      float ss = s*tt;
      noFill();
      stroke(g.fillColor);
      strokeWeight(2-tt*2);
      ellipse(center.x, center.y, ss, ss);
      popStyle();
    }
    /*
    color col = g.fillColor;
     PVector a = vertex.get(0);
     PVector p = vertex.get(0);
     PVector c =  dis(x, y);
     for (int i = 1; i <= vertex.size(); i++) {
     p = vertex.get(i%vertex.size());
     beginShape();
     fill(col, 230);
     vertex(a.x, a.y);
     vertex(p.x, p.y);
     fill(col);
     vertex(c.x, c.y);
     endShape(CLOSE);
     a = p;
     }
     fill(col);
     */
  }

  void rep(Particle o) {
    float dis = dist(x, y, o.x, o.y);
    float maxDis = (ss+o.ss)*1.5;
    if (dis < maxDis) {
      float ang = atan2(y-o.y, x-o.x); 

      float rep = 1.-map(dis, 0, maxDis, 0, 1);//Easing.BounceInOut(map(dis, 0, maxDis, 0, 1), 0, 1, 1);
      rep = pow(rep, .8);
      rx += cos(ang)*rep*ss*0.1;
      ry += sin(ang)*rep*ss*0.1;

      o.rx += cos(ang+PI)*rep*o.ss*0.1;
      o.ry += sin(ang+PI)*rep*o.ss*0.1;
    }
  }
}

int seed = int(random(999999));

void water() {

  float tt = (globalTime%10.)/10.;

  float amp = 1;
  if (tt < 0.1) amp = map(tt, 0, 0.1, 0, 1);
  if (tt > 0.8) amp = constrain(map(tt, .9, 0.8, 0, 1), 0, 1);

  //randomSeed(seed);
  noiseSeed(seed);
  float time = millis()*0.001;
  float det = 0.02;
  noStroke();
  for (int j = 0; j < letters.length; j++) {
    RShape shape = letters[j];
    RPoint[] points = shape.getPoints();
    beginShape();
    for (int i = 0; i < points.length; i++) {
      RPoint p = points[i];
      float ang = noise(p.x*det, p.y*det, time)*TWO_PI;
      float dis = noise(p.x*det, p.y*det, time+971) * 3;
      float dd = dis;
      float dx = cos(ang)*dd;
      float dy = sin(ang)*dd;
      float xx = p.x+dx;
      float yy = p.y+dy;
      if (amp < 1) {
        xx = lerp(0, xx, Easing.ElasticOut(amp, 0, 1, 1, 0.1, 10));
        yy = lerp(0, yy, Easing.ElasticOut(amp, 0, 1, 1, 0.2, 20));
      }
      yy *= 1.2;
      vertex(xx, yy);
    }
    endShape(CLOSE);
  }
}

void noteOn(int channel, int pitch, int velocity) {
  addParticle();
}

void addParticle() {
  float ang = random(TWO_PI)+globalTime;
  float amp = random(0.2);
  float px = width*0.5+cos(ang)*width*amp;
  float py = height*0.5+sin(ang)*height*amp;
  particles.add(new Particle(px, py));
}

int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}