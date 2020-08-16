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
  /*
  if (frameCount%15 == 0) {
   seed = int(random(999999));
   generate();
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.006, 0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*50; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);



  desAng = random(1000);
  detAng = random(0.0008);
  desDes = random(1000);
  detDes = random(0.006, 0.001)*0.125;

  //background(rcol());
  background(#EBE2D5);
  //background(rcol());
  stroke(0, 5);

  ArrayList<PVector> points = new ArrayList<PVector>();

  int cc = 0;
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(random(width), random(height)));
  }

  noFill();
  stroke(0, 12);
  for (int i = 0; i < cc; i++) {
    PVector p1 = points.get(i);
    for (int j = 0; j < cc; j++) {
      PVector p2 = points.get(j);
      float dis = p1.dist(p2);
      if (dis > 200) continue;
      beginShape();
      //vline(p1.x, p1.y, p2.x, p2.y);
      endShape();
    }
  }

  for (int i = 0; i < cc; i++) {
    PVector p = points.get(i);
    fill(#193FA9);
    if (random(1) < 0.5) fill(0);
    circle(p.x, p.y, width*random(0.02, 0.12)*random(1)*0.1);
  }


  for (int k = 0; k < 3; k++) {
    float tam = width*random(0.3, 0.5)*random(0.5, 0.6);

    PVector c1 = new PVector(random(width*0.35, width*0.65), random(height*0.6));
    float a = random(random(0, HALF_PI), random(HALF_PI, PI));
    PVector c2 = new PVector(c1.x+cos(a)*tam, c1.y+sin(a)*tam);

    a = random(PI*1.2, PI*1.8);
    PVector cab = new PVector(c1.x+cos(a)*tam*0.5, c1.y+sin(a)*tam*0.5);

    float a1 = random(PI);
    float a2 = random(PI);

    PVector cod1 = c1.copy().add(cos(a1)*tam, sin(a1)*tam);
    PVector cod2 = c1.copy().add(cos(a2)*tam, sin(a2)*tam);
    //line(cod1.x, cod1.y, c1.x, c1.y);
    //line(cod2.x, cod2.y, c1.x, c1.y);

    a1 = random(PI);
    a2 = random(PI);
    PVector man1 = cod1.copy().add(cos(a1)*tam, sin(a1)*tam);
    PVector man2 = cod2.copy().add(cos(a2)*tam, sin(a2)*tam);

    a1 = random(PI);
    a2 = random(PI);
    PVector rod1 = c2.copy().add(cos(a1)*tam, sin(a1)*tam);
    PVector rod2 = c2.copy().add(cos(a2)*tam, sin(a2)*tam);

    a1 = random(PI);
    a2 = random(PI);
    PVector pie1 = rod1.copy().add(cos(a1)*tam, sin(a1)*tam);
    PVector pie2 = rod2.copy().add(cos(a2)*tam, sin(a2)*tam);


    noStroke();
    fill(#193FA9);
    if(random(1) < 0.5) fill(0);
    lineToPoly(c1, cab, 0.6);
    lineToPoly(c1, c2, 0.5);
    lineToPoly(c1, cod1, 0.12);
    lineToPoly(c1, cod2, 0.12);
    lineToPoly(cod1, man1, 0.12);
    lineToPoly(cod2, man2, 0.12);
    lineToPoly(rod1, c2, 0.12);
    lineToPoly(rod2, c2, 0.12);
    lineToPoly(rod1, pie1, 0.12);
    lineToPoly(rod2, pie2, 0.12);
  }
}

void lineToPoly(PVector p1, PVector p2, float h) {
  PVector c = p1.copy().add(p2).mult(0.5);
  float size = p1.dist(p2);
  float rot = atan2(p2.y-p1.y, p2.x-p1.x);
  pushMatrix();
  translate(c.x, c.y);
  rotate(rot);
  poly(0, 0, size, size*h, 11, random(TAU));
  popMatrix();
}

void poly(float x, float y, float w, float h, int c, float a) {
  float mw = w*0.5;
  float mh = h*0.5;
  float da = TAU/c;
  PVector p;
  beginShape();
  for (int i = 0; i < c; i++) {
    p = desform(x+cos(a+da*i)*mw, y+sin(a+da*i)*mh);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void vrect(float x, float y, float w, float h) {
  vquad(x-w*0.5, y-h*0.5, x+w*0.5, y-h*0.5, x+w*0.5, y+h*0.5, x-w*0.5, y+h*0.5);
}

void vquad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  beginShape();
  vline(x1, y1, x2, y2);
  vline(x2, y2, x3, y3);
  vline(x3, y3, x4, y4);
  vline(x4, y4, x1, y1);
  endShape(CLOSE);
}

void vline(float x1, float y1, float x2, float y2) {
  int cc = int(dist(x1, y1, x2, y2)*0.2);
  cc = max(cc, 2);
  for (int i = 0; i < cc; i++) {
    float v = map(i, 0, cc-1, 0, 1);
    PVector p = desform(lerp(x1, x2, v), lerp(y1, y2, v));
    vertex(p.x, p.y);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
