import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

PeasyCam cam;
void setup() {
  size(1280, 720, P3D);
  smooth(4);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
}

float time;
void draw() {

  time = millis()*0.001;

  background(240);

  lights();
  noStroke();

  float w = width*0.40;
  float h = height*0.40;
  fill(250);
  pushMatrix();
  translate(0, 0, -6);
  box(w, h, 10);
  popMatrix();

  grid(w-30, h-30, 10, 2);

  cam.beginHUD();
  cam.endHUD();
}

void grid(float w, float h, float d, float sep) {
  int cw = int(w/sep);
  int ch = int(h/sep);
  float det = 0.008;
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float xx = i*sep-w*0.5;
      float yy = j*sep-h*0.5;
      float noi = (float) SimplexNoise.noise(xx*det, yy*det, time*0.02)*0.5+0.5;
      noi = pow(noi, 1.8);
      float v1 = (1-abs(j-ch*0.5)/(ch*0.5))*2;
      float v2 = (1-abs(i-cw*0.5)/(cw*0.5))*2;
      float dd = d*(noi*2*(cos(time+i*0.1)*0.5+0.5)*v1*v2);//*(1+noi);

      strokeWeight(noi*14);
      stroke(getColor(sqrt(noi)*3));
      point(xx, yy, dd);
    }
  }
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#C8CBF4, #EA77BA, #EA0071, #F71D04, #301156, #ffff00};
int colors[] = {#EE371D, #4F4EB7, #1C1E4E, #EC3789, #E7CCB2};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor() {
  return getColor(random(colors.length));
}

int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
