import org.processing.wiki.triangulate.*;
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


  blendMode(NORMAL);

  background(10);//random(255));


  strokeWeight(1);
  for (int i = 0; i < 60; i++) {

    float s = width*random(0.18, 0.4)*random(0.9, 1)*random(0.2, 1)*6*random(1)*random(1)*random(1);
    float b = s*0.4;
    float x = random(b, width-b);
    float y = random(b, height-b);

    x -= x%10;
    y -= y%10;

    fill(rcol());
    //ellipse(x, y, s, s);

    boolean rndCol = (random(1) < 0.5);

    int col = rcol();
    int str = rcol();
    //int sub = int(random(28, 87)*random(4, 12)*4);
    int sub = int(PI*pow(s*0.5, 2)*random(0.2)*random(0.6, 1));
    float amp1 = s*random(0.1, 0.4);
    float amp2 = s*0.5;

    fill(getColor());
    ellipse(x, y, amp1*1.8, amp1*1.8);
    arc2(x, y, amp1*1.2, amp1*1.8, 0, TAU, rcol(), 0, 30);

    for (int j = 0; j <= sub; j++) {


      blendMode(NORMAL);
      if (random(1) < 0.5) 
        blendMode(SUBTRACT);
      if (random(1) < 0.5)
        blendMode(ADD);

      //if (rndCol) stroke(rcol(), random(80));
      float ss = random(0.5, 2);
      float a1 = random(PI);
      float a2 = random(TAU);
      stroke(str, random(10, 50)*random(1.2));
      line(x+cos(a1)*cos(a2)*amp1, y+sin(a1)*cos(a2)*amp1, x+cos(a1)*cos(a2)*amp2, y+sin(a1)*cos(a2)*amp2);
      noStroke();
      fill(lerpColor(col, color(0), random(1)), random(255));
      ellipse(x+cos(a1)*cos(a2)*amp2, y+sin(a1)*cos(a2)*amp2, ss, ss);
    }

    noStroke();
    //arc2(x, y, amp1*2, amp1*2.5, 0, TAU, color(0), 240, 0);

    blendMode(NORMAL);
    noStroke();
    fill(255);
    ellipse(x, y, amp1*0.26, amp1*0.26);
    fill(rcol());
    ellipse(x, y, amp1*0.2, amp1*0.2);
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
//int colors[] = {#EA449F, #EFACDB, #F2D091, #BF052A, #214CA2};
int colors[] = {#EA449F, #EFACDB, #F2A63C, #CC0A10, #0F3D99};

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
