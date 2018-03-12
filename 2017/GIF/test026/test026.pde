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
    saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 1271405; 
void render() {
  background(#15102C);

  translate(width/2, height/2, -width);
  //rotateY(time*PI);

  float cc = 21; 
  float ss = 600; 

  float tt = 0;
  float dx, dy, dz, ry;
  dx = dy = dz = ry = 0;
  if (time < 0.1) {
    tt = map(time, 0.0, 0.1, 0, 1);
    tt = Easing.CubicInOut(tt, 0, 1, 1);
    dx = -tt*ss;
  } else if (time < 0.2) {
    tt = map(time, 0.1, 0.2, 0, 1);
    tt = Easing.CubicInOut(tt, 0, 1, 1);
    dy = tt*ss;
  } else if (time < 0.3) {
    tt = map(time, 0.2, 0.3, 0, 1);
    tt = Easing.CubicInOut(tt, 0, 1, 1);
    ry = HALF_PI*tt;
  } else if (time < 0.4) {
  } else if (time < 0.6) {
    tt = map(time, 0.4, 0.6, 0, 1);
    tt = Easing.CubicInOut(tt, 0, 1, 1);
    dy = -tt*ss*2;
  } else if (time < 0.7) {
  } else if (time < 1) {
    tt = map(time, 0.7, 1.0, 0, 1);
    tt = Easing.CubicInOut(tt, 0, 1, 1);
    dz = ss*tt*4-tt*4;
  }

  /*
  float pp = abs(tt*2-1);
   float fov = PI/map(pp, 0, 1, 3, 2.2);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */

  translate(dx, dy, dz);
  rotateY(ry);

  noStroke();
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        pushMatrix();
        translate((i-cc*0.5)*ss, (j-cc*0.5)*ss, (k-cc*0.5)*ss);
        box(5);
        popMatrix();
      }
    }
  }
}