import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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
  
  if(mw < 2 || mh < 2) return;
  rects.add(new Rect(r.x, r.y, mw, mh));
  rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
  rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
  rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

  rects.remove(r);
}



void generate() { 

  randomSeed(seed);


  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);

  hint(DISABLE_DEPTH_MASK);

  beginShape();
  fill(rcol());
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape();

  ortho();
  translate(width*0.5, height*0.5);
  rotateX(PI*(0.1)+random(-0.1, 0.1));
  rotateZ(PI*(0.25));

  scale(1.8+random(0.2));

  rects = new ArrayList<Rect>();
  rects.add(new Rect(-width, -height, width*2, height*2));

  for (int i = 0; i < 4000; i++) {
    Rect r = rects.get(int(random(rects.size()*0.1))); 
    subdivide(r);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    noFill();
    rect(r.x, r.y, r.w, r.h);
    int col = rcol();
    //shadow(r  .x, r.y, r.w, r.h, col, int(random(4)));
    float s = min(r.w, r.h)*0.05;
    fill(rcol());
    //ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.2, r.w*0.2);
    points.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5));
  }

  ArrayList triangles = new ArrayList();
  triangles = Triangulate.triangulate(points);

  stroke(0, 220);
  strokeWeight(0.2);

  float des = random(1000);
  float det = random(0.0005);

  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector c = t.p1.copy().add(t.p2).add(t.p3).mult(3);
    fill(getColor(noise(des+c.x*det, des+c.y*det)*40));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();


  stroke(0, 80);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.2) continue;
    Triangle t = (Triangle)triangles.get(i);
    fill(0, 40);
    vertex(t.p1.x, t.p1.y);
    fill(0, 0);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  stroke(0, 20);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    //if (random(1) < 0.2) continue;
    Triangle t = (Triangle)triangles.get(i);
    PVector c = t.p1.copy().add(t.p2).add(t.p3).div(3);

    fill(255, 20);
    vertex(c.x, c.y);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);


    fill(0, 20);
    vertex(c.x, c.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  hint(ENABLE_DEPTH_MASK);

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    ///fill(rcol(), 40);
    //rect(r.x, r.y, r.w, r.h);

    pushMatrix();
    translate(0, 0, 6);
    fill(rcol());
    ellipse(r.x, r.y, r.w*0.2, r.h*0.2);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
///int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
