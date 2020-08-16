import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  background(0);


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

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);

  background(255);

  lights();

  //blendMode(DARKEST);


  for (int i = 0; i < 1000; i++) {
    float s = random(2, 3)*0.6;
    noStroke();
    fill(rcol(), random(40));
    ellipse(random(width), random(height), s, s);
  }


  translate(width/2, height/2);

  for (int k = 0; k < 80; k++) {
    float ax = width*random(-0.6, 0.6);
    float ay = height*random(-0.6, 0.6);

    float maxSize = random(20, 70);
    for (int i = 0; i < 40; i++) {
      float ang = random(TAU);
      float dis = random(maxSize)*random(0.4, 1);
      float x = ax+cos(ang)*dis;
      float y = ay+sin(ang)*dis;
      vline(ax, ay, x, y, 3, random(20, 200));
      ax = x;
      ay = y;
    }
  }

  stroke(255, 5);
  fill(0, 200);
  for (int k = 0; k < 80; k++) {
    float ax = width*random(-0.6, 0.6);
    float ay = height*random(-0.6, 0.6);

    float maxSize = random(120, 300);
    for (int i = 0; i < 20; i++) {
      float ang = random(TAU);
      float dis = random(maxSize)*random(0.4, 1);
      float x = ax+cos(ang)*dis;
      float y = ay+sin(ang)*dis;
      vline2(ax, ay, x, y, 120, random(200, 300));
      ax = x;
      ay = y;
    }
  }
}

void vline(float x1, float y1, float x2, float y2, float ampMax, float alphaMax) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  int cc = int(dis*2);
  noStroke();
  fill(30, 200);
  beginShape(QUAD_STRIP);
  float ic = random(colors.length);
  float dc = random(0.01);
  float a = random(1, ampMax)*random(0.2, 1)*random(0.2, 1);
  for (int i = 0; i <= cc; i++) {
    float v = map(i, 0, cc, 0, 1);
    PVector p = displace(lerp(x1, x2, v), lerp(y1, y2, v));

    float amp = 0.1+sin(v*PI)*0.9;
    fill(getColor(ic+dc*i), alphaMax*amp);
    vertex(p.x+cos(ang-HALF_PI)*amp*a, p.y+sin(ang-HALF_PI)*amp*a, p.z*amp);
    vertex(p.x+cos(ang+HALF_PI)*amp*a, p.y+sin(ang+HALF_PI)*amp*a, p.z*amp);
  }
  endShape();
}

void vline2(float x1, float y1, float x2, float y2, float ampMax, float alphaMax) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  int cc = int(dis*2);
  fill(30, 200);
  beginShape(QUAD_STRIP);
  float ic = random(colors.length);
  float dc = random(0.01);
  float a = random(1, ampMax)*random(0.2, 1)*random(0.2, 1);
  float pwr = random(0.5, 2);
  for (int i = 0; i <= cc; i++) {
    float v = map(i, 0, cc, 0, 1);
    PVector p = displace(lerp(x1, x2, v), lerp(y1, y2, v));

    float amp = 0.1+pow(sin(v*PI), pwr)*0.9;
    fill(getColor(ic+dc*i), alphaMax*amp);
    vertex(p.x+cos(ang-HALF_PI)*amp*a, p.y+sin(ang-HALF_PI)*amp*a, p.z*amp);
    vertex(p.x+cos(ang+HALF_PI)*amp*a, p.y+sin(ang+HALF_PI)*amp*a, p.z*amp);
  }
  endShape();
}

PVector displace(float x, float y) {
  float zz = abs(cos(x*0.02)*sin(y*0.02)*16);
  return new PVector(x+abs(cos(y*0.2))*0.5, y+abs(sin(x*0.2))*0.5, zz);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}
int colors[] = {#ffffff, #B0E7FF, #143585, #4c7f60, #D08714, #F98FC0};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
