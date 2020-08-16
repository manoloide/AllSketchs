import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
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
  strokeCap(SQUARE);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(0);

  float det = random(0.002, 0.003)*1.5;//*0.3*1.8;
  float detCol = random(0.006, 0.01)*0.8;
  float vel = random(1, 2);

  float floDet = random(0.007, 0.008)*1.6;//*0.3*1.8;
  float colDet = random(0.0005, 0.001)*15;//*0.3*1.8;

  blendMode(ADD);

  ArrayList<PVector> flower = new ArrayList<PVector>();

  int lar = int(random(40, 50));
  for (int i = 0; i < 26000; i++) {
    float xx = width*random(-0.06, 1.06); 
    float yy = height*random(-0.06, 1.06);

    blendMode(ADD);
    noStroke();
    strokeWeight(random(0.4, 1.8));
    //fill(rcol());
    noFill();
    int col = getColor(pow(fbm(xx*detCol+seed, yy*detCol+seed*0.02+seed), 1.6)*back.length*1.1, back, 0.8);
    beginShape();
    noStroke();
    float ang = 0;
    for (int j = 0; j < lar; j++) {
      float a = sin(map(j, 0, 80, 0, PI));
      ang = fbm(xx*det+seed*0.02, yy*det+seed*0.03+seed)*TAU*2;
      stroke(col, 60*pow(a, 1.3));
      xx += cos(ang)*vel;
      yy += sin(ang)*vel;
      vertex(xx, yy);
    }
    flower.add(new PVector(xx, yy));
    endShape();
  }

  for (int j = 0; j < flower.size(); j++) {
    PVector f = flower.get(j);
    float xx = f.x;
    float yy = f.y;
    blendMode(NORMAL);
    noStroke();
    if (fbm(xx*floDet+seed, yy*floDet) < 0.4) {
      for (int k = 0; k < 50; k++) { 
        float aa = random(TAU);
        float dd = random(random(12), 20);
        float rr = random(1, 3);
        int col = getColor(fbm(xx*colDet+seed, yy*colDet)*flowers.length*2+random(2)*random(1), flowers, 1.2);
        fill(lerpColor(col, #3A3A3A, random(0.1)), 250);
        ellipse(xx+cos(aa)*dd, yy+sin(aa)*dd, rr, rr);
      }
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

int back[] = {#F7743B, #9DAAA9, #6894AA, #4F4873, #3A3A3A};
//int flowers[] = {#CC3622, #EDE374, #5A2F84, #2D38AF, #CC1818};
int flowers[] = {#f7f033, #eef6f7, #c0e3f7, #bc94f4, #505edd};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[], float pwr) {
  return getColor(random(colors.length), colors, pwr);
}
int getColor(float v, int colors[], float pwr) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, pwr));
}

float random2 (float x, float y) {
  float d = x*12.9898+y*78.233;
  return (abs(sin(d)*43758.5453123))%1;
}


float noise2 (float x, float y) {
  float ix = floor(x);
  float iy = floor(y);
  float fx = x%1;
  float fy = y%1;

  // Four corners in 2D of a tile
  float a = random2(ix, iy);
  float b = random2(ix+1, iy);
  float c = random2(ix, iy+1);
  float d = random2(ix+1, iy+1);

  float ux = fx * fx * (3.0 - 2.0 * fx);
  float uy = fy * fy * (3.0 - 2.0 * fy);

  return lerp(a, b, ux) +
    (c - a)* uy * (1.0 - ux) +
    (d - b) * ux * uy;
}

float fbm (float x, float y) {
  int oct = 6;
  float val = 0.0;
  float amp = .5;
  for (int i = 0; i < oct; i++) {
    val += amp * noise2(x, y);
    x *= 2.;
    y *= 2.;
    amp *= .5;
  }
  return val;
}
