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
  size(int(swidth*scale), int(sheight*scale), P2D);
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

float detCol, desCol;
void generate() {

  hint(DISABLE_DEPTH_TEST);

  //strokeCap(SQUARE);

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  noStroke();
  float ss = width/32;
  for (int k = 0; k < 128*6; k++) {
    float x = width*random(1);
    float y = height*random(1);
    int s = int(random(1, random(5, 10)));
    x -= x%ss;
    y -= y%ss;
    
    noStroke();
    beginShape(QUAD);

    float inv = (random(1) < 0.5)? -1 : 1;
    float alp = random(20, random(40, 140));
    int col = rcol();
    float dd = ss*3*inv;

    if (random(1) < 0.5) {
      fill(col, 0);
      vertex(x-dd, y+ss*s-dd);
      vertex(x+ss*s-dd, y+ss*s-dd);
      fill(col, alp);
      vertex(x+ss*s, y+ss*s);
      vertex(x, y+ss*s);

      fill(col, 0);
      vertex(x+ss*s-dd, y-dd);
      vertex(x+ss*s-dd, y+ss*s-dd);
      fill(col, alp);
      vertex(x+ss*s, y+ss*s);
      vertex(x+ss*s, y);
    } else {
      fill(col, 0);
      vertex(x-dd, y+dd);
      vertex(x+ss*s-dd, y+dd);
      fill(col, alp);
      vertex(x+ss*s, y);
      vertex(x, y);

      fill(col, 0);
      vertex(x+ss*s-dd, y+dd);
      vertex(x+ss*s-dd, y+ss*s+dd);
      fill(col, alp);
      vertex(x+ss*s, y+ss*s);
      vertex(x+ss*s, y);
    }


    fill(0, 40);
    vertex(x, y+ss*s);
    vertex(x+ss*s, y+ss*s);
    fill(0, 0);
    vertex(x+ss*s, y+ss*s*1.4);
    vertex(x, y+ss*s*1.4);

    fill(0, 40);
    vertex(x, y);
    vertex(x+ss*s, y);
    fill(0, 0);
    vertex(x+ss*s, y-ss*s*0.4);
    vertex(x, y-ss*s*0.4);

    fill(0, 40);
    vertex(x+ss*s, y);
    vertex(x+ss*s, y+ss*s);
    fill(0, 0);
    vertex(x+ss*s*1.4, y+ss*s);
    vertex(x+ss*s*1.4, y);

    fill(0, 40);
    vertex(x, y);
    vertex(x, y+ss*s);
    fill(0, 0);
    vertex(x-ss*s*0.4, y+ss*s);
    vertex(x-ss*s*0.4, y);
    endShape();
    
    noStroke();
    fill(rcol());
    rect(x, y, ss*s, ss*s);

    if (random(1) < 0.25) {
      fill(rcol());
      rect(x+ss*s*0.25, y+ss*s*0.25, ss*s*0.5, ss*s*0.5);
    }

    if (random(1) < 0.125) {
      stroke(rcol());
      noFill();
      strokeWeight(ss*s*0.03);
      rect(x+ss*s*0.25, y+ss*s*0.25, ss*s*2.5, ss*s*2.5);
    }
  }
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
int colors[] = {#F9F7F7, #F94D32, #500C02, #000000};//, #6BEFA4};
//int colors[] = {#FFDF2B, #B20E0E, #38251C, #1A4CAF, #1E6028};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
