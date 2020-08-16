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
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  background(0);
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

float detAng, desAng;
float detDes, desDes;

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(20);
  //background(255);

  detAng = random(0.03, 0.04)*0.06;
  detDes = random(0.03, 0.04)*0.06;

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 30; i++) {
    float xx = random(width);
    float yy = random(height);

    xx -= xx%60;
    xx += 30;
    yy -= yy%60;
    yy += 30;

    float ss = random(600);
    points.add(new PVector(xx, yy, ss));
  }
  //noStroke();

  //blendMode(ADD);

  int cc = 500000;
  float a = 0;
  for (float j = 0; j < height; j+=0.5) {
    for (float i = 0; i < width; i+=0.5) {
      float xx = i;//random(width);
      float yy = j;//random(height);

      for (int k = 0; k < points.size(); k++) {
        PVector p = points.get(k);
        float dis = dist(xx, yy, p.x, p.y);
        if (dis < p.z) {
          float v = dis/p.z;
          xx = lerp(p.x, xx, random(1-v*0.3, 1));
          yy = lerp(p.y, yy, random(1-v*0.3, 1));
          a = atan2(p.y-yy, p.x-xx)/TAU;
        }
      }
      a = (a*2)%1;
      a = cos(a*TAU);
      strokeWeight(random(2));
      stroke(254, 230, 220, 10);
      //stroke(lerpColor(#0000ff, #ff0000, a*0.5+0.5), 20);
      point(xx, yy);
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
//int colors[] = {#1100ff, #FF2200, #ffffff, #000000, #aaaaaa};
int colors[] = {#1100ff, #FF2200, #2F3034, #5A5B56, #CAC9C5, #CCCBC7};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
