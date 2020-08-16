int fps = 30;
float seconds = 5;
boolean export = truegif;

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

int seed = 8546; 
void render() {


  int lop = 2; 
  int seeed = seed+floor(time*lop)%lop;

  randomSeed(seeed);
  noiseSeed(seeed);

  float fov = PI/1.70;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  int cc = 11; 
  float ss = width*3.2/cc;
  translate(width/2, height/2, 300+cos(time*TWO_PI*lop+0.1)*80);
  //scale(2);

  float ca = time*TWO_PI*1;
  float camp = 0.3;
  rotateX(cos(ca)*camp);
  rotateY(sin(ca)*camp);
  //rotate(time*TWO_PI);

  float ttt = abs((((time*lop+0.5)%1)*2)-1);
  background(0, 8, 12);
  stroke(255, 0, 20);
  strokeWeight(1.5);
  fill(0, 8, 12);
  //noFill();
  //rectMode(CENTER);
  ArrayList<Quad> quad = new ArrayList<Quad>();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float sss = ss*0.9;//*Easing.ExpoInOut(constrain(map(time, 0, 0.2, 0, 1), 0, 1), 0, 1, 1); 
      Quad q = new Quad((i-cc*0.5)*ss-ss*0.5, (j-cc*0.5)*ss-ss*0.5, sss);
      q.show(ttt);
    }
  }
}  

class Sector {
  ArrayList<Sector> childs; 
  color col;
  float x, y, w, h, d, s; 
  int lvl;
  Sector(float x, float y, float w, float h, float s, int lvl) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    this.s = s;
    this.lvl = lvl;
    this.d = s*int(random(1, min(w/s, h/s)*3));

    col = rcol();

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

  void show(float t) {

    float tt = constrain(map(t, 0.0, 0.4, 0, 1), 0, 1);
    float hh = constrain(map(t, 0.5, 0.95, 0, 1), 0, 1);

    tt = Easing.ExpoInOut(tt, 0, 1, 1);
    hh = Easing.ExpoInOut(hh, 0, 1, 1);

    pushMatrix();
    stroke(col);
    if (childs.size() == 0) {
      translate(x+w*0.5, y+h*0.5, d*0.5*hh);
      box(w*tt, h*tt, d*hh);
      
      /*
      float ss = 10;
      for (int j = 1; j < h/s; j++) {
        for (int i = 1; i < h/s; i++) {
          point(i*ss-w*0.5, j*ss-h*0.5, d*hh);
        }
      }*/
    } else {
      for (int i = 0; i < childs.size(); i++) {
        childs.get(i).show(t);
      }
    }
    popMatrix();
  }
}

class Quad {
  int col;
  float x, y, s;
  Quad(float x, float y, float s) {
    this.x = x;
    this.y = y; 
    this.s = s;
    col = rcol();
  }

  void show(float t) {
    stroke(col);
    rect(x-s*0.5, y-s*0.5, s, s);
    int div = int(random(6, 17));
    float ss = s/div;

    ArrayList<Sector> sectors = new ArrayList<Sector>();
    sectors.add(new Sector(-s*0.5, -s*0.5, s, s, ss, 0));

    int sub = 8;
    for (int i = 0; i < sub; i++) {
      int ind = int(random(sectors.size()));
      sectors.get(ind).sub();
    }

    pushMatrix();
    translate(x, y);

    for (int j = 1; j < div; j++) {
      for (int i = 1; i < div; i++) {
        point(i*ss-s*0.5, j*ss-s*0.5);
      }
    }



    for (int i = 0; i < sectors.size(); i++) {
      sectors.get(i).show(t);
    }

    popMatrix();
  }
}

int colors[] = {#DE2716};//;{#22E337, #31AAE5, #DE1634};

int rcol() {
  return colors[int(random(colors.length))];
}