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

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  desAng = random(1000);
  detAng = random(0.01);
  desDes = random(1000);
  detDes = random(0.01);


  background(10);//rcol());//random(240, 250));
  float det = random(0.004);
  blendMode(ADD);
  float bb = 40;
  float osc = random(0.5, 1)*random(0.1, 0.2)*0.2;
  for (int i = 0; i < 2200000; i++) {
    float x = random(bb, width-bb); 
    float y = random(bb, height-bb);
    PVector p = def(x, y);
    x = p.x*0.25; 
    y = p.y*0.25;
    p = def(x, y);
    x = p.x*4; 
    y = p.y*4;
    int col = getColor(noise(x*det, y*det)*colors.length*2+random(2));
    stroke(col, 245);
    strokeWeight(constrain(abs(cos(x*osc)*sin(y*osc)*1.2), 0.4, 1));
    point(x, y);
  }
}

void noiseLine(float x1, float y1, float x2, float y2, float det) {
  ArrayList<PVector> points = new ArrayList<PVector>();

  int lar = int(dist(x1, y1, x2, y2));
  float desAng = atan2(y2-y1, x2-x1);

  float ix = 0;
  float iy = 0;
  float dx = x1*0.002;//random(1000);
  float dy = y1*0.002;//random(1000);
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar*1.8; k++) {
    float ang = ((float)SimplexNoise.noise(dx+seed*0.02+ix*det, dy+iy*det)*2-1)*PI*24+desAng;
    ix += cos(ang)*1.2;
    iy += sin(ang)*1.2;
    points.add(new PVector(ix, iy));
  }

  PVector p1 = points.get(0);
  PVector p2 = points.get(points.size()-1);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float dis = p1.dist(p2)*1;


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
    //p = def(p.x, p.y);
    vertex(x1+p.x, y1+p.y);
  }
  endShape();
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector def(float x, float y) {
  float ang = noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = noise(desDes+x*detDes, desDes+y*detDes)*50;
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
int colors[] = {#505050, #000000, #ff0000, #000000, #0000ff};
//int colors[] = {#D9BCBC, #CAB4B0, #3E87B2, #1E4F42, #F37C0A};
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
