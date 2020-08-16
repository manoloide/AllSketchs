//import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  //blendMode(NORMAL);
  background(240);

  float dd = 80;

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 220; i++) {
    float x = random(width+dd);
    float y = random(height+dd);

    x -= x%dd;
    y -= y%dd;

    points.add(new PVector(x, y));

    if (random(1) < 0.5) {
      noStroke();
      fill(rcol());
      float ss = (random(1) < 0.5)? dd*0.25 : dd*0.125;
      ellipse(x, y, ss, ss);
    }
  }

  for (int i = 0; i < points.size(); i++) {

    PVector p = points.get(i);

    float x = p.x;
    float y = p.y;

    int col = rcol();
    int col2 = rcol();

    float det = random(0.01, random(0.02, 0.05));
    float des = random(1000);

    float ang = random(TAU);
    float amp = random(250, 320)*random(0.2, 1);//*random(1);

    float maxAlp = random(160, 240);

    int movs = int(random(1000, 8000))*2;

    float maxDis = random(random(180, 320), 520)*random(0.2, 1)*0.4*random(1);
    float maxCol = random(random(0.5, 0.8), 1);

    float vel = random(0.03, 0.1)*0.6;

    float black = random(0.6, 0.9);

    float prob = random(0.01)*random(1); 

    noiseDetail(int(random(8)));

    for (int j = 0; j < movs; j++) {

      if (random(1) < prob) col2 = rcol();
      


      float a = ang+(float) SimplexNoise.noise(des+x*det, des+y*det)*amp;

      float ax = x;
      float ay = y;

      x += cos(a)*vel;
      y += sin(a)*vel;

      /*
      if (random(1) < 0.05) {
       blendMode(ADD);
       } else {
       blendMode(NORMAL);
       }
       */

      float movAmp = sin(map(j, 0, movs, 0, PI));
      float dis = maxDis*random(0.8, 1)*movAmp*random(0.8, 1);
      stroke(lerpColor(lerpColor(rcol(), col, random(maxCol)), color(0), random(black)), random(maxAlp)*random(0.5, 1));
      //line(x, y, x+cos(a+HALF_PI)*dis, y+sin(a+HALF_PI)*dis);
      float da = random(-0.04, 0.04)+random(TAU);
      float x1 = x+cos(a-HALF_PI+da)*dis;
      float y1 = y+sin(a-HALF_PI+da)*dis;
      float x2 = x+cos(a+HALF_PI+da)*dis;
      float y2 = y+sin(a+HALF_PI+da)*dis;
      line(x1, y1, x2, y2);
      stroke(255, 20);
      line(ax, ay, x, y);

      noStroke();
      fill(col2, random(120, 250));
      float s = random(random(1.4, random(1.4, 2)));
      if (random(1) < 0.5) ellipse(x1, y1, s, s);
      if (random(1) < 0.5) ellipse(x2, y2, s, s);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(4, PI*pow(max(s1, s2)*0.1, 1)*3);

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#E9C500, #DB92AE, #E44509, #42A1C1, #37377A, #D87291, #D65269, #000000};
//int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
int colors[] = {#EFACDB, #F2B346, #C90606, #184CB2}; //#D8569E, 

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
  return lerpColor(c1, c2, pow(v%1, 2));
}
