int fps = 30;
float seconds = 5;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
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

  float fov = PI/1.6;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2, 0);
  rotateX(time*TWO_PI);
  rotateZ(time*TWO_PI);
  //rotateY(time*HALF_PI);

  background(0);
  strokeWeight(2);
  stroke(255);
  noFill();
  box(800);
}