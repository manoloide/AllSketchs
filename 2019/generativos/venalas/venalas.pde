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
  size(int(swidth*scale), int(sheight*scale), P3D);
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

  float det1 = random(0.002, 0.003)*0.6;//*0.3*1.8;
  float det2 = random(0.002, 0.003)*0.6;//*0.5*1.8;

  float detCol1 = random(0.006, 0.01)*0.1;
  float detCol2 = random(0.006, 0.01)+0.4;

  float vel = 2;//random(1, 2);

  blendMode(ADD);

  int lar = int(random(40, 50)*0.8);

  for (int i = 0; i < 24000; i++) {
    float xx = width*random(-0.06, 1.06); 
    float yy = height*random(-0.06, 1.06);

    noStroke();
    //strokeWeight(random(0.8, 1.8));
    //fill(rcol());
    noFill();
    float detCol = detCol1;
    if (random(1) < 0.4) detCol = detCol2;
    int col = getColor(pow(fbm(xx*detCol, yy*detCol+seed), 1.4)*colors.length*3);
    beginShape();
    noStroke();
    fill(col, 40);
    float ang = 0;
    int lim = int(lar*random(0.45, 0.55));
    for (int j = 0; j < lar; j++) {
      float a = sin(map(j, 0, 80, 0, PI));
      if (j < lim) ang = fbm(xx*det1+seed, yy*det1+seed)*TAU*4;
      else ang = fbm(xx*det2+seed, yy*det2+seed)*TAU*8;
      //stroke(col, 250*pow(a, 1.8));
      xx += cos(ang)*vel;
      yy += sin(ang)*vel;
      vertex(xx, yy);
    }
    endShape();
    //ellipse(xx, yy, 3, 3);
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

int colors[] = {#23364a, #77213f, #693100, #4C0700, #060e47};
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
