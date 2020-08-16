import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

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
  //cam = new PeasyCam(this, 400);

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
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

float time;
void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  time = random(1000000);//(System.currentTimeMillis()%10000000)*0.001;

  translate(width*0.5, height*0.5, -200);
  rotateX(random(-1, 1)*random(0.4));
  rotateY(random(-1, 1)*random(0.4));

  randomSeed(seed);
  noiseSeed(seed);

  background(255);

  /*
  float fov = PI/random(2, 3);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */
  int res = int(random(80, 100)*2);
  float detCol = random(0.002);
  for (float i = 0.02; i <= 1; i+=0.025) {
    int col = rcol();
    aro(0, 0, i*20, width*0.7*i, res, col, detCol);
  }


  noStroke();
  int div = int(random(5, 10));
  float siz = width*3.8/div;
  for (int j = 0; j < div; j++) {
    for (int k = 0; k < div; k++) {
      float bx = map(k, 0, div, -siz, siz);
      float by = map(j, 0, div, -siz, siz); 
      pushMatrix();
      translate(bx, by, 0);
      fill(rcol(), 180);
      box(siz*0.1);
      popMatrix();
    }
  }
}

void aro(float x, float y, float z, float s, int res, int col, float detCol) {

  strokeWeight(6);
  float rad = s;
  float tt = time*random(0.000002);
  float dz = cos(tt*2000)*20;
  float desCol = 100;
  for (int i = 0; i < res; i++) {

    if (random(1) < 0.05) continue;
    //if(random(1) < 0.1) blendMode(ADD);
    //else blendMode(NORMAL);

    float v = (i*1./res);
    float a = v*TAU+tt;
    float xx = x+cos(a)*rad;
    float yy = y+sin(a)*rad;
    col = getColor(noise(desCol+xx*detCol, desCol+yy*detCol)*9);
    int ligth = lerpColor(rcol(), color(255), random(1));
    float dd = rad*(1+cos(time*0.001+v*TAU*10)*0.4)*0.18;
    pushMatrix();
    translate(xx, yy, cos(v*TAU*6+time*0.001)*rad*0.02+dz+z);
    rotate(a);
    strokeWeight(sqrt(rad)*0.06);
    //stroke(#fcf93d, 240);
    stroke(col, 240);
    point(0, 0);

    strokeWeight(1.2);
    int sub = 20;
    for (int j = 0; j < sub; j++) {
      float velRot = time*0.00001;//cos(j*v+time*0.0001);
      rotateY(time*0.001*velRot+v*TAU*2);
      rotateX(time*0.001*velRot+v*TAU*8);
      stroke(random(255), 20);
      line(0, 0, dd, 0);
      stroke(lerpColor(col, ligth, pow(j*1./sub, 1.6)), 40);
      line(0, 0, dd, 0);
      for (int k = 0; k < 8; k++) {
        float vv = k*1./8;
        float dx = lerp(0, dd, vv);
        float ddd = lerp(0, dd*1.1, vv)*random(0.6, 1);
        line(dx, 0, dx+ddd*vv, ddd);
        line(dx, 0, dx+ddd*vv, -ddd);
      }
      translate(dd, 0);
      dd *= 0.84;
    }
    float oscStr = (1+cos(tt+v*TAU*8)*0.3);
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


int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
