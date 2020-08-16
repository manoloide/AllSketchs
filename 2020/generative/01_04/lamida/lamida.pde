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

  background(0);

  randomSeed(seed);
  noiseSeed(seed);

  ArrayList<PVector> points = new ArrayList<PVector>();

  float cx = width*0.5;
  float cy = height*0.5;

  blendMode(ADD);

  for (int k = 0; k < 400; k++) {
    pushMatrix();
    translate(0, 0, random(40));
    float r1 = width*random(0.01, 0.3);
    float r2 = width*random(0.2, 0.8);
    r1 = lerp(r1, r2, random(random(0.8)));
    int res = int(random(22, 93)*int(random(100)));
    float da = TAU*random(1*random(1))/res;
    res -= int(res*random(random(0.2), 0.98));
    float desA = random(TAU);
    float rot = int(random(4)*random(1)*random(1));
    rot -= rot%0.125;
    float vc = random(0.2);
    float dc = random(colors.length);
    float alp = random(120, 240)*0.22*random(0.6, 1);
    float alpOsc = int(random(10)*random(1));
    for (int i = 0; i < res; i++) {
      float v = i*(1./res);
      float a = da*i+sin(i*TAU*rot/res)*0.1;
      stroke(getColor(a*a*vc+dc), alp*(1-abs(sin(v*PI*alpOsc))));
      strokeWeight(random(1, random(1, 2)));
      a += desA;
      line(cx+cos(a)*r1, cy+sin(a)*r1, 
        cx+cos(a)*r2, cy+sin(a)*r2);
    }
    popMatrix();
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#163099, #E02311, #F783C4, #FCFAEF, #FCB346};
//int colors[] = {#021CAA, #A686F0, #FAA0DD, #F83A7A, #FFF14D, #03AB85 };
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
int colors[] = {#C91F10, #BA1D0E, #110E33, #7F4365};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}
