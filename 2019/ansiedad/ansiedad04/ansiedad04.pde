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

  desAng = random(1000);
  detAng = random(0.01);
  desDes = random(1000);
  detDes = random(0.01);


  background(0);//rcol());//random(240, 250));

  blendMode(ADD);


  float ic = random(100);
  float dc = random(0.08, 0.1)*10.4;
  float det = random(0.8, 0.1)*random(0.03, 0.04)*0.2;

  /*
  float fov = PI/random(2, 3.0);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */
  pushMatrix();
  translate(width*0.5, height*0.5);
  float rot = random(0.4);
  rotateX(random(rot));
  rotateY(random(rot));
  rotateZ(random(rot));

  strokeWeight(0.8);
  float pwr = int(random(2, random(2, 8)));
  int div = int(random(0.8, 1)*14*random(1, 2.6));
  float da = random(20);
  for (int j = 0; j < div; j++) {
    float r1 = pow(map(j+0+cos(j*da)*4, 0, div, 0, 1), pwr)*width*0.82;
    float r2 = pow(map(j+random(1, 4)+cos(j*da)*4, 0, div, 0, 1), pwr)*width*0.82;
    int sub = int(r2*PI*random(0.6, 1)*random(4));
    noFill();
    for (int i = 0; i < sub; i++) {
      float a1 = map(i+0, 0, sub, 0, TAU);
      int col = getColor(noise(ic+dc*j)*colors.length*2+random(0.2));
      stroke(lerpColor(color(0), col, random(1)), random(10, random(8, 18))*1.2*random(0.4, 1));
      noFill();
      noiseLine(cos(a1)*r1, sin(a1)*r1, cos(a1)*r2, sin(a1)*r2, det);
      float s = random(3)*random(1);
      fill(230, 240, 10, 250);
      if (random(1) < 0.02) ellipse( cos(a1)*r1, sin(a1)*r1, s, s);
    }
  }

  popMatrix();
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
  float dx = x1*0.0008;//random(1000);
  float dy = y1*0.0008;//random(1000);
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar*0.8; k++) {
    float ang = ((float)SimplexNoise.noise(dx+seed*0.02+ix*det, dy+iy*det)*2-1)*PI*24+desAng;
    ix += cos(ang)*1.2;
    iy += sin(ang)*1.2;
    points.add(new PVector(ix, iy));
  }

  PVector p1 = points.get(0);
  PVector p2 = points.get(points.size()-1);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float dis = p1.dist(p2)*2.2;


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
  float des = noise(desDes+x*detDes, desDes+y*detDes)*60;
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
//int colors[] = {#505050, #000000, #ff0000, #000000, #0000ff};
int colors[] = {#D9BCBC, #CAB4B0, #3E87B2, #1E4F42, #F37C0A};
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
