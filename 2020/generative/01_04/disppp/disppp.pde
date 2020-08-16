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
  //pixelDensity(2);
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
  else if (key == 'c') 
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

  background(250);
  float det = random(0.02);
  for (int i = 0; i < 1000000; i++) {
    float x = random(width);
    float y = random(height);
    float s = 3+pow(noise(x*det, y*det), 1.5)*45;
    s *= 0.5;
    boolean add = true;
    for (int k = 0; k < points.size(); k++) {
      PVector other = points.get(k);
      float dd = (s+other.z)*0.5;
      if (abs(other.x-x) > dd || abs(other.y-y) > dd) continue;
      if (dist(x, y, other.x, other.y) < dd) {

        add = false;
        break;
      }
    }
    strokeWeight(2);
    if (add) {
      points.add(new PVector(x, y, s));
      noStroke();
      fill(0);
      if (random(1) < 0.2) continue;
      if (random(1) < 0.1) fill(rcol());
      ellipse(x, y, 4, 4);
    }
  }

  strokeWeight(3);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    stroke(0);
    if (random(1) < 0.1) continue;
    if (random(1) < 0.1) stroke(rcol());
    point(p.x, p.y);
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#000000, #0E1C00, #6D9100, #D61406, #E2A218};
int colors[] = {#FF4507, #4111AF, #FF56b6};
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
