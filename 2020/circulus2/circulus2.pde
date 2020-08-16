import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

int seed = 535405;//int(random(999999));

float nwidth =  1920; 
float nheight = 1080;
float swidth = 1920; 
float sheight = 1080;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  //cam = new PeasyCam(this, 400);
  frameRate(30);
  hint(DISABLE_DEPTH_TEST);
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

//long timePrev;
//float delta;
void draw() {
  /*
  long time = System.currentTimeMillis()%100000;
   if (frameCount == 1) {
   timePrev = 0;
   }
   delta = (time - timePrev) / 1000.0f;
   timePrev = time;
   */
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'c') 
    background(0);
  else {
    seed++;// = int(random(999999));
    println(seed);
    generate();
  }
}

float time;
void generate() {

  if (frameCount%(10*30) == 0) {
    seed++;
  }

  randomSeed(seed);
  noiseSeed(seed);

  //time = (System.currentTimeMillis()%10000000)*0.0001;
  time = 10000+(frameCount*(1./30))*0.16;//*0.001;
  float bb = -0.4;
  float dx = width*(random(-bb, 1+bb)+cos(time*random(TAU*0.1)*random(0.2)));
  float dy = height*(random(-bb, 1+bb)+cos(time*random(TAU*0.1))*random(0.2));
  translate(dx, dy, -200);
  rotateX(random(-1, 1)*random(0.6));
  rotateY(random(-1, 1)*random(0.6));

  randomSeed(seed);
  noiseSeed(seed);

  background(10);//240);

  /*
  float fov = PI/random(2, 3);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */
  float detCol = random(0.002);
  for (float i = 0.02; i <= 0.8; i+=0.05) {
    //for (float i = 0.25; i <= 1; i+=0.25) {
    int col = rcol();
    int res = int(random(180, 340)*1.2*0.8);
    aro(0, 0, i*20, width*0.7*i, res, col, detCol);
  }

  if (export) {
    if (frameCount > 1800) exit();
    saveFrame("export/f####.png");
  }
}

void aro(float x, float y, float z, float s, int res, int col, float detCol) {

  strokeWeight(6);
  float rad = s;
  float tt = time*random(0.02, 0.08);
  float dz = cos(tt*20)*20;
  float desCol = 100;
  float velRotX = random(0.4);//time*0.00001;//cos(j*v+time*0.0001);
  float velRotY = random(0.4);//time*0.00001;//cos(j*v+time*0.0001);

  for (int i = int(res*0.0); i < res*1.0; i++) {
    float v = ((i+random(0.2))*1./res);
    float a = TAU*v+tt;
    float xx = x+cos(a)*rad;//+random(-rad, rad);//;
    float yy = y+sin(a)*rad;//+random(-rad, rad);//;
    //float v = dist(xx, yy, 0, 0)/rad;
    //float a = atan2(yy, xx);
    col = getColor(noise(desCol+xx*detCol, desCol+yy*detCol, seed*0.001)*9+random(1)*random(0.6));
    float dd = rad*(1+cos(time*0.001+v*TAU*10)*0.4)*0.18;
    pushMatrix();
    translate(xx, yy, cos(v*TAU*6+time*0.00004+i*0.73)*rad*0.02+dz+z);
    rotate(a);
    strokeWeight(sqrt(rad)*0.06);
    //stroke(#fcf93d, 240);
    stroke(col, 240);
    point(0, 0);

    int sub = 14;
    for (int j = 0; j < sub; j++) {
      float modAlp = cos(time*random(0.1))*random(10);
      strokeWeight(0.6+(sub-j)*0.05);
      rotateY(time*velRotX+v*TAU*1);
      rotateX(time*velRotY+v*TAU*4);
      stroke(random(255), 50);
      line(0, 0, dd, 0);
      int cc = lerpColor(col, color(255), pow(j*1./sub, 2.4));
      stroke(cc, 108+modAlp);
      line(0, 0, dd, 0);
      stroke(cc, 48+modAlp);
      for (int k = 0; k < 8; k++) {
        float vv = k*1./8;
        float dx = lerp(0, dd, vv);
        float ddd = lerp(0, dd*1.1, vv)*random(0.6, 1);
        line(dx, 0, dx+ddd*vv, ddd);
        line(dx, 0, dx+ddd*vv, -ddd);
      }
      translate(dd, 0);
      dd *= 0.78;
    }
    float oscStr = (1+cos(tt*20+v*TAU*8)*random(1));
    strokeWeight(sqrt(rad)*0.05*oscStr);
    stroke(255, 200);
    point(0, 0);

    //rotateY(time*0.001+v*TAU*2);
    //line(0, 0, dd*0.5, 0);
    popMatrix();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
int colors[] = {#EA1764, #F7AA06, #005AD8};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
