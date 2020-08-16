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

  float bb = -40;
  float ss = width-bb*2;
  int cc = int(random(12, 45)*random(0.2, 4)*0.6);
  float dd = ss/cc;
  float det1 = random(0.1);
  float det2 = random(0.1);
  float det3 = random(0.1);
  float det4 = random(0.1);
  for (int i = 0; i < cc; i++) {
    float dx = bb+dd*(int(random(cc))+0.5);
    float dy = bb+dd*(int(random(cc))+0.5);
    float str1 = noise(dx*det1, dy*det1, 0)*dd*5.2;
    float str2 = noise(dx*det2, dy*det2, 1)*dd*5.2;
    float str3 = noise(dx*det3, dy*det3, 2)*dd*5.2;
    float str4 = noise(dx*det4, dy*det4, 3)*dd*5.2;

    int col1 = rcol();
    int col2 = rcol();
    float alp1 = random(140, 255);
    float alp2 = random(140, 255);
    line1(dx, bb, dx, height-bb, str1, str2, col1, col2, alp1, alp2);
    line1(bb, dy, width-bb, dy, str3, str4, col1, col2, alp1, alp2);
  }

  for (int i = 0; i < 10; i++) {
    float xx = random(width);
    float yy = random(height);
    float s = random(360)*random(0.8, 1.8);
    xx -= xx%dd;
    yy -= yy%dd;
    xx += bb;
    yy += bb;
    fill(rcol(), random(random(120), 255));
    cir(xx, yy, s);
  }
}

void cir(float x, float y, float s) {
  float r = s*0.5;
  int res = int(r*PI*0.5);
  float da = TAU/res;
  float id = random(TAU);
  beginShape();
  for (int i = 0; i < res; i++) {
    if (random(1) < 0.1) {
      float a = da*i+id;
      vertex(x+cos(a)*r, y+sin(a)*r);
    }
  }
  endShape(CLOSE);
}

void line1(float x1, float y1, float x2, float y2, float str1, float str2, int col1, int col2, float alp1, float alp2) {
  float d = dist(x1, y1, x2, y2);
  int res = int(d/2);
  float det = 0.002;
  for (int i = 0; i < res; i++) {
    float v1 = i*1./res;
    float v2 = (i+0.5)*1./res;
    float xx1 = lerp(x1, x2, v1);
    float xx2 = lerp(x1, x2, v2);
    float yy1 = lerp(y1, y2, v1);
    float yy2 = lerp(y1, y2, v2);
    float n1 = (float) SimplexNoise.noise(xx1*det, yy1*det);
    float n2 = (float) SimplexNoise.noise(xx2*det, yy2*det);
    float s1 = lerp(str1, str2, v1)*n1;
    float s2 = lerp(str1, str2, v1)*n2;
    int c1 = lerpColor(col1, col2, v1);
    int c2 = lerpColor(col1, col2, v2);
    float a1 = lerp(alp1, alp2, v1);
    float a2 = lerp(alp1, alp2, v2);

    line2(xx1, yy1, xx2, yy2, s1, s2, c1, c2, a1, a2);
  }
}

void line2(float x1, float y1, float x2, float y2, float str1, float str2, int col1, int col2, float alp1, float alp2) {
  float ang = atan2(y2-y1, x2-x1);
  beginShape();
  fill(col1, alp1);
  vertex(x1+cos(ang-HALF_PI)*str1, y1+sin(ang-HALF_PI)*str1);
  vertex(x1+cos(ang+HALF_PI)*str1, y1+sin(ang+HALF_PI)*str1);
  fill(col2, alp2);
  vertex(x2+cos(ang+HALF_PI)*str2, y2+sin(ang+HALF_PI)*str2);
  vertex(x2+cos(ang-HALF_PI)*str2, y2+sin(ang-HALF_PI)*str2);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
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
