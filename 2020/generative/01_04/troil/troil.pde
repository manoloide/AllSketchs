import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  int cc = int(random(4, 9*random(1)));
  float sw = width*1./(cc+1);
  float sh = height*1./(cc+1);

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+0.5)*sw;
      float yy = (j+0.5)*sh;
      fill(rcol());
      noStroke();
      //if (random(1) < 0.9) rect(xx, yy, sw, sh);

      strokeWeight(2);
      stroke(0);
      int rnd = 1;//int(random(2));
      int div = 10;//int(random(20)*random(1)*random(1));
      for (int k = 0; k < div; k++) {
        if (random(1) < 0.5) continue;
        float v = 1-k*1./div; 
        fill(rcol());
        if (rnd == 0) {
          if (random(1) < 0.5) {
            if (random(1) < 0.5) {
              arc(xx, yy, sw*v*2, sh*v*2, 0, HALF_PI);
            } else {
              arc(xx+sw, yy, sw*v*2, sh*v*2, HALF_PI, PI);
            }
          } else {

            if (random(1) < 0.5) {
              arc(xx+sw, yy+sh, sw*v*2, sh*v*2, PI, PI*1.5);
            } else {
              arc(xx, yy+sh, sw*v*2, sh*v*2, PI*1.5, TAU);
            }
          }
        } else if (rnd == 1) {
          if (random(1) < 0.5) {
            if (random(1) < 0.5) {
              rect(xx, yy, sw*v, sh*v);
            } else {
              float ww = sw*v;
              rect(xx+sw-ww, yy, ww, sh*v);
            }
          } else {
            float hh = sh*v;
            if (random(1) < 0.5) {
              rect(xx, yy+sh-hh, sw*v, hh);
            } else {
              float ww = sw*v;
              rect(xx+sw-ww, yy+sh-hh, ww, hh);
            }
          }
        }
      }
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#A5D0A8, #8CADA7, #110B11, #B7990D, #F2F4CB};
int colors[] = {#02AAE0, #F47EF3, #0ABB8B, #F6DE21, #F63528, #000000, #ffffff};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
