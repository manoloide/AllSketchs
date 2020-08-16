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

 //background(#FFF800);
  
  background(rcol());

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    float x = random(-100, width+100);
    float y = random(-100, height+100);
    float s = width*0.4*sqrt(random(1));

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.2) {
        add = false;
        break;
      }
    }

    if (add) points.add(new PVector(x, y, s));
  }


  ArrayList<PVector> pelos = new ArrayList<PVector>();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*0.002*sqrt(random(1));

    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5*0.4) {
        add = false;
        break;
      }
    }


    for (int j = 0; j < pelos.size(); j++) {
      PVector other = pelos.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }


    if (add) pelos.add(new PVector(x, y, s));
  }

  float desAng = random(10000);
  float detAng = random(0.004, 0.009);

  noiseDetail(2);

  fill(0);
  stroke(0, 80);
  for (int i = 0; i < pelos.size(); i++) {
    PVector p = pelos.get(i);

    noStroke();
    ellipse(p.x, p.y, p.z, p.z);

    float r = random(5, 8)*0.9;
    float ang = noise(desAng+p.x*detAng, desAng+p.y*detAng)*TAU*2;
    stroke(0, 80);
    //line(p.x, p.y, p.x+cos(ang)*r, p.y+sin(ang)*r);
    lineSine(p.x, p.y, HALF_PI, p.x+cos(ang)*r, p.y+sin(ang)*r, TAU*2, 0.4);
  }


  ArrayList triangles = Triangulate.triangulate(points);
  ArrayList<PVector> centris = new ArrayList<PVector>();
  stroke(0, 30);
  //fill(255, 40);
  noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);

    centris.add(cen);
  }
  endShape();

  for (int i = 0; i < centris.size(); i++) {
    PVector p = centris.get(i);
    noStroke();
    fill(0, 40);
    ellipse(p.x, p.y, 10, 10);
    fill(0);
    ellipse(p.x, p.y, 4, 4);
  }

  triangles = Triangulate.triangulate(centris);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    if(random(1) < 0.5) continue;
    int col = rcol();
    fill(col, random(255));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
    fill(0, 0);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    fill(0, 60);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();



  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    noStroke();
    fill(255, 110);
    ellipse(p.x, p.y, p.z*0.4, p.z*0.4);
    fill(#FFFFCD);
    ellipse(p.x, p.y, p.z*0.34, p.z*0.34);
    p.z *= random(0.6, 1);
    stroke(rcol(), 200);
    pcircle(p.x, p.y, p.z*0.2);
    stroke(0, 80);
    pcircle(p.x, p.y, p.z*0.1);
  }
}

void lineSine(float x1, float y1, float a1, float x2, float y2, float a2, float s) {
  int res = int(dist(x1, y1, x2, y2)+2)*2;
  float ang = atan2(y2-y1, x2-x1);
  noFill();
  beginShape();
  float dx = cos(ang-HALF_PI);
  float dy = sin(ang-HALF_PI);
  for (int i = 0; i <= res; i++) {
    float xx = map(i, 0, res, x1, x2);
    float yy = map(i, 0, res, y1, y2);
    float aa = cos(map(i, 0, res, a1, a2))*s*map(i, 0, res, 0, 1);
    vertex(xx+aa*dx, yy+aa*dy);
  }
  endShape();
}

void pcircle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(pow(r*0.5, 2)*PI)*20;
  for (int i = 0; i < cc; i++) {
    float aa = random(TAU);
    float rr = sqrt(random(1))*r;
    float xx = x+cos(aa)*rr;
    float yy = y+sin(aa)*rr;
    point(xx, yy);
  }
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
//int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
//int colors[] = {#FE8D31, #FED136, #0047AF}; 
int colors[] = {#FE8D31, #FED136, #0047AF}; 
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
