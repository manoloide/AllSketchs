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

  background(0);

  float fov = PI/map(cos(time*TWO_PI), -1, 1, 1.3, 1.8);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);


  translate(width/2, height/2, 0);
  scale(1.4+cos(TWO_PI*time)*0.2);
  rotateX(HALF_PI);
  rotateZ(PI*time);
  rotateY(cos(time*PI)*HALF_PI);

  float detail = 100;
  float detail2 = 200;
  float maxSize = 400;
  float size = 200;
  stroke(255);
  noFill();
  strokeWeight(1);
  float da = TWO_PI/detail2;
  for (float i = 0; i < detail; i++) {
    float det = map(i, 0, detail, 0, TWO_PI); 
    float h = cos(det)*size;
    float r = (maxSize*2.0f + sin(det) * maxSize)*1;
    for (float j = 0; j < detail2; j++) {
      float ang = da*j; 
      point(cos(ang)*r*0.5, sin(ang)*r*0.5, h);
    }
  }
}