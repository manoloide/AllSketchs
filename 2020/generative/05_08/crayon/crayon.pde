import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {

  //generate();
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(250);

  float fov = PI/2.6;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5);
  scale(1.2);

  for (int ll = 0; ll < 1; ll++) {
    //rotateX(PI*random(-0.8, 0.8));
    //rotateY(PI*random(-0.8, 0.8));


    for (int k = 0; k < 30; k++) {
      float x1 = width*random(-0.5, 0.5);
      float x2 = x1+random(200);//width*random(-0.5, 0.5);
      float y1 = width*random(-0.5, 0.5);
      float y2 = y1;//width*random(-0.5, 0.5);
      float z1 = 0;//width*random(-0.5, 0.5);
      float z2 = 0;// width*random(-0.5, 0.5);

      float det = random(0.001)*20*random(1);
      float amp = random(200);
      int col = rcol();
      //strokeWeight(2);
      beginShape(POINTS);
      for (int i = 0; i < 5000; i++) {
        float v = random(1);
        float x = lerp(x1, x2, v);
        float y = lerp(y1, y2, v);
        float z = lerp(z1, z2, v);
        PVector p = def(x, y, z, det, amp);
        stroke(col, random(190));
        vertex(p.x, p.y, p.z);
      }
      endShape();
    }
  }

  /*
    for (int k = 0; k < 30; k++) {
   float x1 = width*random(-0.5, 0.5);
   float x2 = width*random(-0.5, 0.5);
   float y1 = width*random(-0.5, 0.5);
   float y2 = width*random(-0.5, 0.5);
   float z1 = 0;//width*random(-0.5, 0.5);
   float z2 = 0;// width*random(-0.5, 0.5);
   
   float det = random(0.001)*20*random(1);
   float amp = random(200);
   int col = rcol();
   //strokeWeight(2);
   beginShape(POINTS);
   for (int i = 0; i < 5000; i++) {
   float v = random(1);
   float x = lerp(x1, x2, v);
   float y = lerp(y1, y2, v);
   float z = lerp(z1, z2, v);
   PVector p = def(x, y, z, det, amp);
   stroke(col, random(190));
   vertex(p.x, p.y, p.z);
   }
   endShape();
   }
   }
   */
}

PVector def(float x, float y, float z, float det, float amp) {
  float a1 = (float) SimplexNoise.noise(x*det, y*det, z*det)*TAU*2;
  float a2 = (float) SimplexNoise.noise(x*det, y*det, z*det)*TAU*2;
  float a = (float) SimplexNoise.noise(z*det, y*det, x*det)*amp;
  return new PVector(x+cos(a1)*cos(a2)*a, y+sin(a1)*cos(a2)*amp, z+sin(a2)*a);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
//int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
//int colors[] = {#060606, #534A3B, #6A4224, #AC7849, #EEE7DE};
int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D};
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
