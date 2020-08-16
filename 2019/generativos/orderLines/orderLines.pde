import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  background(#08328B);

  desAng = random(1000);
  detAng = random(0.0001, 0.0003)*10;
  desDes = random(1000);
  detDes = random(0.0001, 0.0003);

  float desCol1 = random(1000);
  float detCol1 = random(0.001);
  float desCol2 = random(1000);
  float detCol2 = random(0.001);

  /*
  {
   int cw = int(random(8, 20)*4);//*random(30));
   int ch = int(random(8, 40)*4);
   float ww = width*1./cw;
   float hh = height*1./ch;
   noStroke();
   for (int j = int(ch*0.2); j < int(ch*1.2); j++) {
   for (int i = int(cw*-0.2); i < int(cw*+1.2); i++) {
   //if (random(1) < 0.5) continue;
   int dy = int(random(3));
   int col = getColor(noise(desCol2+i*ww*detCol2, desCol2+j*hh*detCol2)*colors.length*3);
   
   
   beginShape();
   fill(col);
   vd(i*ww, (j-dy)*hh);
   vd((i+1)*ww, (j-dy)*hh);
   fill(getColor());
   vd((i+1)*ww, (j+1)*hh);
   vd(i*ww, (j+1)*hh);
   endShape();
   }
   }
   }
   */

  int cw = int(random(12, 20)*1.2);//*random(30));
  int ch = int(random(10, 20)*1.2);
  float ww = width*1./cw;
  float hh = height*1./ch;
  noStroke();
  for (int j = int(ch*0.2); j < int(ch*1.2); j++) {
    for (int i = int(cw*-0.2); i < int(cw*+1.2); i++) {
      if (random(1) < 0.6) continue;

      int dy = int(random(3));
      int sub = 40;
      float x1 = i*ww;
      float x2 = (i+1)*ww;
      int col = getColor(noise(desCol1+i*ww*detCol1, desCol1+j*hh*detCol1)*colors.length*3);
      for (int k = 0; k < sub; k++) { 
        float y1 = map(k, 0, sub, (j-dy)*hh, (j+1)*hh);
        float y2 = map(k+1, 0, sub, (j-dy)*hh, (j+1)*hh);
        float alp1 = pow(map(k, 0, sub, 1, 0), 2)*255;
        float alp2 = pow(map(k+1, 0, sub, 1, 0), 2)*255;
        beginShape();
        fill(col, alp1);
        vd(x1, y1);
        vd(x2, y1);
        fill(col, alp2);
        vd(x2, y2);
        vd(x1, y2);
        endShape();
      }
    }
  }
}

float desAng = random(0.0001, 0.0003);
float detAng = random(0.0001, 0.0003);
float desDes = random(0.0001, 0.0003);
float detDes = random(0.0001, 0.0003);

PVector def(float x, float y) {
  float ang = (float)SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng);
  float des = (float)SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*180;
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void vd(float x, float y) {
  PVector d = def(x, y);
  vertex(d.x, d.y);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
