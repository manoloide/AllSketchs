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

  background(getColor());

  //translate(-width*0.2, -height*0.2);
  //scale(1.4);

  desAng = random(1000);
  detAng = random(0.0002, 0.0003)*10;
  desAmp = random(1000);
  detAmp = random(0.0001, 0.0003)*4;
  desDes = random(1000);
  detDes = random(0.0002, 0.0003)*0.5;

  int cw = int(random(12, 20)*20*0.3*12);//*12.2);//*random(30));
  int ch = int(random(12, 30)*15*0.3*12);//*12.2);


  cw = ch = 300;

  float ww = 1./cw;
  float hh = 1./ch;

  int dd = 50;
  noStroke();

  float vv = random(1)*random(1)*400;
  for (int j = -dd; j < ch+dd; j++) {
    for (int i = -dd; i < cw+dd; i++) {

      if ((i+j)%2 == 0) fill(0);
      else fill(255);


      float col = ((i+j)*vv)%4+j*0.02;
      float res = col%1;
      col = (col-col%1)+pow(res, 4);
      fill(getColor(col));

      PVector p1 = def((i+0)*ww*width, (j+0)*hh*height);
      PVector p2 = def((i+1)*ww*width, (j+0)*hh*height);
      PVector p3 = def((i+1)*ww*width, (j+1)*hh*height);
      PVector p4 = def((i+0)*ww*width, (j+1)*hh*height);

      beginShape();
      line2(p4, p1);
      line2(p1, p2);
      line2(p2, p3);
      line2(p3, p4);
      endShape();

      /*
      PVector mp1 = PVector.lerp(p1, p2, 0.5);
       PVector mp2 = PVector.lerp(p2, p3, 0.5);
       PVector mp3 = PVector.lerp(p3, p4, 0.5);
       PVector mp4 = PVector.lerp(p4, p1, 0.5);
       
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
