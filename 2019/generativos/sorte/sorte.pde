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
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  hint(DISABLE_DEPTH_TEST);


  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  blendMode(ADD);

  int cc = int(70*6);
  float ss = width*1./cc;

  float det = random(0.008, 0.01)*0.2;

  float amp = 4.6;

  float detAng = random(0.006, 0.01)*0.05;
  float detDes = random(0.006, 0.01)*0.06;

  float detA1 = random(0.008, 0.01)*0.04;
  float detA2 = random(0.008, 0.01)*0.04;
  float detCol1 = random(0.006, 0.01)*0.1;
  float detCol2 = random(0.006, 0.01)*0.3*amp;

  float angRed = random(0.006, 0.01)*0.3*amp;
  float desRed = random(0.006, 0.01)*0.3*amp;
  float angGreen = random(0.006, 0.01)*0.3*amp;
  float desGreen = random(0.006, 0.01)*0.3*amp;
  float angBlue = random(0.006, 0.01)*0.3*amp;
  float desBlue = random(0.006, 0.01)*0.3*amp;

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = ss*(i+0.5);
      float yy = ss*(j+0.5);
      float ang = noise(xx*detAng, yy*detAng)*TAU*5;
      float des = noise(xx*detDes, yy*detDes)*22;
      float s = ss*0.9;
      float alp = 250;
      xx += cos(ang)*des;
      yy += sin(ang)*des;
      float dd = noise(xx*det, yy*det)*320;
      float a1 = ((float)SimplexNoise.noise(xx*detA1, yy*detA1))*TAU*2;
      float a2 = ((float)SimplexNoise.noise(xx*detA2, yy*detA2))*TAU*2;
      pushMatrix();
      translate(xx, yy, dd);
      rotateX(a1);
      rotateY(a2);
      int col = getColor(noise(xx*detCol1, yy*detCol1)*20);
      fill(red(col), 0, 0, alp);
      float dx = random(-0.1, 0.1)*0.8;
      float dy = random(-0.1, 0.1)*0.8;
      float ddd = s*0.8;
      ang = noise(xx*angRed, yy*angRed)*TAU*2;
      des = noise(xx*desRed, yy*desRed)*ddd;
      ellipse(dx+cos(ang)*des, dy+sin(ang)*des, s, s);
      fill(0, green(col), 0, alp);
      ang = noise(xx*angGreen, yy*angGreen)*TAU*2;
      des = noise(xx*desGreen, yy*desGreen)*ddd;
      ellipse(dx+cos(ang)*des, dy+sin(ang)*des, s, s);
      fill(0, 0, blue(col), alp);
      ang = noise(xx*angBlue, yy*angBlue)*TAU*2;
      des = noise(xx*desBlue, yy*desBlue)*ddd;
      ellipse(dx+cos(ang)*des, dy+sin(ang)*des, s, s);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
int colors[] = {#681CED, #1C0A26, #0200A5, #31F7BB, #F4F4F2};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
