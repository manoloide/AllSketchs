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

  generate();
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
  //background(252, 250, 245);
  background(0);

  float det = random(0.01);

  float osc1 = random(0.05, 0.2)*random(0.5, 1)*random(random(2))*100;
  float osc2 = osc1;
  if (random(1) < 0.5) osc2 = random(0.5, 2);

  float amp = random(300, 800);

  float detCol = random(0.002)*0.7;
  float des = random(0.008)*8;


  float max = 0.3;
  for (int k = 0; k < 14; k++) {
    float dx = width*random(-0.3, 0.3);
    float dy = height*random(-0.3, 0.3);
    stroke(0, 90);
    beginShape(POINTS);
    for (int i = 0; i < 80000; i++) {
      float vv = random(random(random(max), max));
      float x = dx+width*random(0.5-vv, 0.5+vv);
      float y = dy+height*random(0.5-vv, 0.5+vv);
      y += cos(x*10);
      float dep = (float) SimplexNoise.noise(x*det, y*det, seed*0.01);
      float z = max(cos(x*osc1), sin(y*osc2))*amp*dep;
      stroke(getColor(y*detCol*5+noise(x*des, y*des)*6), random(40, 170));
      vertex(x, y, z);
    }  
    endShape();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
int colors[] = {#E90510, #FCA700, #A7AFFF, #2116C7};
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
