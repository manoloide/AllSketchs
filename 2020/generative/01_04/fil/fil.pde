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

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(getColor());

  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5, 10)*120*map(y, 0, height, 0.4, 1);
    int col = rcol();
    fill(lerpColor(col, color(0), random(1*random(0.2, 1))), random(256));
    cir(x, y, s, 0.25);
  }




  float ic = random(colors.length);
  float dc = random(-1, 1)*0.004;


  stroke(0, 40);
  noStroke();
  for (int i = 0; i < 0; i++) {
    float x = random(width);
    float y = random(height)*random(0.8, 1);
    float s = random(5, 10)*map(y, 0, height, 0.8, 1)*0.8;
    s *= random(0.2, 1);
    float n = ic+y*dc;
    int col = getColor(n);
    fill(lerpColor(col, color(0), random(1*random(0.2, 1))));
    blendMode(NORMAL);
    cir(x, y, s, 10);
    blendMode(ADD);
    fill(col, random(140));
    cir(x, y, s*0.92, 10);
  }
  blendMode(NORMAL);

  /* caras*/
  noStroke();
  for (int i = 0; i < 25; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5, 10)*44*map(y, 0, height, 0.4, 1);
    s *= random(0.5, 1);
    float n = noise(x*dc, y*dc);
    int col = lerpColor(rcol(), getColor(n), random(1));
    fill(lerpColor(col, color(#0D110F), random(1*random(0.1, 1))));
    cir(x, y, s, 0.5);
    fill(rcol());

    float r = s*random(0.3, 0.5);
    int cc = int(random(12, 40)*random(1));
    float da = TAU/cc;
    int coco = rcol();
    for (int k = 0; k < cc; k++) {
      float a = da*(k+random(1));
      stroke(coco);
      line(x, y, x+cos(a)*r, y+sin(a)*r);
      fill(coco);
      noStroke();
      ellipse(x+cos(a)*r, y+sin(a)*r, 3, 3);
    }
    noStroke();
    cir(x, y, s*random(0.3, 0.7), 0.5);
    if (random(1) < 0.1) {
      fill(rcol());
      //cir(x-s*0.12, y-s*0.06, s*0.1, 2.5);
      //cir(x+s*0.12, y-s*0.06, s*0.1, 2.5);
    }
  }

  /*
  flowers
   background(#F4E9F6);//rcol());
   noStroke();
   for (int i = 0; i < 120; i++) {
   float xx = random(width);
   float yy = random(height);
   float ss = int(pow(2, int(random(0, 5))))*15;
   xx -= xx%60;
   yy -= yy%60;
   xx += random(-10, 10);
   yy += random(-10, 10);
   fill(lerpColor(rcol(), color(0), random(random(1))), random(random(120), 255));
   ellipse(xx, yy, ss, ss);
   }
   */
}


void cir(float x, float y, float s, float rr) {
  float r = s*0.5;
  int res = int(r*PI*rr);
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #0c1cad};
//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #062FAA};
int colors[] = {#ED4715, #FFA3EC, #B0A8FF, #0D110F, #FFB951};
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
  return lerpColor(c1, c2, pow(v%1, 0.4));
}
