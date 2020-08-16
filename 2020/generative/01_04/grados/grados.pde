import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
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

void generate() {

  hint(DISABLE_DEPTH_TEST);

  //strokeCap(SQUARE);

  randomSeed(seed);
  noiseSeed(seed);

  background(0);//226);

  blendMode(ADD);
  /*
  float fov = PI/random(2.4, 3);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */

  pushMatrix();
  //translate(width*random(0.15, 0.85), height*random(0.15, 0.85));

  translate(width*0.5, height*0.5);
  scale(0.8+random(0.4)*random(1));

  float desAng = random(TAU);
  int cc = int(random(3, 8)*5);
  float v, r, a, s, alp, det, a1, a2, mm;
  for (int k = 0; k < cc; k++) {
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));

    int c1 = lerpColor(rcol(), color(255), random(0.1)*random(1));
    int c2 = lerpColor(rcol(), color(255), random(0.1)*random(1));

    float amp = random(1, random(2.5, 3.5)*0.8)*1.2;
    float rot = amp*TAU;
    float sub = int(random(4000, 8000)*0.6*amp);

    float sca = 8;

    float r1 = width*random(0.4, 0.6)*0.05*0.5*sca;
    float r2 = width*random(0.7, 0.9)*0.06*0.5*sca;
    float pwrR = random(0.5, 1.5);

    float s1 = width*random(0.3, 0.6)*0.04*sca;
    float s2 = width*random(0.6, 0.8)*0.04*sca;
    float pwrS = random(0.5, 1.5);

    float da = rot/sub;
    noFill();
    //beginShape();
    float oscAmp = random(5, 16)*random(1);
    float alt = random(-0.4, 0.4)*random(1);

    for (int i = 0; i < sub; i++) {
      v = i*1./sub;
      //v += sin(v*TAU);
      r = pow(lerp(r1, r2, v), pwrR);
      a = da*i;
      s = pow(lerp(s1, s2, v), pwrS);
      int col = lerpColor(c1, c2, v);
      alp = 26*sin(PI*v)-random(2);
      stroke(col, alp);
      strokeWeight(1.2*pow(sin(PI*v), 1.2));
      //vertex(cos(a)*r, sin(a)*r);


      det = 0.002*v;
      a1 = v*TAU;
      a1 = ((float)SimplexNoise.noise(100+cos(a1)*det*r, sin(a1)*det*r, k*10)*2-1)*TAU*4;
      a2 = v*TAU;
      a2 = ((float)SimplexNoise.noise(cos(a2)*det*r, 100+sin(a2)*det*r, k*10)*2-1)*TAU*4;
      a1 = a1%TAU;
      a2 = a2%TAU;
      mm = min(a1, a2);
      a2 = max(a2, a1);
      a1 = mm;

      float osc = 1+sin(pow(v, 2.4)*TAU*oscAmp)*0.24+sin(a*6)*0.2;
      pushMatrix();
      float xx = cos(a)*r*osc;
      float yy = sin(a)*r*osc;
      xx += cos(xx*2.01)*1.8;
      yy += sin(yy*2.01)*1.8;
      translate(xx, yy);
      //rotateY(-a);
      rotateY(a);
      //a1 = 0;
      //a2 = TAU;
      arc2(0, 0, s, a1, a2, col, 0, alp, alt, desAng);
      //arc2(0, 0, s, lerp(a1, a2, 0.3), lerp(a1, a2, 0.5), color(255), 0, alp*0.2, alt);
      popMatrix();
    }
  }
  popMatrix();

  //endShape();
}

void arc2(float x, float y, float s, float a1, float a2, int col, float alp1, float alp2, float alt, float desAng) {
  float r = s*0.5;
  float aa = max(a1, a2);
  a1 = min(a1, a2);
  a2 = aa;

  int res = int((a2-a1)*r*PI*0.01);
  noFill(); 
  beginShape();
  float v, a, alp, mod;
  for (int i = 0; i < res; i++) {
    v = (i*1.)/(res-1);
    a = lerp(a1, a2, v);
    alp = lerp(alp1, alp2, v);
    mod = 1+sin(v*PI)*alt+cos(a*res+desAng)*0.001;
    stroke(col, alp);
    vertex(x+cos(a)*r*mod, y+sin(a)*r*mod);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#A1A7F4, #EA77BA, #EA0071, #F70D04, #301156};
//int colors[] = {#FE829C, #6AFFB8, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB, #113826};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
int colors[] = {#060606, #060606, #060606, #060606, #060606, #060606, #90ff00, #ffffff};
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
