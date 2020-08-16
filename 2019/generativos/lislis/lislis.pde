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


  background(0, 2, 4);

  blendMode(ADD);

  float dd = 20;
  int cw = int(random(2, 12));
  int ch = 8000;
  float ww = (width-dd*2)*1./cw;
  float hh = (height-dd*2)*1./ch;

  float det = random(0.08, 0.1)*0.012;

  float ic = random(100);
  float dc = random(0.01);
  noFill();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float yy = dd+hh*j;
      stroke(getColor(noise(ic+dc*j)*colors.length*2), 28);
      noiseLine(dd+ww*i, yy, dd+ww*(i+1), yy, det);
    }
  }
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




void noiseLine(float x1, float y1, float x2, float y2, float det) {
  ArrayList<PVector> points = new ArrayList<PVector>();

  int lar = int(dist(x1, y1, x2, y2));
  float desAng = atan2(y2-y1, x2-x1);

  float ix = 0;
  float iy = 0;
  float dx = x1*0.001;//random(1000);
  float dy = y1*0.001;//random(1000);
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar*0.4; k++) {
    float ang = ((float)SimplexNoise.noise(dx+seed*0.02+ix*det, dy+iy*det)*2-1)*PI*30+desAng;
    ix += cos(ang)*2;
    iy += sin(ang)*2;
    points.add(new PVector(ix, iy));
  }

  PVector p1 = points.get(0);
  PVector p2 = points.get(points.size()-1);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float dis = p1.dist(p2);


  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    p.rotate(-ang+desAng);
    p.mult((lar*1./dis));
  }

  //noStroke();
  //fill(rcol());
  beginShape();
  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    vertex(x1+p.x, y1+p.y);
  }
  endShape();
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
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
  return lerpColor(c1, c2, pow(v%1, 10.8));
}
