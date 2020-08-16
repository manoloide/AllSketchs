import geomerative.*;
import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

// dibujar corazon y patrones
// buscar colores mas piolas
// jugar con el tamaño de los cubos


RShape grp;
RShape[] letters;

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

  RG.init(this);
  grp = RG.getText("corazon digital", "font.ttf", 40, CENTER);
  int cc = grp.countChildren();
  letters = new RShape[cc];
  for (int i = 0; i < cc; i++) {
    letters[i] = grp.children[i];
  }

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
  
  
  int aux[] = {#fe6b56, #fdd15f, #fecdec, #63D1A3, #6297C6};
  colors = aux;

  randomSeed(seed);
  noiseSeed(seed);



  desAng = random(1000);
  detAng = random(0.0008);
  desDes = random(1000);
  detDes = random(0.006, 0.001)*0.5;

  //background(rcol());
  background(255);

  int cc = int(random(40, 50)*4);
  float ww = width*1./cc;
  float hh = height*1./cc;
  for (int j = -5; j < cc+5; j++) {
    for (int i = -5; i < cc+5; i++) {
      if ((i+j)%2 == 0) fill(0);
      else fill(255);
      fill(rcol());
      vrect(i*ww, j*hh, ww*0.6, hh*0.6);
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 140; i++) {
    float x = random(width); 
    float y = random(height); 
    float s = width*random(0.1, 0.5)*random(1)*random(1)*random(0.5, 1);

    points.add(new PVector(x, y));


    fill(0);
    vrect(x+5, y+5, s, s);

    fill(rcol());
    vrect(x, y, s, s);

    stroke(rcol(), 24);
    fill(rcol());
    circle(x, y, s*0.8);

    fill(rcol());
    if (random(1) < 0.5)  vrect(x, y, s*0.5, s*0.5);
    fill(rcol());
    if (random(1) < 0.1) vrect(x, y, s*0.1, s*0.1);
  }

  /*
  ArrayList triangles = Triangulate.triangulate(points);
   stroke(0, 240);
   noFill();
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = (Triangle)triangles.get(i);
   beginShape();
   vline(t.p1.x, t.p1.y, t.p2.x, t.p2.y);
   vline(t.p2.x, t.p2.y, t.p3.x, t.p3.y);
   vline(t.p3.x, t.p3.y, t.p1.x, t.p1.y);
   endShape(CLOSE);
   
   }
   */
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

void water() {
  //randomSeed(seed);
  noiseSeed(seed);
  float det = 0.02;
  for (int j = 0; j < letters.length; j++) {
    RShape shape = letters[j];
    RPoint[] points = shape.getPoints();
    beginShape();
    for (int i = 0; i < points.length; i++) {
      RPoint p = points[i];
      float ang = noise(p.x*det, p.y*det, 000)*TWO_PI;
      float dd = noise(p.x*det, p.y*det, 971)*3*0;
      float dx = cos(ang)*dd;
      float dy = sin(ang)*dd;
      float xx = p.x+dx;
      float yy = p.y+dy;
      PVector a = new PVector(xx, yy);// desform(xx, yy);
      vertex(a.x, a.y);
    }
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
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
