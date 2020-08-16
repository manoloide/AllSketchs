int fps = 30;
float seconds = 8;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 1271405; 
void render() {

  float dh = constrain(map(time, 0.4, 0.7, 0, 1), 0, 1);
  float rx = Easing.SineOut(constrain(map(time, 0.4, 0.8, 0, 1), 0, 1), 0, 1, 1);
  float rz = 0; 
  if (time > 0.4) rz = Easing.SineInOut(map(time, 0.4, 1.4, 0, 1), 0, 1, 1);

  float tw = Easing.ExpoIn(constrain(map(time, 0, 0.1, 0, 1), 0, 1), 0, 1, 1);
  float th = Easing.ExpoIn(constrain(map(time, 0, 0.04, 0, 1), 0, 1), 0, 1, 1);
  float tst = constrain(map(time, 0.25, 0.35, 1, 0), 0, 1);
  if (time > 0.95) {
    tw =  Easing.QuintIn(constrain(map(time, 0.95, 1, 1, 0), 0, 1), 0, 1, 1);
    th =  Easing.QuintIn(constrain(map(time, 0.95, 1, 1, 0), 0, 1), 0, 1, 1);
    tw = th;
    dh =  constrain(map(time, 0.95, 1, 1, 0), 0, 1);
  }
  dh = Easing.SineInOut(dh, 0, 1, 1);

  float ts = constrain(map(time, 0.1, 0.3, 0, 1), 0, 1);
  float td = constrain(map(time, 0.5, 0.9, 0, 1), 0, 1);
  td = Easing.QuartOut(td, 0, 1, 1);
  ts = Easing.BounceOut(ts, 0, 1, 1);

  ortho();
  translate(width/2, height/2+dh*height*0.1);
  rotateX(HALF_PI*0.7*rx);
  rotateZ(rz*PI);

  background(255);
  strokeWeight(1.5);

  float ww = tw*0.6*width;
  float hh = th*0.6*height;
  rectMode(CENTER);
  noFill();
  rect(0, 0, ww, hh);
  float ss = (tw+th)*2;
  /*
  fill(0);
   rect(-ww*0.5, -hh*0.5, ss, ss);
   rect(+ww*0.5, -hh*0.5, ss, ss);
   rect(+ww*0.5, +hh*0.5, ss, ss);
   rect(-ww*0.5, +hh*0.5, ss, ss);
   */

  randomSeed(seed);

  //noFill();
  fill(255);
  int div = 16; 
  float sw = ww/div;
  float sh = hh/div;
  float sss = ss*tst;
  
  for (int j = 1; j < div; j++) {
    for (int i = 1; i < div; i++) {
      float xx = (i-div*0.5)*sw;
      float yy = (j-div*0.5)*sh;
      rect(xx, yy, sss, sss);
    }
  }

  Sector s = new Sector(0, 0, ww, hh, sw, 0);
  for (int i = 0; i < 80; i++) {
    s.sub();
  }
  translate(-ww*0.5, -hh*0.5, 0);
  s.show(ts, td);
}

class Sector {
  ArrayList<Sector> childs; 
  float x, y, w, h, d, s; 
  int lvl;
  Sector(float x, float y, float w, float h, float s, int lvl) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    this.d = min(w, h)*int(random(1, random(1, 6)));
    this.s = s;
    this.lvl = lvl;

    childs = new ArrayList<Sector>();
  }

  void sub() {
    if (childs.size() > 0) {
      childs.get(int(random(childs.size()))).sub();
    } else {
      int cw = int(w/s); 
      int ch = int(h/s); 
      if (cw != 1 && ch != 1) {
        if (cw > ch) {
          int pw = int(random(1, cw-1)); 
          float w1 = pw*s;
          float w2 = (cw-pw)*s;
          childs.add(new Sector(x, y, w1, h, s, lvl+1));
          childs.add(new Sector(x+w1, y, w2, h, s, lvl+1));
        } else {
          int ph = int(random(1, ch-1)); 
          float h1 = ph*s;
          float h2 = (ch-ph)*s;
          childs.add(new Sector(x, y, w, h1, s, lvl+1));
          childs.add(new Sector(x, y+h1, w, h2, s, lvl+1));
        }
      }
    }
  }

  void show(float ts, float th) {
    pushMatrix();
    if (childs.size() == 0) {
      translate(x+w*0.5, y+h*0.5, d*0.5*th);
      box(w*ts, h*ts, d*th);
    } else {
      for (int i = 0; i < childs.size(); i++) {
        childs.get(i).show(ts, th);
      }
    }
    popMatrix();
  }
}