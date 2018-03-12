int fps = 30;
float seconds = 4;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  //pixelDensity(2);
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

  background(0);

  float ss = 240; 
  rotateX(-PI*0.2);
  float des = 0; 
  translate(width/2, height/1.5, 0);
  rotateY(time*PI);
  //if (time >= 0.8) rotateY(easeInOut(map(time, 0.8, 1, 0, 1), 0, HALF_PI, 1)); 
  noFill();
  stroke(255);
  strokeWeight(2);
  rectMode(CENTER);
  rotateX(HALF_PI);

  //rect(0, 0, ss, ss);
  float r = ss*0.5;
  for (int i = 0; i < 4; i++) {
    float h = ss; 
    float dd = i*0.0;
    if (time <= 0.4) {
      h = ss*easeInOut(map(time, 0, 0.4, 0, 1), 0, 1, 1);
    }
    if (time >= 0.8) {
      h = ss*easeInOut(map(time, 0.8, 1, 1, 0), 0, 1, 1);
    }
    pushMatrix();
    rotateZ(i*HALF_PI);
    translate(ss*0.5, 0, 0);
    //rotateZ(HALF_PI*0.5);
    float rot = 0; 
    if (time >= 0.4+dd && time < 0.8+dd) rot = ElasticEaseInOut(map(time, 0.4+dd, 0.8+dd, 0, 1), 0, 1, 1)*HALF_PI;
    if (time >= 0.8+dd) rot = HALF_PI;
    rotateY(rot);
    //tsphere(10);
    line(0, -r, h, 0, -r, 0);
    line(0, r, h, 0, r, 0);
    line(0, -r, h, 0, r, h);
    line(0, -r, 0, 0, r, 0);
    popMatrix();
  }
}

float ElasticEaseOut(float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d)==1) return b+c;  
  float p=d*.3f;
  float a=c; 
  float s=p/4;
  return (a*pow(2, -10*t) * sin( (t*d-s)*(2*PI)/p ) + c + b);
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