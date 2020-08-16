import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brushes[];
PImage forms[];
PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brushes = new PImage[2];
  for (int i = 0; i < 2; i++) {
    brushes[i] = loadImage("brush/brush0"+str(i+1)+".png");
  }

  //loadForms();

  generate();

  if (export) {
    saveImage();
    exit();
  }
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
  background(0);

  rectMode(CENTER);
  imageMode(CENTER);

  /*
  for (int i = 0; i < 100; i++) {
   
   tint(lerpColor(color(0), rcol(), random(0.18)));
   pushMatrix();
   translate(random(width), random(height));
   rotate(random(TAU));
   float sca = width*random(0.5, 1.2);
   PImage aux = brushes[int(random(brushes.length))];
   image(aux, 0, 0, sca, sca);
   popMatrix();
   }
   */

  float detAng = random(0.008);
  float desAng = random(10000);

  float detAmp = random(0.002);

  float detCol1 = random(0.0008, 0.002)*8.5;
  float detCol2 = random(0.0008, 0.002)*8.5;

  noStroke();

  blendMode(ADD);

  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.2)*3*random(0.4, 1);

    tint(rcol(), random(80)*random(1));
    PImage aux = (random(1) < 1)? brushes[int(random(brushes.length))] : forms[int(random(forms.length))];
    image(aux, x, y, s, s);
  }

  /*
  for (int i = 0; i < 300; i++) {
   float xx = random(-0.2, 1.2)*width;
   float yy = random(-0.2, 1.2)*height;
   float ww = random(4, 12)*random(1);
   float hh = ww*random(0.4, random(0.5, 1.2))*random(0.4, 1.2);
   //hh *= 0.2;
   xx -= (noise(xx*0.01, yy*0.01, 100)*2-1)*20;
   yy -= (noise(yy*0.01, 100, xx*0.01)*2-1)*20;
   
   float cn1 = (float)SimplexNoise.noise(xx*detCol1, yy*detCol1, seed*0.01*detCol1)*0.5+0.5;
   float cn2 = (float)SimplexNoise.noise(xx*detCol2, yy*detCol2, 20+seed*0.01*detCol2)*0.5+0.5;
   tint(getColor(random(2)*random(1)+(cn1+cn2)*colors.length));
   pushMatrix();
   translate(xx+random(-2, 2), yy+random(-2, 2));
   rotate(HALF_PI+((float) SimplexNoise.noise(desAng+xx*detAng, desAng+yy*detAng)*2-1)*TAU*0.2);
   //rect(0, 0, ww, hh);
   float sca = 2+random(1);
   sca *= random(16, 24)*1.4*random(1);
   //hh *= amp;
   PImage aux = (random(1) < 1)? brushes[int(random(brushes.length))] : forms[int(random(forms.length))];
   //image(aux, 0, 0, ww*sca, hh*sca);
   
   float r1 = ww*sca;
   float r2 = r1*random(0.2, 0.4);
   int seg = int(random(3, 10)); 
   
   
   //tint(255);
   textureMode(NORMAL);
   beginShape(QUAD_STRIP);
   float rotAmp = 1;//random(2);
   texture(aux);
   for (int j = 0; j <= seg; j++) {
   float v = j*1./seg;
   float a = TAU*v*rotAmp;
   vertex(cos(a)*r1, sin(a)*r1, v, 0);
   vertex(cos(a)*r2, sin(a)*r2, v, 1);
   }
   endShape();
   
   //rect(0, 0, ww*sca, hh*sca);
   popMatrix();
   }
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#2F2C4B, #513F65, #8E7B99, #7C5B53, #EBCCC4};
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
