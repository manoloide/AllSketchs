import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 58621;//int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;


PShader blur;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  blur = loadShader("blur.glsl");

  generate();

  if (export) {
    saveImage();
    exit();
  }
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


  blur = loadShader("blur.glsl");

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  noStroke();
  /*
  int cc = 120;
   float ss = width*1./cc;
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   fill(rcol());
   rect(i*ss, j*ss, ss, ss);
   }
   }
   */

  float ic = random(colors.length);
  float ac = random(0.2, 1.2);
  int cc = 100;
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    xx = width*random(0.45, 0.55);//0.5;
    yy = height*random(0.45, 0.55);//0.5;
    float ss = width*(1-(i*1./cc))*1.5;
    fill(getColor(i*ac+ic));
    ellipse(xx, yy, ss, ss);
  }

  //nt+random(1000));
  float it = random(100);
  float dt = random(0.01);
  for (int i = 0; i < 8; i++) {
    blur.set("time", it+i*dt);
    float blurAmp = 0.0001+(i*0.0001);
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp);
    filter(blur);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#0A0B0B, #2E361E, #ACB2A4, #B66F3A, #B91A1B};
int colors[] = {#B85807, #FAC440, #F4C8BF, #A0B9A6, #A1B2EA};
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
