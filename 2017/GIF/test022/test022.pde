int fps = 30;
float seconds = 10;
boolean export = true;

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

int seed = 854651; 
void render() {

  randomSeed(seed);
  noiseSeed(seed);

  int cc = 10; 
  float ss = width*2.8/cc;

  translate(width/2, height/2);
  float tt = abs(time*2-1);
  scale(1+Easing.CubicInOut(tt, 0, 1, 1)*0.6);

  rotateX(PI*(0.18+Easing.CubicInOut(tt, 0, 1, 1)*0.02));
  rotateZ(time*TWO_PI);
  background(#120B0C);
  stroke(#EA8E2B);
  fill(0);
  //noFill();
  //rectMode(CENTER);
  ArrayList<Quad> quad = new ArrayList<Quad>();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      Quad q = new Quad((i-cc*0.5)*ss, (j-cc*0.5)*ss, ss*0.9);
      q.show();
    }
  }
}  

class Sector {
  float x, y, w, h, s; 
  int d;
  Sector(float x, float y, float w, float h, float s) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    this.s = s;
  }

  ArrayList<Sector> sub() {
    ArrayList<Sector> aux = new ArrayList<Sector>();
    int cw = int(w/s); 
    int ch = int(h/s); 
    if (cw == 1) aux.add(new Sector(x, y, w, h, s));
    else {
      if (cw > ch) {
        int pw = int(random(1, cw-1)); 
        float w1 = pw*s;
        float w2 = (cw-pw)*s;
        aux.add(new Sector(x, y, w1, h, s));
        aux.add(new Sector(x+w1, y, w2, h, s));
      } else {
        int ph = int(random(1, ch-1)); 
        float h1 = ph*s;
        float h2 = (ch-ph)*s;
        aux.add(new Sector(x, y, w, h1, s));
        aux.add(new Sector(x, y+h1, w, h2, s));
      }
    }
    return aux;
  }

  void show() {
    float d = min(w, h)*random(1, random(1, 4));
    pushMatrix();
    translate(x+w*0.5, y+h*0.5, d*0.5);
    //rect(x, y, w, h);
    box(w, h, d);
    popMatrix();
  }
}

class Quad {
  float x, y, s;
  Quad(float x, float y, float s) {
    this.x = x;
    this.y = y; 
    this.s = s;
  }

  void show() {
    rect(x, y, s, s);
    int div = int(random(6, 17));
    float ss = s/div;

    ArrayList<Sector> sectors = new ArrayList<Sector>();
    sectors.add(new Sector(0, 0, s, s, ss));

    int sub = 8;
    for (int i = 0; i < sub; i++) {
      int ind = int(random(sectors.size()));
      sectors.addAll(sectors.get(ind).sub());
      sectors.remove(ind);
    }

    pushMatrix();
    translate(x, y);
    /*
    for (int j = 1; j < div; j++) {
     for (int i = 1; i < div; i++) {
     point(i*ss, j*ss);
     }
     }
     */

    for (int i = 0; i < sectors.size(); i++) {
      sectors.get(i).show();
    }
    popMatrix();
  }
}