int fps = 30;
float seconds = 5;
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
  //lights();
  background(0);

  float fov = PI/1.4;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2); 
  rotateX(time*TWO_PI);
  rotateZ(time*TWO_PI*2);

  float phi = (sqrt(5)+1)/2 - 1; // golden ratio
  float ga = phi*2*PI;           // golden angle

  int cc = 4000;
  float r = 800; 
  stroke(255);
  strokeWeight(2);
  for (int i = 1; i <= cc; i++) {
    float lon = ga*i;
    //lon = lon%TWO_PI;
    lon /= 2*PI; 
    lon -= floor(lon); 
    lon *= 2*PI;
    if (lon > PI)  lon -= 2*PI;
    float lat = asin(-1+2*i/(1.*cc));
    float xx = cos(lat)*sin(lon)*r;
    float yy = cos(lat)*cos(lon)*r;
    float zz = sin(lat)*r;

    point(xx, yy, zz);
  }
}