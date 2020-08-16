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
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  ArrayList<PVector> points = new ArrayList<PVector>();

  background(rcol());
  float desCol = random(colors.length);
  float detSize = random(0.04);
  float detAmp = random(0.03);
  noStroke();
  for (int i = 0; i < 1400; i++) {
    float x = random(width); 
    float y = random(height);
    float ns = (float)SimplexNoise.noise(x*detSize, y*detSize)*0.5+0.3;
    ns = pow(ns, 1.8)+0.2;
    ns *= pow(noise(x*detAmp, y*detAmp), 0.8)*4;
    float s = ns*9*int(random(4, random(12)*random(0.2, 1)));

    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }


    if (add) {
      points.add(new PVector(x, y, s));
      fill(255, random(60));
      //ellipse(x+s*random(-0.02, 0.02), y+s*random(-0.02, 0.02), s*1.02, s*1.02);
      int col = lerpColor(color(255), getColor(desCol+sqrt(s)), random(1));
      col = lerpColor(color(0), col, random(0.5, 1));
      float r = s*random(0.5, random(random(1, 4)));
      int cc = int(r*r*PI);
      for (int k = 0; k < cc*4; k++) {
        if (random(1) < 0.2) blendMode(ADD);
        else blendMode(NORMAL);
        float ang = random(TAU);
        float dis = r*sqrt(random(1)*random(0.5, 1));
        float da = sin(ang+PI*0.3)*0.5+0.5;
        stroke(lerpColor(col, color(0), da*0.4), random(random(100), 180));
        point(x+cos(ang)*dis, y+sin(ang)*dis);
      }
      //ellipse(x, y, s, s);
    }
  }
  
  blendMode(NORMAL);
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
int colors[] = {#000000, #0E1C00, #6D9100, #D61406, #E2A218};
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
