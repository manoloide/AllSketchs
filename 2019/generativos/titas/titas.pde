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

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  blendMode(ADD);

  noStroke();
  //beginShape();
  float dc = random(0.004);
  float ds = random(0.004);
  int cc = 30000;
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = height*(i*1./cc);
    float s = random(4)*random(1)*(random(1, 1.4)+noise(x*ds, y*ds)*4);
    fill(getColor(noise(x*dc, y*dc)*colors.length*2), random(90)*random(2));
    pushMatrix();
    translate(x, y);
    float ww = s*0.4*random(random(1, 8));
    float hh = s*random(6)*random(1, random(random(12)));
    rotate(PI*random(-0.08, 0.08)*random(1));
    if (random(1) < 0.6) rect(-ww*0.5, -hh*0.5, ww, hh);
    else rect(-hh*0.5, -ww*0.5, hh, ww);
    popMatrix();
  }
  //endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

int colors[] = {#F71630, #3A6B58, #82B754, #E8DD4C, #CE7B0E};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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
  return lerpColor(c1, c2, pow(v%1, 1.8));
}
