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

  background(0);

  int cc = int(random(6, 15));
  float ss = width*1./(cc+1);

  noStroke();

  float desCol1 = random(1000);
  float detCol1 = random(0.0005, 0.0018)*0.5;
  float desCol2 = random(1000);
  float detCol2 = random(0.0005, 0.0018)*0.5;

  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      //if (random(1) > 0.2) continue;
      float xx = (i+0.5+random(-0.08, 0.08)*random(0.5, 1))*ss;
      float yy = (j+0.5+random(-0.08, 0.08)*random(0.5, 1))*ss;
      fill(rcol());
      //rect(xx, yy, ss, ss);
      fill(rcol());
      //ellipse(xx+ss*0.5, yy+ss*0.5, ss*1.0, ss*1.0);
      fill(rcol());
      //ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.8, ss*0.8);
      int div = int(random(12, random(20, 120)))*2;
      float amp = random(2, 3.2);

      /*
      float dd = dist(xx, yy, width*0.5, height*0.5)/(width*1.4);
       dd = 0.8+pow(dd, 0.4)*0.6;
       amp *= dd;
       */

      int c1 = getColor(noise(desCol1+xx*detCol1, desCol1+yy*detCol1)*colors.length*3);
      int c2 = getColor(noise(desCol2+xx*detCol2, desCol2+yy*detCol2)*colors.length*3);

      c1 = lerpColor(c1, color(0), random(0.1));
      c2 = lerpColor(c2, color(255), random(0.1));

      int dir = int(random(2))*2-1;

      float ax = random(0.1, 0.2)*PI;
      float des = random(0.2, 0.4);
      for (int k = 0; k < div; k++) {
        float v2 = 1-k*(1./div);
        float a = (TAU*1./div)*k;
        fill((k%2==0)? c1 : c2);
        pushMatrix();
        translate(xx+ss*0.5, yy+ss*0.5);
        rotate(a*dir);
        rotateY(ax);
        arc(ss*des, 0, ss*0.5*amp, ss*0.5*amp, PI*dir, PI+PI*dir);
        popMatrix();
      }
      fill(rcol());
      //ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.1, ss*0.1);
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
