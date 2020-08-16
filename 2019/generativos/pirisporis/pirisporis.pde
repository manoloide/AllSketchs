import org.processing.wiki.triangulate.*;

int seed = int(random(999999));
float det, des;


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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  hint(DISABLE_DEPTH_TEST);

  float fov = PI/4.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5);
  rotateX(random(-0.2, 0.2));
  rotateY(random(-0.2, 0.2));
  rotateZ(random(TAU));

  scale(1.2);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*0.6, height*0.6));
  for (int i = 0; i < 30; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float xx = r.x+random(-7, 7);
    float yy = r.y+random(-7, 7);
    points.add(new PVector(xx, yy));
  }


  noFill();
  blendMode(BLEND);

  strokeWeight(0.6);
  stroke(120, 80);
  Spline spline = new Spline(points);
  spline.show();

  blendMode(ADD);

  float rot = 0.1*random(0.8, 14);//random(10.008)*random(1);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    PVector p = points.get(i);
    pushMatrix();
    translate(p.x, p.y);
    float d = min(r.w, r.h)*0.8;
    float dg = (int(random(1.6))*50);
    float db = (int(random(1.2))*20);

    pushMatrix();
    for (int j = 0; j < d*2; j++) {
      strokeWeight(random(0.1, 0.2));
      rotateX(random(-rot, rot));
      rotateY(random(-rot, rot));
      rotateZ(random(-rot, rot));
      stroke(255, 14+dg, 5+db, random(5, 50));
      box(r.w*random(0.1, 0.2), r.h*random(0.1, 0.2), d*random(0.1, 0.2));
      stroke(9+dg, 5+db, 90, random(5, 50));
      if (random(1) < 0.4) box(r.w, r.h, d);
    }
    popMatrix();

    /*
    float o1 = random(2);
     float o2 = random(2);
     float o3 = random(2);
     //stroke(255);
     for (int j = 0; j < 100; i++) {
     float v = j*0.2;
     //point(cos(v*o1)*r.w*0.5, sin(v*o2)*r.h*0.5, cos(v*o3)*d*0.5);
     }
     */

    popMatrix();
  }



  for (int j = 0; j < 2000; j++) {
    PVector p = spline.getPoint(random(1));
    stroke(rcol(), random(140));
    strokeWeight(random(2));
    point(p.x+random(-2, 2)*random(1), p.y+random(-2, 2)*random(1), p.z+random(-2, 2)*random(1));
  }

  rectMode(CENTER);
  for (int j = 0; j < 2000; j++) {
    float val = random(1);
    PVector p = spline.getPoint(val);

    pushMatrix();
    translate(p.x, p.y, p.z);
    rotateVector(spline.getDir(val));
    stroke(rcol(), random(120));
    strokeWeight(random(2));
    noStroke();
    fill(rcol(), 120);
    ellipse(0, 0, 2, 2);
    popMatrix();
  }


  /*
  ArrayList triangles  = Triangulate.triangulate(points);
   
   stroke(200, 4);
   beginShape(TRIANGLES);
   
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = (Triangle)triangles.get(i);
   fill(255, random(40));
   vertex(t.p1.x, t.p1.y);
   fill(255, random(40));
   vertex(t.p2.x, t.p2.y);
   fill(255, random(40));
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */
}

void grid(float s, int cc) {
  float ms = s*0.5; 
  for (int i = 0; i <= cc; i++) {
    float ss = map(i, 0, cc, -ms, ms);
    line(-ms, ss, +ms, ss);
    line(ss, -ms, ss, +ms);
  }
}

void rotateVector(PVector d) {
  float rx = asin(-d.y);
  float ry = atan2(d.x, d.z);
  rotateY(ry);
  rotateX(rx);
}

class Spline {
  ArrayList<PVector> points;
  float dists[];
  float length;
  Spline(ArrayList<PVector> points) {
    this.points = points;
    calculate();
  }

  void calculate() {
    dists = new float[points.size()+1];
    length = 0; 

    int res = 10;
    for (int i = 0; i <= points.size(); i++) {
      float ndis = 0;
      PVector ant = getPointLin(i);
      for (int j = 1; j <= res; j++) {
        PVector act = getPointLin(i+j*1./res);
        ndis += ant.dist(act);
        ant = act;
      }
      dists[i] = length;
      if (points.size() != i) length += ndis;
    }
  }

  void show() {
    PVector p1, p2, p3, p4;
    p1 = points.get(points.size()-1);
    p2 = points.get(0);
    p3 = points.get(1);
    p4 = points.get(2);
    curveTightness(0);
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    for (int i = 0; i < points.size()-1; i++) {
      p1 = points.get(i);
      p2 = points.get(i+1);
      p3 = points.get((i+2)%points.size());
      p4 = points.get((i+3)%points.size());
      curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    }
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
  }

  PVector getPointLin(float v) {
    v = v%points.size();
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }

  PVector getPoint(float v) {
    v = (v%1)*length;
    int ind = 0;
    float antLen = dists[ind];
    float actLen = dists[ind+1];
    while (actLen < v && ind <= points.size()) { 
      ind++;
      antLen = actLen;
      actLen = dists[(ind+1)];
    }
    float m = map(v, antLen, actLen, 0, 1);
    return calculatePoint(ind, m);
  }

  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    PVector p1 = points.get((ind-1+ps)%ps);
    PVector p2 = points.get((ind+0+ps)%ps);
    PVector p3 = points.get((ind+1+ps)%ps);
    PVector p4 = points.get((ind+2+ps)%ps);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }

  PVector getDir(float v) {
    PVector act = getPoint(v);
    PVector p1 = act.copy().sub(getPoint(v-0.01));
    PVector p2 = getPoint(v+0.01).sub(act);
    PVector aux = p1.add(p2).mult(0.5);
    return aux.normalize();
  }
}  

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
