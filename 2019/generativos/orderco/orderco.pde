import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//987298 207948 110051 934171
int seed = 934171;//int(random(999999));

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

  background(getColor());

  translate(-width*0.2, -height*0.2);
  scale(1.4);

  desAng = random(1000);
  detAng = random(0.0002, 0.0003)*4;
  desAmp = random(1000);
  detAmp = random(0.0001, 0.0003)*5;
  desDes = random(1000);
  detDes = random(0.0002, 0.0003)*0.20;

  int cw = int(random(12, 20)*20*0.5);//*12.2);//*random(30));
  int ch = int(random(12, 30)*15*0.5);//*12.2);
  float ww = 1./cw;
  float hh = 1./ch;

  float pw1 = random(1, 2);
  if (random(1) < 0.5) pw1 = 1./pw1;
  float pw2 = random(1, 2);
  if (random(1) < 0.5) pw2 = 1./pw2;

  float ph1 = random(1, 2);
  if (random(1) < 0.5) ph1 = 1./ph1;
  float ph2 = random(1, 2);
  if (random(1) < 0.5) ph2 = 1./ph2;

  //pwr1 = pwr2 = 1;

  noStroke();

  float desCol1 = random(1000);
  float detCol1 = random(0.1)*0.1;
  float desCol2 = random(1000);
  float detCol2 = random(0.1)*0.1;
  /*
  for (int j = -int(ch*0.2); j < int(ch*1.2); j++) {
   for (int i = -int(cw*0.2); i < int(cw*1.2); i++) {
   */
  for (int j = 0; j < ch; j++) {
    float pwrh1 = map(j, 0, ch, ph1, ph2);
    float pwrh2 = map(j+1, 0, ch, ph1, ph2);
    for (int i = 0; i < cw; i++) {

      float pwrw1 = map(i, 0, cw, pw1, pw2);
      float pwrw2 = map(i+1, 0, cw, pw1, pw2);

      if ((i+j)%2 == 0) fill(0);
      else fill(255);

      float mult = random(120)*random(0.5, 1);

      PVector p1 = def(pow((i+0)*ww, pwrw1)*width*mult, pow((j+0)*hh, pwrh1)*height*mult);
      PVector p2 = def(pow((i+1)*ww, pwrw2)*width*mult, pow((j+0)*hh, pwrh1)*height*mult);
      PVector p3 = def(pow((i+1)*ww, pwrw2)*width*mult, pow((j+1)*hh, pwrh2)*height*mult);
      PVector p4 = def(pow((i+0)*ww, pwrw1)*width*mult, pow((j+1)*hh, pwrh2)*height*mult);

      /*
      p1 = def(p1.x/mult, p1.y/mult);
       p2 = def(p2.x/mult, p2.y/mult);
       p3 = def(p3.x/mult, p3.y/mult);
       p4 = def(p4.x/mult, p4.y/mult);
       */

      int c1 = getColor(noise(desCol1+i*detCol1, desCol1+j*detCol1)*colors.length);
      int c2 = getColor(noise(desCol2+i*detCol2, desCol2+j*detCol2)*colors.length);

      beginShape();
      /*
      if (col) {
       fill(rcol());
       } else {
       if ((i+j)%2 == 0) fill(0);
       else fill(255);
       }
       */

      int col = rcol();
      if (random(1) < 0.8) {
        if ((i+j)%2 == 0) col = color(255);
        else col = color(0);
      }
      fill(col);
      line2(p4, p1);
      line2(p1, p2);
      /*
      if (!col) {
       if ((i+j)%2 == 0) fill(255);
       else fill(0);
       }
       */
      //fill(c2);
      //if ((i+j)%2 == 0) fill(255);
      //else fill(0);
      fill(col, 120);
      line2(p2, p3);
      line2(p3, p4);
      endShape();

      /*
      beginShape();
       fill(0, 0);
       line2(p4, p1);
       line2(p1, p2);
       fill(rcol(), 180);
       line2(p2, p3);
       line2(p3, p4);
       endShape();
       */

      /*
      PVector mp1 = PVector.lerp(p1, p2, 0.5);
       PVector mp2 = PVector.lerp(p2, p3, 0.5);
       PVector mp3 = PVector.lerp(p3, p4, 0.5);
       PVector mp4 = PVector.lerp(p4, p1, 0.5);
       */
      /*
      if ((i+j)%2 == 0) fill(255);
       else fill(0);
       //fill(getColor());
       beginShape();
       line2(mp1, mp2);
       line2(mp2, mp3);
       line2(mp3, mp4);
       line2(mp4, mp1);
       endShape();
       */
    }
  }
}

void line(PVector p1, PVector p2) {
  PVector cen = p1.copy().add(p2).mult(0.5);

  boolean hor = abs(p1.x-p2.x) > abs(p1.y-p2.y);

  vertex(p1.x, p1.y);
  if (hor) {
    vertex((p1.x+cen.x)*0.5, p1.y);
    //vertex(cen.x, p1.y);
    vertex((p2.x+cen.x)*0.5, p2.y);
  } else {
    vertex(p1.x, (p1.y+cen.y)*0.5);
    vertex(p2.x, (p2.y+cen.y)*0.5);
  }
  //vertex(cen.x, cen.y);
  vertex(p2.x, p2.y);
}

void line2(PVector p1, PVector p2) {
  vertex(p1.x, p1.y);
  vertex(p2.x, p2.y);
}

float desAng = random(0.0001, 0.0003);
float detAng = random(0.0001, 0.0003);
float desAmp = random(0.0001, 0.0003);
float detAmp = random(0.0001, 0.0003);
float desDes = random(0.0001, 0.0003);
float detDes = random(0.0001, 0.0003);

PVector def(float x, float y) {
  float ang = (float)SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng);
  float amp = (float)SimplexNoise.noise(desAmp+x*detAmp, desAmp+y*detAmp)*500;
  float des = (float)SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*amp;
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
//int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#F7DF04, #EAE5E5, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6};
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
