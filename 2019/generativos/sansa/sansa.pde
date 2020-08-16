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

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);


  background(0, 1, 2);
  //background(255);

  //blendMode(ADD);


  float ic = random(100);
  float dc = random(0.08, 0.1)*1.4;
  float det = random(0.8, 0.1)*0.02;

  pushMatrix();
  translate(width*0.5, height*0.5);
  float rot = random(0.2);
  /*
  rotateX(random(rot));
  rotateY(random(rot));
  rotateZ(random(rot));
  */

  int div = int(random(0.8, 1)*12);
  float alp = 0.5;
  for (int j = 0; j < div; j++) {
    float v1 = pow((j+0)*1./div, 3);
    float v2 = pow((j+1)*1./div, 3);
    float r1 = map(v1, 0, 1, 0, width*0.75);
    float r2 = map(v2, 0, 1, 0, width*0.75);
    int sub = int(r2*PI*14);
    noFill();
    for (int i = 0; i < sub; i++) {
      float a1 = map(i+0, 0, sub, 0, TAU);
      int col = getColor(noise(ic+dc*j+cos(i*TAU/sub+j*0.2))*colors.length*2);

      blendMode(NORMAL);
      stroke(col, 40*alp);
      noiseLine(cos(a1)*r1, sin(a1)*r1, cos(a1)*r2, sin(a1)*r2, det);
      blendMode(ADD);
      stroke(col, 180*alp);
      noiseLine(cos(a1)*r1, sin(a1)*r1, cos(a1)*r2, sin(a1)*r2, det);
    }
  }

  popMatrix();
  
  blendMode(NORMAL);
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
  float dx = x1*0.01;//random(1000);
  float dy = y1*0.01;//random(1000);
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar*0.8; k++) {
    float ang = ((float)SimplexNoise.noise(dx+seed*0.02+ix*det, dy+iy*det)*2-1)*PI*4+desAng;
    ix += cos(ang)*0.1;
    iy += sin(ang)*0.1;
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
int colors[] = {#023138, #071270, #0D344C, #C61800};//, #895B00};
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
