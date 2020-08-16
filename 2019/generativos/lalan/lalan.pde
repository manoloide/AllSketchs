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

  randomSeed(seed);
  noiseSeed(seed);
  background(#A4A8A9);

  noStroke();
  int cc = int(random(120, 160)*0.2);
  float ss = width*1./cc;

  for (int i = 0; i < 2000; i++) {
    float xx = int(random(1, cc))*ss;
    float yy = int(random(1, cc))*ss;
    float s = ss*0.1;
    fill(rcol());
    ellipse(xx, yy, s, s);
  }

  for (int i = 0; i < 20; i++) {
    float xx = int(random(5, cc-4))*ss;
    float yy = int(random(5, cc-4))*ss;
    float s = ss*int(random(1, 12))*2*0.5;
    fill(rcol(), 220);
    ellipse(xx, yy, s, s);
  }

  for (int i = 0; i < 200; i++) {
    float xx = int(random(2, cc-1))*ss;
    float yy = int(random(2, cc-1))*ss;

    fill(0);
    rect(xx, yy, ss, ss);
    fill(255);
    rect(xx+ss*0.42, yy+ss*0.42, ss*0.16, ss*0.16);
    if (random(1) < 0.1) {
      fill(0);
      rect(xx-ss, yy-ss, ss*3, ss*3);
      fill(255);
      rect(xx+ss*0.42, yy+ss*0.42, ss*0.16, ss*0.16);
    }
    if (random(1) < 0.1) {
      fill(0);
      rect(xx-ss*1.5, yy+ss*0.42, ss*4, ss*0.16);
    }
    if (random(1) < 0.1) {
      fill(0);
      rect(xx+ss*0.42, yy-ss*1.5, ss*0.16, ss*4);
    }
  }

  for (int i = 0; i < 60; i++) {
    float xx = int(random(1, cc*2-1))*ss*0.5;
    float yy = int(random(1, cc*2-1))*ss*0.5;
    fill(rcol());
    ellipse(xx, yy, ss*0.5, ss*0.5);
  }

  noFill();
  for (int i = 0; i < 5; i++) {
    float xx = int(random(1, cc*2-1))*ss*0.5;
    float yy = int(random(1, cc*2-1))*ss*0.5;
    stroke(rcol());
    strokeWeight(2);
    fill(rcol(), 40);
    ellipse(xx, yy, ss*2.5, ss*2.5);
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
int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
