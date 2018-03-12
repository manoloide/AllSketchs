import peasy.*;

PeasyCam cam;

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);

  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
}

float det = 0.005;
float time;

void draw() {

  time = millis()/1000.;

  background(100);

  int sca = 2;
  copy(0, 0, width, height, sca, sca, width-sca*2, height-sca*2);

  float w = width*0.6;
  float h = width*0.8;

  int cw = 60; 
  int ch = 80;

  float sw = w/cw;
  float sh = h/ch;

  lights();

  float dx = w*0.5;
  float dy = h*0.5;

  noStroke();
  PVector p = new PVector();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      if ((i+j)%2 == 0) fill(0);
      else fill(255);
      beginShape();
      p = displace(i*sw-dx, j*sh-dy, 0);
      vertex(p.x, p.y, p.z);
      p = displace((i+1)*sw-dx, j*sh-dy, 0);
      vertex(p.x, p.y, p.z);
      p = displace((i+1)*sw-dx, (j+1)*sh-dy, 0);
      vertex(p.x, p.y, p.z);
      p = displace(i*sw-dx, (j+1)*sh-dy, 0);
      vertex(p.x, p.y, p.z);
      endShape(CLOSE);
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

PVector displace(float x, float y, float z) {
  float mx = cos(time*0.2);
  float tx = cos(y*0.01+time)*mx*PI;

  float my = 0;//cos(time*0.19);
  float ty = cos(x*0.006+time*0.2)*my*PI;

  float xx = cos(tx)*x;
  float yy = cos(ty)*y;
  float zz = (sin(ty)+sin(tx))*x;
  zz += noise(x*det, y*det, time*0.2)*40;
  PVector aux = new PVector(xx, yy, zz);
  return aux;
}