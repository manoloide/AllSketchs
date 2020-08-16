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

  background(140);

  ArrayList<PVector> points = new ArrayList<PVector>();
  float detSize = random(0.02);
  float detAmp = random(0.03);


  //blendMode(ADD);
  pushMatrix();
  translate(width*0.5, height*0.5);
  rotateX(random(-0.2, 0.2));
  rotateY(random(-0.2, 0.2));
  noStroke();
  for (int i = 0; i < 14000; i++) {
    float x = width*random(-0.5, 1.5); 
    float y = height*random(-0.5, 1.5);
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
    }
  }

  blendMode(ADD);
  for (int i = 0; i < 000000; i++) {
    float x = width*random(-0.5, 0.5); 
    float y = height*random(-0.5, 0.5);
    x = x-(x%30)*0.3;
    float dx = 0; 
    float dy = 0;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      float dis = dist(p.x, p.y, x, y);
      float ang = atan2(p.y-y, p.x-x);
      if (dis < p.z) {
        float mult = map(dis, 0, p.z, 1, 0);
        dx += cos(ang)*mult*dis;
        dy += sin(ang)*mult*dis;
      }
    }
    stroke(getColor(), 200*random(1));
    point(x+dx, y+dy);
  }

  blendMode(NORMAL);

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x;
    float y = p.y;
    float s = p.z*0.8;
    for (int j = 0; j < 10; j++) {
      pushMatrix();
      translate(x, y, j*5);
      noStroke();
      fill(0, 120);
      ellipse(3, 3, s+2, s+2);
      fill(int(random(2)*255));
      ellipse(0, 0, s, s);
      circle(0, 0, s*0.94);
      popMatrix();
      s *= 0.95;
    }
  }

  popMatrix();
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int res = int(r*PI*0.5);
  for (int k = 0; k < res; k++) {
    float a = random(TAU);
    noStroke();
    float x2 = x+cos(a)*r;
    float y2 = y+sin(a)*r;
    beginShape();
    fill(255, random(80));
    float str1 = 0;
    float str2 = random(2);
    //strokeWeight(2);
    float ang = atan2(y-y2, x-x2)+HALF_PI;
    vertex(x+cos(ang)*str1, y+sin(ang)*str1);
    vertex(x+cos(ang+PI)*str1, y+sin(ang+PI)*str1);
    //strokeWeight(0.2);
    vertex(x2+cos(ang+PI)*str2, y2+sin(ang+PI)*str2);
    vertex(x2+cos(ang)*str2, y2+sin(ang)*str2);
    endShape();
    noStroke();
    for (int i = 0; i < 40; i++) {
      float v = random(1);
      fill(255*random(0.5, 1), 230*random(0.4, 1), 0);
      float ss = v*1.4*random(0.5, 1);
      if (random(1) < 0.1) ss *= random(1);
      ellipse(lerp(x, x2, v), lerp(y, y2, v), ss, ss);
    }
  }
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
