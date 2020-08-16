import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PShader noi;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

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

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  int grid = 30;

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");
  noi.set("displace", random(100));

  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < 280; i++) {
    float x = random(grid, width);
    float y = random(grid, height);
    //x = lerp(x, width*0.5, random(0.5));
    //y = lerp(y, height*0.5, random(0.5));
    x -= x%grid;
    y -= y%grid;
    float s = int(random(3, random(4, 9)))*grid*0.125;
    float alp = random(50)*random(1);

    float ic = random(colors.length);
    float dc = random(colors.length)*random(1);

    int sub = int(random(1, 10));
    for (int k = 1; k <= sub; k++) {
      int col = getColor(ic+dc*k);
      noi.set("displace", random(100));
      shader(noi); 
      circle(x, y, s*k, s*k*2, col, alp);
      circle(x, y, s*k, s*(k-1), col, alp);
    }
  }
}


void circle(float x, float y, float s1, float s2, int col, float alp) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float aa = TAU;
  int res = int((aa)*max(r1, r2)*PI*0.1);
  beginShape(QUADS);
  for (int i = 0; i < res; i++) {
    float v1 = (i*1.+0.0)/(res);
    float v2 = (i*1.+1.0)/(res);
    float a1 = lerp(0, aa, v1);
    float a2 = lerp(0, aa, v2);
    fill(col, alp);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    fill(col, 0);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
int colors[] = {#4E87C5, #BA8FE7, #F76A0B};
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
