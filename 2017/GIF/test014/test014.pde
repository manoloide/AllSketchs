int fps = 30;
float seconds = 4;
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
  translate(width/2, height/2);
  rotateX(-PI*0.1);
  rotateY(PI*time);

  float ss = 240;
  strokeWeight(2);
  noFill();
  rectMode(CENTER);
  pushMatrix();
  float ang = cos(time*TWO_PI)*PI*0.4;
  translate(0, ss*0.5, 0);
  rotateX(HALF_PI);
  rect(0, 0, ss, ss);
  popMatrix();
  pushMatrix();

  rotateY(ang);
  translate(0, -ss*0.5, 0);
  rotateX(HALF_PI);
  rect(0, 0, ss, ss);
  popMatrix();

  for (int j = 0; j < 4; j++) {
    beginShape();
    float r = ss*sqrt(2)*0.5;
    for (int i = 0; i <= ss; i++) {
      float a = HALF_PI*(j+0.5)-map(i, 0, ss, ang, 0);
      vertex(cos(a)*r, i-ss*0.5, sin(a)*r);
    }
    endShape();
  }
}

void line(PVector p1, PVector p2) {
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
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