import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 42956;//int(random(999999));

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

  int cc = int(random(80, 280)*0.2);
  float bb = 0;//50.0;
  float dd = (width-bb*2)*1.0/(cc+1);
  float ss = (width*1.2-bb*2)/cc;

  float ic1 = random(colors.length);
  float ic2 = random(colors.length);
  float dc = random(0.2);
  noStroke();
  float det = random(0.001);
  float det2 = random(0.001);
  float det3 = random(0.001);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      pushMatrix();
      float xx = bb+i*dd;
      float yy = bb+j*dd;
      float noi = (float)SimplexNoise.noise(xx*det, yy*det);
      float noi2 = (float)SimplexNoise.noise(xx*det2, yy*det2);
      float noi3 = (float)SimplexNoise.noise(xx*det3, yy*det3);
      translate(0, 0, noi*1);//i*10);
      float ww = dd*1.2;//*noi2*5;//width-xx;
      float hh = dd*1.2;//*noi3*5;//height-yy;
      beginShape();
      fill(getColor(ic1+dc*i));
      vertex(xx, yy);
      vertex(xx+ww, yy);
      fill(getColor(ic2+dc*i), 0);
      vertex(xx+ww, yy+hh);
      vertex(xx, yy+hh);
      endShape();

      beginShape();
      fill(getColor(ic1+dc*j));
      vertex(xx, yy);
      vertex(xx+ww, yy);
      fill(getColor(ic2+dc*j), 0);
      vertex(xx+ww, yy+hh);
      vertex(xx, yy+hh);
      endShape();
      //rect(xx, yy, ss, height); 
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
//int colors[] = {#061431, #2E52DF, #F78DF1, #FEFEFE, #EC3063};
//int colors[] = {#AFAAA5, #889033, #7CA521, #1296A1, #83CCD7, #EEA902, #F18D02, #783200, #181A19};
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
  return lerpColor(c1, c2, v%1);
}
