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

  hint(DISABLE_DEPTH_TEST);

  //strokeCap(SQUARE);

  randomSeed(seed);
  noiseSeed(seed);


  detDes = random(0.01);
  desDes = random(10000);

  ArrayList<PVector> points = new ArrayList();

  float des = 0.125; //1.0
  for (float jj = -2; jj <= 2; jj+=des) {
    for (float ii = -2; ii <= 2; ii+=des) {
      //translate(width*random(0.15, 0.85), height*random(0.15, 0.85));
      float cx = width*(0.5+ii*0.21+random(-0.12, 0.12));
      float cy = height*(0.5+jj*0.21+random(-0.12, 0.12));
      cx = lerp(cx, width*0.5, random(0.2, 1)*random(0.2, 1)*random(1.2)*random(1));
      cy = lerp(cy, height*0.5, random(0.2, 1)*random(0.2, 1)*random(1.2)*random(1));

      float sca = 0.8+random(0.8, 1.4)*random(0.4, 1.2);
      points.add(new PVector(cx, cy, sca));
    }
  }

  connects(points);

  /*
  for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   flower(p.x, p.y, p.z, detCol, desCol);
   }
   */
}

float desDes, detDes;
PVector def(float x, float y) {

  x += (noise(desDes+detDes*x, desDes+detDes*y, 999)*2-1)*12; 
  y += (noise(desDes+detDes*x, desDes+detDes*y, 111)*2-1)*12; 
  return new PVector(x, y);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#A1A7F4, #EA77BA, #EA0071, #F70D04, #301156};
//int colors[] = {#FE829C, #6AFFB8, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#F7DA36, #A51515, #2B1F19, #1B44C1};//, #6BEFA4};
//int colors[] = {#F7DA36, #941313, #2B1F19, #1B44C1};//, #6BEFA4};
int colors[] = {#FFDF2B, #B20E0E, #38251C, #1A4CAF, #1E6028};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
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
  return lerpColor(c1, c2, pow(v%1, 0.3));
}


void connects(ArrayList<PVector> points) {
  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < points.size(); i++) {
    unreached.add(points.get(i));
  }

  if (unreached.size() > 0) {
    int ind = int(random(unreached.size()));
    reached.add(unreached.get(ind));
    unreached.remove(ind);
  }


  while (unreached.size() > 0) {
    float record = 10000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      PVector v1 = reached.get(i);
      for (int j = 0; j < unreached.size(); j++) {
        PVector v2 = unreached.get(j);
        float d = v1.dist(v2);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }
    if (random(1) < 0.4) lines(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);
    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }
}

void lines(float x1, float y1, float x2, float y2) {
  blendMode(ADD);
  float w = abs(x2-x1);
  float h = abs(y2-y1);
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  int seg = int(dis*random(30, 40)*0.6);
  //fill(0, 10);
  float dc = random(colors.length);

  float amp = random(0.1, 0.8)*random(1);
  float des = random(0.2)*random(1);
  float rad = dis*random(0.8, 3);
  float ampRot = random(1, random(1, 3));
  //beginShape();
  for (int i = 0; i <= seg; i++) {
    float v = des+i*amp/seg;
    float xx = lerp(x1, x2, v);
    float yy = lerp(y1, y2, v);
    PVector p = def(xx, yy);
    xx = p.x;
    yy = p.y;
    float ar = HALF_PI*v*ampRot;
    float r = rad*(1-v)*(1+cos(v*TAU*2)*0.4);
    float str1 = cos(v*TAU*20)*2;
    str1 *= 0.2;
    float str2 = cos(v*TAU*20)*2;
    str2 *= 0.3;
    //strokeWeight(str);
    //beginShape();
    noStroke();
    int col1 = getColor(dc+v*colors.length);
    int col2 = getColor(dc+v*colors.length+2);

    float dx = cos(ang-ar)*r;
    float dy = sin(ang-ar)*r;
    float alp = 18;
    beginShape();
    fill(col1, alp);
    vertex(xx+cos(ang-HALF_PI)*str1, yy+sin(ang-HALF_PI)*str1);
    vertex(xx+cos(ang+HALF_PI)*str1, yy+sin(ang+HALF_PI)*str1);
    fill(col2, alp*0.6);
    vertex(xx+dx+cos(ang+HALF_PI)*str2, yy+dy+sin(ang+HALF_PI)*str2);
    vertex(xx+dx+cos(ang-HALF_PI)*str2, yy+dy+sin(ang-HALF_PI)*str2);
    endShape();

    float xx1 = xx+cos(v*TAU*10);
    float yy1 = yy+sin(v*TAU*10);
    float xx2 = xx+cos(ang+ar)*r;
    float yy2 = yy+sin(ang+ar)*r;

    beginShape();
    fill(col1, alp);
    vertex(xx1+cos(ang-HALF_PI)*str1, yy1+sin(ang-HALF_PI)*str1);
    vertex(xx1+cos(ang+HALF_PI)*str1, yy1+sin(ang+HALF_PI)*str1);
    fill(col2, alp*0.6);
    vertex(xx2+cos(ang+HALF_PI)*str2, yy2+sin(ang+HALF_PI)*str2);
    vertex(xx2+cos(ang-HALF_PI)*str2, yy2+sin(ang-HALF_PI)*str2);
    endShape();
    //line(xx1, yy1, xx2, yy2);
    //endShape();
  }
  //endShape();
}
