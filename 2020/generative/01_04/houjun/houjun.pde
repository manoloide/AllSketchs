import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 834494;//int(random(999999));

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

float detDes = random(0.001);
float desDes = random(10000);
void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  float detAmp = random(0.01)*random(1);
  float detAng = random(0.002);
  float detAlp = random(0.002);
  float detCol = random(0.002);
  float detLen = random(0.002);

  detDes = random(0.001);
  desDes = random(10000);

  float cx = width*0.5;
  float cy = height*0.5;
  float len = 2;
  //strokeCap(SQUARE);
  //blendMode(ADD);
  float bb = -120;


  float ix = getDes(width*0.5, height*0.5, 999);
  float iy = getDes(width*0.5, height*0.5, 111);

  for (int i = 0; i < 300000; i++) {
    float x = random(bb, width-bb); 
    float y = random(bb, height-bb);
    x -= (x%2)*0.5;
    y -= (y%2)*0.5;
    x -= (x%10)*0.1;
    y -= (y%10)*0.1;
    float a = atan2(cy-y, cx-x);//-HALF_PI;
    float d = dist(cx, cy, x, y)/(width*0.72);
    a += cos(a*TAU*4)*0.3;
    float aa = (noise(x*detAng, y*detAng)*2-1)*HALF_PI*5;
    a += (d+a)*TAU*0.1;
    float c = noise(x*detCol, y*detCol, 200);
    strokeWeight(1);
    float amp = noise(x*detAmp, y*detAmp)*10;
    if (d > 2.6) amp *= 0.1;
    else {
      //float dd = (d)*random(random(1), 1);
      float dd = (0.6-d)*random(random(random(1)), 1);
      x += cos(a+HALF_PI)*dd*width*1.2;
      y += sin(a+HALF_PI)*dd*width*1.2;
    }
    amp *= noise(x*detLen, y*detLen, 10);
    //float ang = TAU*(float)SimplexNoise.noise(y*detAng, x*detAng, 2323)*amp*10;
    int col = getColor(c*colors.length*2+random(1.5)*random(1));
    col = lerpColor(col, color(#161026), random(0.3));
    //int col = color(0);

    x += getDes(x, y, 999)-ix;//(noise(desDes+detDes*x, desDes+detDes*y, 999)*2-1)*200;
    y += getDes(x, y, 111)-iy;//(noise(desDes+detDes*x, desDes+detDes*y, 111)*2-1)*200;

    float alp = lerp(40, 120, noise(x*detAlp, y*detAlp));
    stroke(col, alp);
    float rad = 2;

    for (int k = 0; k < 24; k++) {
      float val = (k+1)*1./24;
      stroke(col, alp*sin(PI*val));
      line(x, y, x+cos(a-aa)*len*amp*rad, y+sin(a-aa)*len*amp*rad);
      line(x, y, x+cos(a+aa)*len*amp*rad, y+sin(a+aa)*len*amp*rad);
      a += 0.1;
    }
    //stroke(rcol(), 250);
    //line(x, y, x+cos(a-a)*len*amp, y+sin(a-a)*len*amp);
    //line(x, y, x+cos(a+a)*len*amp, y+sin(a+a)*len*amp);
    //line(x, y, x+cos(a)*10, y+sin(a)*10);
    //noStroke();
    //fill(0);
    //ellipse(x, y, 2, 2);
  }
}

float getDes(float x, float y, float z) {
  return (noise(desDes+detDes*x, desDes+detDes*y, z)*2-1)*800;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#021CAA, #A686F0, #FAA0DD, #F83A7A, #FFF14D, #b5f797 };
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
