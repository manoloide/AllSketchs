import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth = 960; 
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



void generate() { 

  println(seed);
  randomSeed(seed);
  scale(scale);

  background(0);

  float des = random(10000);
  float det = random(0.0001, 0.00014)*0.4;


  float desCol = random(10000);
  float detCol = random(0.001, 0.004)*0.15;

  int cc = int(random(15, 20)*8);
  float ss = width*1./cc;

  //noiseDetail(2);
  for (int k = -10; k < cc+10; k++) {
    for (int j = -10; j < cc+10; j++) {
      ArrayList<PVector> points = new ArrayList<PVector>();
      float x = j*ss;
      float y = k*ss;

      float ang = 0;

      noiseDetail(2);
      for (int i = 0; i < 100; i++) {

        ang = ((float) SimplexNoise.noise(des+x*det, des+y*det)*2-1)*2*HALF_PI;

        ang += random(-0.02, 0.02)*random(1);
        x += cos(ang)*0.5;
        y += sin(ang)*0.5;

        points.add(new PVector(x, y));
      }

      noiseDetail(4);
      noFill();
      stroke(255, 160);
      PVector p = points.get(0);
      float nc = noise(desCol+p.x*detCol, desCol+p.y*detCol);
      //stroke(lerpColor(color(240), color(#D80B0B), curve(nc, 12)), 170);
      stroke(getColor(curve(nc, 12)*colors.length), 170);
      beginShape();
      for (int i = 0; i < points.size(); i++) {
        p = points.get(i);
        vertex(p.x, p.y);
      }
      endShape();
    }
  }
}


float curve(float val, float pwr) {
  float nv = val;
  if (val < 0.5) {
    nv = pow(map(val, 0.0, 0.5, 0, 1), pwr);
  } else {
    nv = pow(map(val, 0.5, 1.0, 1, 0), pwr);
  }
  return nv;
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}
int colors[] = {#F0F0F0, #D80B0B, #000000, #D80B0B};
//int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};x
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
  return lerpColor(c1, c2, v%1);
}
