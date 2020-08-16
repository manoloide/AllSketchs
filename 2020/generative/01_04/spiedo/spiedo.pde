import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;


import peasy.PeasyCam;
PeasyCam cam;

int seed = int(random(999999));

float nwidth =  800;
float nheight = 800;
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
  cam = new PeasyCam(this, 400);
  generate();
}

void draw() {

  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  
  float time = millis()*0.001;
  float rotTime1 = time*0.4;
  float rotTime2 = time*0.2;

  randomSeed(seed);
  noiseSeed(seed);
  
  
float fov = PI/random(1, 3);
float cameraZ = (height/2.0) / tan(fov/2.0);
perspective(fov, float(width)/float(height), 
            cameraZ/10.0, cameraZ*10.0);

  background(40);
  
  blendMode(ADD);

  int res = 10000;

  float initAngle = 0;
  float endAngle = PI*random(20);

  float initRadius = width*random(0.1);
  float endRadius = width*random(0.4, 0.6);
  float powRadius = random(0.5, 2);
  
  float initOsc = 0;
  float endOsc = PI*random(400); 
  
  
  float initAmp = width*random(0.01);
  float endAmp = width*random(0.05);; 
  
  float ic = 0;
  float dc = random(0.2)*random(1);
  
  strokeWeight(2);

  noFill();
  stroke(rcol());
  beginShape();
  for (int i = 0; i < res; i++) {
    float v = i*1./res;
    float angle = lerp(initAngle, endAngle, v)+rotTime1;
    float radius = lerp(initRadius, endRadius, pow(v, powRadius));

    float osc = lerp(initOsc, endOsc, v)+rotTime2;
    float amp = lerp(initAmp, endAmp, v);
    
    float osc2 = sin(osc)*amp;

    float xx = cos(angle)*radius+cos(angle)*osc2;    
    float yy = sin(angle)*radius+sin(angle)*osc2;
    float zz = cos(osc)*amp;
    stroke(getColor(ic+dc*i+time));
    vertex(xx, yy, zz);
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
