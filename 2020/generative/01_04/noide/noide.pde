import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

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
  //cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

float time;

float detCol, desCol;
float detDes, desDes;

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  blendMode(ADD);


  detCol = random(0.0012, 0.002);
  desCol = random(10000);
  detDes = random(0.0006, 0.001);
  desDes = random(10000);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 100; i++) {
    float x = width*random(-0.1, 1.1);
    float y = height*random(-0.1, 1.1);
    x = lerp(x, width*0.5, -0.8);
    y = lerp(y, height*0.5, -0.8);
    points.add(new PVector(x, y));
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(points);

  noFill();
  stroke(rcol(), random(160, 200));
  //linee(width*0.1, height*0.5, width*0.9, height*0.5);

  noStroke();
  //beginShape(TRIANGLES);
  for (int i = 0; i < tris.size(); i++) {
    PVector p1 = tris.get(i).p1;
    PVector p2 = tris.get(i).p2;
    PVector p3 = tris.get(i).p3;
    fill(rcol());
    noFill();
    stroke(rcol(), random(170, 200)*0.018);
    linee(p1.x, p1.y, p2.x, p2.y);
    stroke(rcol(), random(170, 200)*0.018);
    linee(p2.x, p2.y, p3.x, p3.y);
    stroke(rcol(), random(170, 200)*0.018);
    linee(p3.x, p3.y, p1.x, p1.y);
  }
  //endShape();
}

void linee(float x1, float y1, float x2, float y2) {
  float lar = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float amp = lar*random(0.3, 0.8)*0.4*random(1, 3);

  float turns = int(random(4, 14));

  int cc = int(random(140, 200)*0.6); 
  float da = TAU/cc;

  PVector cen = def(width*0.5, height*0.5);
  cen.sub(width*0.5, height*0.5);

  for (int k = 0; k < cc; k++) {
    beginShape();
    for (int j = 0; j <= lar; j++) {
      float v = j*1./lar;
      float xx = lerp(x1, x2, v);
      float yy = lerp(y1, y2, v);

      float des = sin(v*PI)*sin(v*turns*PI+k*da);

      float a = ang+HALF_PI+k*da;

      xx += cos(a)*amp*des;
      yy += sin(a)*amp*des;

      PVector p = def(xx, yy);
      p.x -= cen.x;
      p.y -= cen.x;


      vertex(p.x, p.y);
    }
    endShape();
  }
}

PVector def(float xx, float yy) {
  xx += ((float) SimplexNoise.noise(desDes+detDes*xx, desDes+detDes*yy, 999)*2-1)*300;
  yy += ((float) SimplexNoise.noise(desDes+detDes*xx, desDes+detDes*yy, 111)*2-1)*300;
  return new PVector(xx, yy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
