int fps = 30;
float seconds = 5;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
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

void render() {

  background(255); 

  translate(width/2, height/2);
  rotate(time*PI);

  int cc = 10; 
  float da = TWO_PI/cc;
  fill(0);
  noStroke();

  float v = 800000;
  Meta m = new Meta(0, 0, v); 
  m.show();
}

class Meta {
  float x, y, v;
  int res;
  Meta(float x, float y, float v) {
    this.x = x; 
    this.y = y; 
    this.v = v; 
    res = 256;
  }

  // v = pi*r*r
  // v/PI = r*r
  // r = sqrt(v/PI);
  void update() {
  }

  void show() {
    float da = TWO_PI/res;
    float r = sqrt(v/PI);
    beginShape();
    for (int i = 0; i < res; i++) {
      PVector p = new PVector(x+cos(da*i)*r, y+sin(da*i)*r);
      p = distord(p);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

PVector distord(PVector ori) {
  PVector aux = ori.copy();
  float det = 0.001;
  aux.mult(noise(ori.x*det, ori.y*det, abs(time-0.5)*3));
  return aux;
}