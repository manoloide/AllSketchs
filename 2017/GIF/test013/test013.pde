int fps = 30;
float seconds = 6;
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

void render() {
  background(255);
  translate(width/2, height/2.2);
  rotateX(-PI*0.14);
  rotateY(TWO_PI*time);

  float ss = 260; 
  float r = ss*0.5; 

  float h = 1; 
  float amp1 = 0; 
  float amp2 = 0;
  if (time < 0.3) {
    h = easeInOut(map(time, 0, 0.3, 0, 1), 0, 1, 1);
  }
  if (time > 0.82) {
    h = easeInOut(map(time, 0.82, 0.9, 1, 0), 0, 1, 1);
    if (h < 0) h = 0;
  }

  if (time >= 0.2) amp2 = easeInOut(map(time, 0.2, 0.4, 0, 1), 0, 1, 1);
  if (amp2 > 1) amp2 = 1;
  if (time >= 0.5) amp1 = easeInOut(map(time, 0.5, 0.7, 0, 1), 0, 1, 1);
  if (amp1 > 1) amp1 = 1;
  if (time > 0.92) {
    amp1 *= easeInOut(map(time, 0.92, 1, 1, 0), 0, 1, 1);
    amp2 *= easeInOut(map(time, 0.92, 1, 1, 0), 0, 1, 1);
  }

  PVector[] p = new PVector[8];
  p[0] = new PVector(-r*amp1, -r*h, -r*amp1);
  p[1] = new PVector(+r*amp1, -r*h, -r*amp1);
  p[2] = new PVector(-r*amp2, +r*h, -r*amp2);
  p[3] = new PVector(+r*amp2, +r*h, -r*amp2);
  p[4] = new PVector(-r*amp1, -r*h, +r*amp1);
  p[5] = new PVector(+r*amp1, -r*h, +r*amp1);
  p[6] = new PVector(-r*amp2, +r*h, +r*amp2);
  p[7] = new PVector(+r*amp2, +r*h, +r*amp2);

  stroke(0);
  strokeWeight(2);
  line(p[0], p[2]);
  line(p[1], p[3]);
  line(p[4], p[6]);
  line(p[5], p[7]);
  line(p[0], p[1]);
  line(p[2], p[3]);
  line(p[4], p[5]);
  line(p[6], p[7]);
  line(p[0], p[4]);
  line(p[1], p[5]);
  line(p[2], p[6]);
  line(p[3], p[7]);
}

void line(PVector p1, PVector p2) {
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
}

float easeInOut (float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return c/2*t*t*t + b;
  return c/2*((t-=2)*t*t + 2) + b;
}

float BackEaseInOut(float t, float b, float c, float d) {
  float s = 1.70158f;
  if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
  return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
}

float ElasticEaseInOut(float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d/2)==2) return b+c; 
  float p=d*(.3f*1.5f);
  float a=c; 
  float s=p/4;
  if (t < 1) return -.5f*(a*(float)Math.pow(2, 10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )) + b;
  return a*(float)Math.pow(2, -10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )*.5f + c + b;
}