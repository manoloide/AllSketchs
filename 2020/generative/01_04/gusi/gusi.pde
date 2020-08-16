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

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  ArrayList<PVector> points = new ArrayList<PVector>();

  background(rcol());

  int sep = 6;
  float ss = width*1./(sep-1);
  rectMode(CENTER);
  strokeWeight(2);
  for (int i = 0; i < 30; i++) {
    float x = random(ss, width);
    float y = random(ss, height);
    x -= x%ss;
    y -= y%ss;
    //x += ss*0.5;
    //y += ss*0.5;
    stroke(0, 20);
    fill(rcol());
    int back = rcol();
    int col = rcol();
    while (col == back) col = rcol();
    fill(back);
    strokeWeight(1);
    stroke(0, 20);
    rect(x, y, ss*0.98, ss*0.98);
    float da = random(0.2);
    float da2 = random(0.8);
    float dd = ss*random(0.4, 0.8)*0.05;
    stroke(back, 2);
    int deps = int(random(4, 10));

    float ang = random(TAU);
    float ddd = ss*random(0.00003);

    pushMatrix();
    translate(x, y);
    int cc = 20000;
    float velCol = random(3);
    for (int j = 0; j < cc; j++) {
      float amp = map(j, 0, cc, 2.4, 0);
      pushMatrix();
      float dx = cos(ang)*ddd*j;
      float dy = sin(ang)*ddd*j;
      translate(cos(da*j)*dd+dx, sin(da*j)*dd+dy);
      rotate(da2*j);
      if (random(1) < 0.05) blendMode(ADD);
      else blendMode(NORMAL);
      col = getColor(cos(j*0.0001)*velCol);
      if (random(1) < 0.2) col = lerpColor(col, color(0), random(random(1)));
      if (random(1) < 0.2) col = lerpColor(col, color(255), random(random(1)));
      noStroke();
      fill(col, random(255)*random(1));
      rect(0, 0, random(1, 2)*random(0.2, 0.5), random(ss)*random(0.2, 0.4)*amp);
      popMatrix();
    }
    popMatrix();
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#000000, #0E1C00, #6D9100, #D61406, #E2A218};
int colors[] = {#FF4507, #4111AF, #FF56b6};
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
