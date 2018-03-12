int fps = 30;
float seconds = 4;
boolean export = false;

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

  background(255);

  float fov = PI/2.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  translate(width/2, height/2);
  rotateX(PI*0.1);
  rotate(time*TWO_PI);

  int cc = 81; 
  float ss = width*5./cc; 

  int ite = 4; 
  float sep = 800;

  int seed = int(time*ite);
  int act = int(time*ite);
  translate(0, 0, -ite*sep*time-sep*0.5);
  //noFill();

  strokeWeight(1);
  float det = 0.1;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      noiseSeed(seed);
      float h1 = sep*act+noise(i*det, j*det)*sep;
      noiseSeed((seed+1)%ite);
      float h2 = sep*(act+1)+noise(i*det, j*det)*sep;

      float t = Easing.QuadInOut((time*ite)%1, 0, 1, 1);
      float h = map(t, 0, 1, h1, h2);
      pushMatrix();
      translate((i-cc*0.5+0.5)*ss, (j-cc*0.5+0.5)*ss, h*0.5);
      box(ss, ss, h);
      popMatrix();
    }
  }
}