import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  ArrayList<PVector> points = new ArrayList<PVector>();

  background(60);
  float detRot = random(0.005);
  noStroke();
  for (int k = 0; k < 10000; k++) {
    float x = random(width);
    float y = random(height);
    float a = noise(x*detRot, y*detRot)*TAU*2;
    pushMatrix();
    translate(x, y);
    rotate(a);
    fill(0, random(60));
    rect(0, 0, 10, 100);
    popMatrix();
  }

  float desCol = random(colors.length);
  float detSize = random(0.02);
  float detAmp = random(0.03);

  float det = random(4.1);
  noStroke();
  for (int i = 0; i < 14000; i++) {
    float x = random(width); 
    float y = random(height);
    float ns = (float)SimplexNoise.noise(x*detSize, y*detSize)*0.5+0.3;
    ns = pow(ns, 2.2)+0.2;
    ns *= pow(noise(x*detAmp, y*detAmp), 0.5)*940;
    ns *= random(0.4, 1);
    float s = ns;//*9*int(random(4, random(12)*random(0.2, 1)));

    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }


    if (add) {
      points.add(new PVector(x, y, s));
      fill(255, random(60));
      //ellipse(x+s*random(-0.02, 0.02), y+s*random(-0.02, 0.02), s*1.02, s*1.02);
      float valCol = desCol+sqrt(s)*0.4;
      int col = lerpColor(color(255), getColor(valCol), random(0.6, 1));
      col = lerpColor(color(0), col, random(0.8, 1));

      int col2 = getColor(valCol+3.2);

      int res = int(s*PI*3.5);
      fill(col, 20);
      stroke(255, 2);
      float amp = random(0.6, 1.6);
      float mw = random(random(0.3, 0.8), 1);
      float mh = random(random(0.3, 0.8), 1);
      float rotx = random(-0.8, 0.8);
      float roty = random(-0.8, 0.8);
      float da = random(TAU);
      for (int k = 0; k < res; k++) {
        float ang = da+map(k, 0, res, 0, TAU*3);
        float w = noise(x+cos(ang)*det, y+sin(ang)*det)*s*amp*random(0.8, 1)*mw;
        float h = noise(y+sin(ang)*det, x+cos(ang)*det)*s*amp*random(0.8, 1)*mh;
        if (random(1) < 0.1) blendMode(ADD);
        else blendMode(NORMAL);
        pushMatrix();
        translate(x, y);
        rotate(ang);
        rotateX(rotx);
        rotateY(roty);
        rect(w*0.02, h*0.02, w, h);
        popMatrix();
      }
      float r = s*0.08;
      res = int(r*r*PI*50);
      for (int k = 0; k < res; k++) {
        float ang = random(TAU);
        float d = r*sqrt(random(1))*random(0.6, 1);
        fill(lerpColor(rcol(), col2, random(0.8, 1)), 40);
        if (random(1) < 0.01) blendMode(ADD);
        else blendMode(NORMAL);
        pushMatrix();
        translate(x+cos(ang)*d, y+sin(ang)*d);
        rotate(ang);
        rect(0, 0, random(s*0.012)*random(0.5, 1), random(s*0.01)*random(0.5, 1));
        popMatrix();
      }
      //ellipse(x, y, s, s);
    }
  }

  blendMode(NORMAL);
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
