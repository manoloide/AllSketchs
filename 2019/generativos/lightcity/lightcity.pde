import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float det, des;
PShader post;


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


ArrayList<Rect> rects;

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}


void subdivide(Rect r) {

  float mw = r.w*0.5;
  float mh = r.h*0.5;
  rects.add(new Rect(r.x, r.y, mw, mh));
  rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
  rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
  rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

  rects.remove(r);
}



void generate() { 

  println(seed);

  background(0);//240);
  randomSeed(seed);


  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);

  ortho();
  translate(width*0.5, height*0.5, -400);
  rotateX(PI*(0.25)+random(-0.3, 0.2));
  rotateZ(PI*(0.25+random(10.5)));

  scale(1.9);
  strokeWeight(0.08);

  rects = new ArrayList<Rect>();
  rects.add(new Rect(-width*0.5, -height*0.5, width, height));

  for (int i = 0; i < 100; i++) {
    Rect r = rects.get(int(random(rects.size()*0.5))); 
    subdivide(r);
  }

  noStroke();
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    points.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5));
  }

  ArrayList triangles = new ArrayList();
  triangles = Triangulate.triangulate(points);

  stroke(0, 240);
  //noStroke();
  //noFill();
  /*
  for (int i = 0; i < triangles.size(); i++) {
   if (random(1) < 0.4) continue;
   Triangle t = (Triangle)triangles.get(i);
   //PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
   float h = random(200)*random(1);
   
   noFill();
   //fill(getColor());
   beginShape(TRIANGLES);
   vertex(t.p1.x, t.p1.y, t.p1.z);
   vertex(t.p2.x, t.p2.y, t.p2.z);
   vertex(t.p3.x, t.p3.y, t.p3.z);
   
   beginShape(TRIANGLES);
   vertex(t.p1.x, t.p1.y, h);
   vertex(t.p2.x, t.p2.y, h);
   vertex(t.p3.x, t.p3.y, h);
   endShape();
   
   beginShape(QUADS);
   vertex(t.p1.x, t.p1.y, h);
   vertex(t.p2.x, t.p2.y, h);
   vertex(t.p2.x, t.p2.y, 0);
   vertex(t.p1.x, t.p1.y, 0);
   
   vertex(t.p3.x, t.p3.y, h);
   vertex(t.p2.x, t.p2.y, h);
   vertex(t.p2.x, t.p2.y, 0);
   vertex(t.p3.x, t.p3.y, 0);
   
   vertex(t.p1.x, t.p1.y, h);
   vertex(t.p3.x, t.p3.y, h);
   vertex(t.p3.x, t.p3.y, 0);
   vertex(t.p1.x, t.p1.y, 0);
   endShape();
   }
   */

  /*
  beginShape(TRIANGLES);
  fill(random(200));
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.2) continue;
    Triangle t = (Triangle)triangles.get(i);
    fill(lerpColor(#66ffc1, color(240), random(1)));
    fill(random(200));
    vertex(t.p1.x, t.p1.y);
    //fill(lerpColor(#66ffc1, color(240), random(1)));
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  */

  strokeWeight(0.1);

  for (int i = 0; i < triangles.size(); i++) {
    //if (random(1) < 0.2) continue;
    Triangle t = (Triangle)triangles.get(i);
    //PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
    float h = random(300)*random(1);

    noFill();  
    //stroke(0, 20);
    /*
    fill(getColor());
    beginShape(TRIANGLES);
    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p2.z);
    vertex(t.p3.x, t.p3.y, t.p3.z);

    beginShape(TRIANGLES);
    vertex(t.p1.x, t.p1.y, h);
    vertex(t.p2.x, t.p2.y, h);
    vertex(t.p3.x, t.p3.y, h);
    endShape();

    beginShape(QUADS);
    vertex(t.p1.x, t.p1.y, h);
    vertex(t.p2.x, t.p2.y, h);
    vertex(t.p2.x, t.p2.y, 0);
    vertex(t.p1.x, t.p1.y, 0);

    vertex(t.p3.x, t.p3.y, h);
    vertex(t.p2.x, t.p2.y, h);
    vertex(t.p2.x, t.p2.y, 0);
    vertex(t.p3.x, t.p3.y, 0);

    vertex(t.p1.x, t.p1.y, h);
    vertex(t.p3.x, t.p3.y, h);
    vertex(t.p3.x, t.p3.y, 0);
    vertex(t.p1.x, t.p1.y, 0);
    endShape();
    */


    int sub1 = int(random(16, 28));
    int sub2 = int(random(16, 28));

    //seguir con los puntos para luego crear ventanas, por ejemplo...
    PVector p1 = new PVector(t.p1.x, t.p1.y, h);
    PVector p2 = new PVector(t.p2.x, t.p2.y, h);
    PVector p3 = new PVector(t.p2.x, t.p2.y, 0);
    PVector p4 = new PVector(t.p1.x, t.p1.y, 0);
    winwin2(p1, p2, p3, p4, sub1, sub2);


    p1 = new PVector(t.p3.x, t.p3.y, h);
    p2 = new PVector(t.p2.x, t.p2.y, h);
    p3 = new PVector(t.p2.x, t.p2.y, 0);
    p4 = new PVector(t.p3.x, t.p3.y, 0);
    winwin2(p1, p2, p3, p4, sub1, sub2);


    p1 = new PVector(t.p1.x, t.p1.y, h);
    p2 = new PVector(t.p3.x, t.p3.y, h);
    p3 = new PVector(t.p3.x, t.p3.y, 0);
    p4 = new PVector(t.p1.x, t.p1.y, 0);

    winwin2(p1, p2, p3, p4, sub1, sub2);
  }

  /*
  post = loadShader("post.glsl");
   
   
   filter(post);
   */
}

void winwin(PVector p1, PVector p2, PVector p3, PVector p4, int sub1, int sub2) {

  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float pos = random(0.2, 0.8)*random(1);

  for (int j = 0; j < sub2; j++) { 
    float m1 = map(j+0.5, 0, sub2+10.5, 0, 1);
    PVector a1 = p1.copy().lerp(p2, m1);
    PVector a2 = p4.copy().lerp(p3, m1);
    for (int i = 0; i < sub1; i++) {
      float m2 = map(i+0.5, 0, sub1+10.5, 0, 1);
      PVector p = a1.copy().lerp(a2, m2);
      pushMatrix();
      translate(p.x, p.y, p.z);
      rotateZ(ang);
      //rect(0, 0, 20, 20);
      fill(0);
      if (random(1) < pos) fill(255);
      box(2, 0.1, 2);
      popMatrix();
    }
  }
}

void winwin2(PVector p1, PVector p2, PVector p3, PVector p4, int sub1, int sub2) {

  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float pos = random(0.2, 0.8)*random(1);

  float dis1 = dist(p1.x, p1.y, p2.x, p2.y);
  float dis2 = abs(p2.z-p3.z);

  float ww = dis1/sub2;
  float hh  = dis2/sub1;

  ww *= random(0.2, 0.9);
  hh *= random(0.2, 0.9);

  for (int j = 0; j < sub2; j++) { 
    float m1 = map(j+0.5, 0, sub2, 0, 1);
    PVector a1 = p1.copy().lerp(p2, m1);
    PVector a2 = p4.copy().lerp(p3, m1);
    for (int i = 0; i < sub1; i++) {
      float m2 = map(i+0.5, 0, sub1, 0, 1);
      PVector p = a1.copy().lerp(a2, m2);
      pushMatrix();
      translate(p.x, p.y, p.z);
      rotateZ(ang);
      //rect(0, 0, 20, 20);
      fill(0);
      if (random(1) < pos) fill(255, 220, 200);
      box(ww, 0.1, hh);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#121B4B, #028594, #E55E7F, #FBAF34, #F0D5CA};
//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
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
