import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

int seed = int(random(999999));

float nwidth =  1280; 
float nheight = 720;
float swidth = 960; 
float sheight = 540;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  //cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    //generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() {

  float time = millis()*0.00005;
  float ntime = (time%40)/40.;

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  background(250);
  
  scale(scale);

  int sep = 4; 
  int cw = int(width*1./sep);
  int ch = int(height*1./sep);

  float detAng = random(0.0005, 0.001)*0.5;
  float desAng = random(10000);


  float amp = sin(pow(ntime, 0.2)*PI);

  strokeWeight(2);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x = (i+(j%2)*0.5)*sep; 
      float y = j*sep;
      noStroke();
      //ellipse(x, y, sep*0.1, sep*0.1);
      float a = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng, ntime*ntime*0.2d)*TAU*4;
      stroke(0, 220);
      float dd = sep*5*amp;
      line(x, y, x+cos(a)*dd, y+sin(a)*dd);
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void lineStr(float x1, float y1, float x2, float y2, float str1, float str2) {
  beginShape();
  float ang = atan2(y1-y2, x1-x2)+HALF_PI;
  vertex(x1+cos(ang)*str1, y1+sin(ang)*str1);
  vertex(x1+cos(ang+PI)*str1, y1+sin(ang+PI)*str1);
  vertex(x2+cos(ang+PI)*str2, y2+sin(ang+PI)*str2);
  vertex(x2+cos(ang)*str2, y2+sin(ang)*str2);
  endShape();
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
