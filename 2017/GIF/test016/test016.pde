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

  randomSeed(40);
  background(255);
  translate(width/2, height/2);

  rotateX(-PI*0.8);

  int cc = 12; 
  float ss = width*0.9;
  float ds = ss/cc; 

  strokeWeight(3);
  for (int i = 0; i < cc; i++) {
    int div = int(pow(2, int(random(2, 8))));
    float da = TWO_PI/div;
    float ang = da*(int(random(-10, 10))*2)*time;
    float amp = map(cos(time*TWO_PI*int(random(0, 5))+random(PI)), -1, 1, random(1), random(1));
    float s = map(i, 0, cc+random(1), ss, 0);
    for (int j = 0; j < div; j++) {
      float a = 0; 
      if (j%2== 0) {
        a = amp;
        fill(0);
      } else {
        a = 1-amp;
        fill(255);
      }
      float a1 = da*(j-a-0.5)+ang; 
      float a2 = da*(j+a-0.5)+ang;
      arc(0, 0, s, s, a1, a2);
    }
  }
}