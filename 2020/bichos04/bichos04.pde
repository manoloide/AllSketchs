import toxi.math.noise.SimplexNoise;

import peasy.PeasyCam;


PeasyCam cam;
int seed = int(random(999999));

void setup() {
  size(displayWidth, displayHeight, P3D); 
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 400);
  generate();
}

long timePrev;
float delta;
void draw() {

  hint(DISABLE_DEPTH_TEST);

  long time = System.currentTimeMillis()%100000;
  if (frameCount == 1) {
    timePrev = 0;
  }
  delta = (time - timePrev) / 1000.0f;
  timePrev = time;

  float x = 0;
  float y = 0;

  int cc = 5000;
  noStroke();
  for (int k = 0; k < cc; k++) {
    float tt = map(k, 0, cc, time*0.001-delta, time*0.001);
    float rot = tt*vel;
    float ss = 1*cos(tt);
    fill(getColor(tt*0.1), random(10)*random(1));
    ellipse(x+cos(rot)*dis, y+sin(rot)*dis, ss, ss);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


float dis = random(1000);
float vel = random(0.01);

void generate() {

  noiseSeed(seed);
  randomSeed(seed);

  background(random(140, 180));

  dis = random(100);
  vel = random(100);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
