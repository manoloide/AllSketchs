import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
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

  background(230);
  noStroke();

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 10; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(20, 70);
    points.add(new PVector(xx, yy, ss));
    fill(rcol());
    ellipse(xx, yy, ss, ss);
    ss *= random(0.5, 0.9);
    fill(rcol());
    ellipse(xx, yy, ss, ss);
    ss *= 0.1;
    fill(rcol());
    ellipse(xx, yy, ss, ss);
  }

  float cx = width*0.5;
  float cy = height*0.5;
  stroke(rcol());
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    line(p.x, p.y, cx, cy);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
int colors[] = {#CED8E2, #2D57AD, #050270, #EA4441, #E8AD8F};
//int colors[] = {#021CAA, #A686F0, #FAA0DD, #F83A7A, #FFF14D, #03AB85 };
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
