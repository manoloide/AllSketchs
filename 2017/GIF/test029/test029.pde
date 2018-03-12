int fps = 30;
float seconds = 8;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
  background(255);
}

void draw() {
  if (export) time = map((frameCount-1), 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {

  randomSeed(4545);

  translate(width/2, height/2);
  background(10);

  int cc = 5; 

  noStroke();
  noFill();
  for (int k = 0; k < cc; k++) {
    float t = (time+k*1./cc)%1;
    float st = 1-pow(abs(t*2-1), 0.8);
    float s = width*2*t*4.0; 

    int sub = int(pow(2, int(random(9))));
    float ss = s/sub; 
    stroke(255*pow(st, 0.8));
    strokeWeight(st);
    for (int i = 0; i <= sub; i++) {
      float v = (i-sub*0.5)*ss;
      line(v, -height/2, v, height/2);
      line(-width/2, v, width/2, v);
      //ellipse(0, 0, s, s);
    }
  }
}