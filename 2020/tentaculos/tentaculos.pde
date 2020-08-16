import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

PeasyCam cam;

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
  cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

long timePrev;
float delta;
void draw() {

  long time = System.currentTimeMillis()%100000;
  if (frameCount == 1) {
    timePrev = 0;
  }
  delta = (time - timePrev) / 1000.0f;
  timePrev = time;

  randomSeed(seed);
  noiseSeed(seed);

  background(#4050ff);

  strokeWeight(6);
  int res = int(random(80, 340));
  float rad = width*0.1;
  float tt = time*random(0.000002);
  float dz = cos(tt*2000)*20;
  for (int i = 0; i < res; i++) {
    float v = (i*1./res);
    float a = v*TAU+tt;
    float x = cos(a)*rad;
    float y = sin(a)*rad;
    float dd = rad*(1+cos(time*0.001+v*TAU*10)*0.4)*0.4;
    pushMatrix();
    translate(x, y, cos(v*TAU*6+time*0.001)*rad*0.02+dz);
    rotate(a);
    strokeWeight(6);
    stroke(#fcf93d, 240);
    point(0, 0);

    strokeWeight(1.6);
    int sub = 8;
    for (int j = 0; j < sub; j++) {
      float velRot = time*0.00001;//cos(j*v+time*0.0001);
      rotateY(time*0.001*velRot+v*TAU*2);
      rotateX(time*0.001*velRot+v*TAU*8);
      stroke(lerpColor(#fcf93d, color(255), pow(j*1./sub, 0.8)), 240);
      line(0, 0, dd, 0);
      translate(dd, 0);
      dd *= 0.7;
    }
    float oscStr = (1+cos(tt+v*TAU*8)*0.3);
    strokeWeight(4*oscStr);
    point(0, 0);

    //rotateY(time*0.001+v*TAU*2);
    //line(0, 0, dd*0.5, 0);
    popMatrix();
  }
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

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
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
  return lerpColor(c1, c2, pow(v%1, 0.2));
}
