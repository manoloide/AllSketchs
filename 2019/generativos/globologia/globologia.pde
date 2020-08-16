import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
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

void generate() {

  //background(lerpColor(rcol(), color(255), random(1)));
  background(0);

  blendMode(ADD);

  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> pts = new ArrayList<PVector>();
  float sw = random(120);
  float sh = random(120);
  for (int i = 0; i < 20; i++) {
    float x = random(width+sw);
    float y = random(height+sh);
    x = x-x%sw;
    y = y-y%sh;

    int ix = int(x/sw);
    int iy = int(y/sh);

    if (iy%2 == 0) {
      x += sw*0.5;
    }

    if (ix%2 == 0) {
      y += sh*0.5;
    }

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < 1) {
        add = false;
        break;
      }
    }

    if (add) {
      points.add(new PVector(x, y));
      pts.add(new PVector(x, y));
    }
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(pts);
  stroke(255, 10);
  beginShape(TRIANGLES);
  float max = 50;
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    fill(rcol(), random(max));
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), random(max));
    vertex(t.p2.x, t.p2.y);
    fill(rcol(), random(max));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  /*
  noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   float ss = int(pow(2, int(random(0, 4))))*10;
   fill(255);
   //ellipse(p.x, p.y, ss*1.02, ss*1.02);
   fill(rcol(), 220);
   ellipse(p.x, p.y, ss, ss);
   fill(rcol(), 220);
   ellipse(p.x, p.y, ss*0.4, ss*0.4);
   arc2(p.x, p.y, ss, ss*6, 0, TAU, rcol(), 20, 0);
   }
   */

  float det = random(0.1, 0.2)*0.02;

  for (int i = 0; i < points.size(); i++) {

    PVector p = points.get(i);
    float x = p.x;
    float y = p.y;

    float ic = random(colors.length);
    float dc = random(0.01);

    float ang = random(-PI, PI);
    noStroke();
    for (int k = 0; k < 2000; k++) {
      ang = lerp(ang, 0, 0.004);
      x += cos(ang+HALF_PI);
      y += sin(ang+HALF_PI);
      fill(getColor(ic+dc*k), 120);
      ellipse(x, y, 2, 1);
    }

    float ss = random(80, 400)*random(0.4, 1);
    for (int k = 0; k < 2400; k++) {
      x = p.x;
      y = p.y;
      //fill(rcol());
      noFill();
      stroke(rcol(), 10);
      float ia = noise(p.x*det, p.y*det)*TAU;
      ang = random(TAU);
      beginShape();
      for (int j = 0; j < ss; j++) {
        vertex(x, y);
        float a = (noise(x*det, y*det))*TAU-ia+ang;
        x += cos(a);
        y += sin(a);
      }
      endShape();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#F582DA, #8187F4, #F2F481, #81F498, #81E1F4};
//int colors[] = {#E65EC9, #5265E8, #F2F481, #81F498, #52D8E8};
//int colors[] = {#FFB2D7, #7918CE, #F4E64B, #D8300A};
//int colors[] = {#ffa632, #d81132, #f2f2f2, #69ccd3, #471dd1};
int colors[] = {#B2354A, #3A48A5, #D69546, #683910, #46BCC9};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}



void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int res = int(max(2, (r1*r2)*PI*0.1));
  float da = (a2-a1)/res;
  //col = rcol();
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= res; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(col, alp2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape();
}
