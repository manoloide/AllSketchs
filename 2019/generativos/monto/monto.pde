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

  background(240);
  randomSeed(seed);


  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);

  ortho(-width/2, width/2, -height/2, height/2, 0.02, 2000);
  translate(width*0.5, height*0.5);
  rotateX(PI*(0.25)+random(-0.2, 0.2));
  rotateZ(PI*(0.25+random(-0.1, 0.1)));

  scale(2.2);
  strokeWeight(0.1);

  rects = new ArrayList<Rect>();
  rects.add(new Rect(-width*0.5, -height*0.5, width, height));

  for (int i = 0; i < 90; i++) {
    Rect r = rects.get(int(random(rects.size()*0.5))); 
    subdivide(r);
  }

  noStroke();
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> wirePoints = new ArrayList<PVector>();


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float h = min(r.w, r.h)*0.08;
    float s = min(r.w, r.h)*0.05;
    points.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5));
    if (random(1) < 0.9) wirePoints.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5, h*3.6));
  }

  for (int i = 0; i < wirePoints.size(); i++) {
    PVector p = wirePoints.get(i);
    pushMatrix();
    translate(p.x, p.y, p.z*0.5);
    rotate(HALF_PI*int(random(4)));
    //box(r.w*0.2, r.h*0.2, h);
    box(p.z*0.02, p.z*0.02, p.z);
    popMatrix();
  }

  ArrayList wires = new ArrayList();
  wires = Triangulate.triangulate(wirePoints);

  noFill();
  //beginShape(TRIANGLES);
  stroke(0, 80);
  strokeWeight(0.4);
  for (int i = 0; i < wires.size(); i++) {
    if (random(1) < 0.8) continue;
    Triangle t = (Triangle)wires.get(i);
    float dist = t.p1.dist(t.p2)*random(0.8, 1)*0.3;
    curve(t.p1.x, t.p1.y, t.p1.z+dist, t.p1.x, t.p1.y, t.p1.z, t.p3.x, t.p3.y, t.p3.z, t.p3.x, t.p3.y, t.p3.z+dist);
    curve(t.p2.x, t.p2.y, t.p2.z+dist, t.p2.x, t.p2.y, t.p2.z, t.p3.x, t.p3.y, t.p3.z, t.p3.x, t.p3.y, t.p3.z+dist);
    curve(t.p2.x, t.p2.y, t.p2.z+dist, t.p2.x, t.p2.y, t.p2.z, t.p1.x, t.p1.y, t.p1.z, t.p1.x, t.p1.y, t.p1.z+dist);

    /*
    float xx, yy, zz, d;
    int c = int(random(-2, 5));
    for (int j = 0; j < c; j++) {

      d = random(1);
      xx = curvePoint(t.p1.x, t.p1.x, t.p3.x, t.p3.x, d);
      yy = curvePoint(t.p1.y, t.p1.y, t.p3.y, t.p3.y, d);
      zz = curvePoint(t.p1.z+dist, t.p1.z, t.p3.z, t.p3.z+dist, d);

      line(xx, yy, zz, xx, yy, zz+random(2, 3));
    }
    */
  }
  //endShape();


  ArrayList triangles = new ArrayList();
  triangles = Triangulate.triangulate(points);

  stroke(0, 2);
  noStroke();
  //noFill();
  fill(rcol());
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
    beginShape(TRIANGLES);
    vertex(t.p1.x, t.p1.y, 4);
    vertex(t.p2.x, t.p2.y, 4);
    vertex(t.p3.x, t.p3.y, 0);


    vertex(t.p1.x, t.p1.y, 4);
    vertex(t.p2.x, t.p2.y, 4);
    vertex(t.p2.x, t.p2.y, 0);

    vertex(t.p1.x, t.p1.y, 4);
    vertex(t.p2.x, t.p2.y, 4);
    vertex(t.p1.x, t.p1.y, 0);
    endShape();
  }

  /*
  beginShape(TRIANGLES);
   for (int i = 0; i < triangles.size(); i++) {
   if (random(1) < 0.2) continue;
   Triangle t = (Triangle)triangles.get(i);
   fill(0);
   vertex(t.p1.x, t.p1.y);
   vertex(t.p2.x, t.p2.y);
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */

  /*
  fill(getColor());
   beginShape(TRIANGLES);
   for (int i = 0; i < triangles.size(); i++) {
   if (random(1) < 0.2) continue;
   Triangle t = (Triangle)triangles.get(i);
   //fill(getColor());
   vertex(t.p1.x, t.p1.y);
   vertex(t.p2.x, t.p2.y);
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */

  /*
  beginShape(TRIANGLES);
   for (int i = 0; i < triangles.size(); i++) {
   if (random(1) < 0.2) continue;
   Triangle t = (Triangle)triangles.get(i);
   fill(0, 20);
   vertex(t.p1.x, t.p1.y);
   fill(0, 0);
   vertex(t.p2.x, t.p2.y);
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */

  /*
  ArrayList<PVector> points = new ArrayList<PVector>();
   for (int i = 0; i < 30; i++) {
   float x = random(width);
   float y = random(height);
   float s = width*random(0.02, 0.12);
   
   boolean add = true;
   for (int j = 0; j < points.size(); j++) {
   PVector o = points.get(j);
   float dis = dist(x, y, o.x, o.y);
   if (dis < (s+o.z)*0.5) {
   add = false;
   break;
   }
   }
   if (add) points.add(new PVector(x, y, s));
   }
   
   for (int j = 0; j < points.size(); j++) {
   
   PVector p = points.get(j);
   float amp = random(0.01);
   float x1 = p.x+random(-p.z, p.z)*amp;//random(width);
   float y1 = p.y+random(-p.z, p.z)*amp;//random(height);
   float x2 = p.x+random(-p.z, p.z)*amp;//random(width);
   float y2 = p.y+random(-p.z, p.z)*amp;//random(height);
   float det1 = random(0.2)*random(1)*random(1);
   float des1 = random(1000);
   float det2 = random(0.2)*random(1)*random(1);
   float des2 = random(1000);
   
   x1 = lerp(x1, x2, 0.92);
   x2 = lerp(x2, x1, 0.92);
   y1 = lerp(y1, y2, 0.92);
   y2 = lerp(y2, y1, 0.92);
   
   float amp1 = random(10);
   float amp2 = random(10);
   
   float ic = random(colors.length);
   float dc = random(0.006)*random(0.1, 1)*random(0.1, 1)*random(0.1, 1);
   
   noiseDetail(1);
   
   float vel = 0.071*random(0.5, 2);
   
   float lar = random(1000, 10000);
   
   for (int i = 0; i < lar; i++) {
   stroke(lerpColor(getColor(ic+dc*i), color(0), cos(i*PI*0.1)*0.16+0.16));
   line(x1, y1, x2, y2); 
   
   float ang1 = (float) SimplexNoise.noise(des1+x1*det1, des1+y1*det1)*TAU*amp1; 
   float ang2 = (float) SimplexNoise.noise(des2+x2*det2, des2+y2*det2)*TAU*amp2; 
   
   float ax1 = x1;
   float ay1 = y1;
   float ax2 = x2;
   float ay2 = y2;
   x1 += cos(ang1)*vel;
   y1 += sin(ang1)*vel;
   x2 += cos(ang2)*vel;
   y2 += sin(ang2)*vel;
   noStroke();
   if (i < lar-2) {
   stroke(255, 250);
   line(ax1, ay1, x1, y1);
   stroke(0, 40);
   line(ax2, ay2, x2, y2);
   }
   }
   }
   */

  //post = loadShader("post.glsl");


  //filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}
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
