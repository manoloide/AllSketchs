int fps = 30;
float seconds = 12;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  if (!export) pixelDensity(2);
  frameRate(fps);
  background(255);
  generate();
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

void keyPressed() {
  seed = int(random(9999999));
  generate();
}

int seed = 7997663;//int(random(9999999));

void render() {

  randomSeed(seed);

  background(0);
  /*
  float fov = PI/1.6;
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
   */

  lights();

  translate(width/2, height/2);
  rotateX(PI*time);

  noStroke();
  int cc = 200;
  float dw = width*1./cc;
  translate(-width/2-dw, 0);
  for (int i = 0; i <= cc; i++) {
    float dd = i*1./cc;
    translate(dw, 0, 0);
    rotateX(PI*dd);
    float h = dw+abs(sin((time+dd)*PI))*dw*100;
    box(dw, h, dw);
  }
}

void generate() {
  randomSeed(seed);
}

int colors[] = {#FFD52C, #F57839, #7C2FAD, #E0E0E0};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}