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

  background(254);

  //blendMode(ADD);

  float fov = PI/random(2.4, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  for (int kk = 0; kk < 3; kk++) {
    pushMatrix();
    translate(width*random(-1, 1), height*random(-1, 1));
    //scale(2);

    for (int k = 0; k < 30; k++) {
      //rotateX(random(TAU));
      //rotateY(random(TAU));
      //rotateZ(random(TAU));

      int c1 = rcol();
      int c2 = rcol();

      float amp = random(1, random(2.5, 3.5));
      float rot = amp*TAU;
      float sub = int(random(4000, 8000)*0.8*amp);

      float r1 = width*random(0.4, 0.6)*0.5;
      float r2 = width*random(0.7, 0.9)*0.6;
      float pwrR = random(0.5, 1.5);

      float s1 = width*random(0.2, 0.3)*0.4;
      float s2 = width*random(0.6, 0.9)*0.4;
      float pwrS = random(0.5, 1.5);

      float da = rot/sub;
      noFill();
      //beginShape();
      float oscAmp = random(20)*random(1);
      for (int i = 0; i < sub; i++) {
        float v = i*1./sub;
        //v += sin(v*TAU);
        float r = pow(lerp(r1, r2, v), pwrR);
        float a = da*i;
        float s = pow(lerp(s1, s2, v), pwrS);
        int col = lerpColor(c1, c2, v);
        float alp = 24*sin(PI*v);
        stroke(col, alp);
        strokeWeight(1.2*pow(sin(PI*v), 1.2));
        //vertex(cos(a)*r, sin(a)*r);


        float det = 0.002*v;
        float a1 = v*TAU;
        a1 = noise(100+cos(a1)*det*r, sin(a1)*det*r, k*10)*TAU*10;
        float a2 = v*TAU;
        a2 = noise(cos(a2)*det*r, 100+sin(a2)*det*r, k*10)*TAU*10;
        a1 = a1%HALF_PI;
        a2 = a2%HALF_PI;
        float mm = min(a1, a2);
        a2 = max(a2, a1);
        a1 = mm;

        float osc = 1+sin(pow(v, 2.4)*TAU*oscAmp)*0.24+sin(a*6)*0.2;
        pushMatrix();
        float xx = cos(a)*r*osc;
        float yy = sin(a)*r*osc;
        xx += cos(xx*2.01)*2;
        yy += sin(yy*2.01)*2;
        translate(xx, yy);
        //rotateY(-a);
        //rotateY(a);
        //a1 = 0;
        //a2 = TAU;
        arc2(0, 0, s, a1, a2, 0, alp);
        popMatrix();
      }
    }
    popMatrix();
  }
  //endShape();
}

void arc2(float x, float y, float s, float a1, float a2, float alp1, float alp2) {
  float r = s*0.5;
  float aa = max(a1, a2);
  a1 = min(a1, a2);
  a2 = aa;

  int res = int((a2-a1)*r*PI*0.1);
  noFill(); 
  beginShape();
  for (int i = 0; i < res; i++) {
    float v = (i*1.)/(res-1);
    float a = lerp(a1, a2, v);
    float alp = lerp(alp1, alp2, v);
    float mod = 1-sin(v*PI)*0.2+cos(a*res)*0.001;
    vertex(x+cos(a)*r*mod, y+sin(a)*r*mod);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#A1A7F4, #EA77BA, #EA0071, #F70D04, #301156};
//int colors[] = {#FE829C, #6AFFB8, #BB6633, #3B382B, #DF9BFB};
int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB};
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
