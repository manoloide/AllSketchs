int fps = 30;
float seconds = 4;
boolean export = true;

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

  rotateX(-PI*0.25);
  translate(width/2, height/1.2-ss*time, 0);
  rotateY(time*PI);
  noFill();
  stroke(255);
  strokeWeight(2);
  rectMode(CENTER);
  rotateX(HALF_PI);

  //rect(0, 0, ss, ss);
  float r = ss*0.5;
  for (int i = 0; i < 4; i++) {
    float h = 1; 
    if (time < 0.5) {
      h = map(time, 0, 0.5, 0, 1);
    }
    pushMatrix();
    rotateZ(i*HALF_PI);
    translate(ss*0.5, 0, 0);
    //rotateZ(HALF_PI*0.5);
    rotateY(time*PI);
    //tsphere(10);
    line(0, -r, ss, 0, -r, 0);
    line(0, r, ss, 0, r, 0);
    line(0, -r, ss, 0, r, ss);
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