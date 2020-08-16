import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;


PShader noiseShader;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  noiseShader = loadShader("noiseFrag.glsl");

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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  noiseShader.set("displace", 543);
  float da = TAU/6;

  background(rcol());
  translate(width*0.5, height*0.5);
  rotate(da*0.5);
  noStroke();


  for (int i = 0; i < 180; i++) {
    float dd = 8;
    float ss = 4*int(random(1, random(5, 14)))/1.3;

    int ix = int(random(-1, width/dd)-width*0.5/dd+1);
    int iy = int(random(-1, height/dd)-height*0.5/dd+1);


    float xx = ix*dd*sqrt(3);//random(width+ss);
    if ((iy+1)%2==0)
      xx += sqrt(3)*dd;
    else
      xx += dd*sqrt(3)/2;
    float yy = (dd*3.0*iy)/2;//random(height+ss);

    //xx -= xx%32;
    //yy -= yy%32;

    shader(noiseShader);
    //ellipse(xx, yy, ss*5, ss*5);
    hexShadow(xx, yy, ss*18);
    hexShadow(xx, yy, ss*18);
    hexShadow(xx, yy, ss*18);
    hexShadow(xx, yy, ss*18);
    hexShadow(xx, yy, ss*18);
    hexShadow(xx, yy, ss*18);
    resetShader();
    //hexShadow(xx, yy, ss*4);
    blendMode(ADD);
    hex(xx, yy, ss*4);
    fill(rcol());
    blendMode(NORMAL);
    //if (random(1) < 0.9) hex(xx, yy, ss);
    //ellipse(xx, yy, ss, ss);
  }
}

void hex(float x, float y, float s) {
  float r = s*0.5;
  float da = TAU/3;
  float dd = da*int(random(0, 2));
  for (int i = 0; i < 3; i++) {
    int col = rcol();
    beginShape();
    fill(lerpColor(col, color(255), random(0.14))); 
    vertex(x, y);
    fill(col); 
    vertex(x+cos(da*(i-0.5)+dd)*r, y+sin(da*(i-0.5)+dd)*r);
    vertex(x+cos(da*i+dd)*r, y+sin(da*i+dd)*r);
    vertex(x+cos(da*(i+0.5)+dd)*r, y+sin(da*(i+0.5)+dd)*r);
    endShape();
  }
}

void hexShadow(float x, float y, float s) {
  float r = s*0.5;
  float da = TAU/6;
  float dd = da*int(random(0, 7));
  float a1 = dd;
  float a2 = a1+da;
  float a3 = a1;//(random(1) < 0.5)? a1 : a2;
  //stroke(255);
  int col = rcol();
  noStroke();
  beginShape();
  fill(lerpColor(col, color(255), random(0.14))); 
  vertex(x, y);
  fill(col, random(120, 220)*0.4); 
  vertex(x+cos(a1)*r, y+sin(a1)*r);
  vertex(x+cos(a2)*r, y+sin(a2)*r);
  fill(col, 0);
  float dx = cos(a3)*r*6; 
  float dy = sin(a3)*r*6;
  vertex(x+cos(a2)*r+dx, y+sin(a2)*r+dy);
  vertex(x+cos(a1)*r+dx, y+sin(a1)*r+dy);
  endShape(CLOSE);
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
//int colors[] = {#A128ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
int colors[] = {#1100ff, #FF2200, #040404, #ffcd19, #e9edf0};
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
