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



  blendMode(NORMAL);
  background(0);

  hint(DISABLE_DEPTH_TEST);
  translate(width*0.5, height*0.5);
  //rotateX(random(-0.2, 0.2));
  //rotateY(random(-0.2, 0.2));
  //rotateZ(random(TAU));

  scale(1.9);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*0.5, height*0.5));
  for (int i = 0; i < 120; i++) {
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
    float xx = r.x;
    float yy = r.y;
    points.add(new PVector(xx, yy));
  }


  noFill();

  strokeWeight(0.6);
  stroke(120, 80);
  //Spline spline = new Spline(points);
  //spline.show();

  blendMode(ADD);

  float rot = 0.1*random(0.8, 14);//random(10.008)*random(1);
  for (int i = 0; i < rects.size(); i++) {

    if (random(1) < 0.22) continue;
    Rect r = rects.get(i);
    PVector p = points.get(i);
    pushMatrix();
    float d = min(r.w, r.h)*0.8;
    translate(p.x+d*random(-0.5, 0.5)*random(1), p.y+d*random(-0.5, 0.5)*random(1));
    float dg = (int(random(random(1), 1.6))*random(30, 80));
    float db = (int(random(1.2))*50);

    pushMatrix();
    for (int j = 0; j < d*2.2 ; j++) {

      strokeWeight(random(0.1, 0.2));
      rotateX(random(-rot, rot));
      rotateY(random(-rot, rot));
      rotateZ(random(-rot, rot));
      stroke(255, 22+dg, 5+db, random(4, 16));
      box(r.w*random(0.1, 0.2), r.h*random(0.1, 0.2), d*random(0.1, 0.2));
      //stroke(9+dg, 5+db, 90, random(5, 50));
      if (random(1) < 0.3) box(r.w, r.h, d);
    }
    popMatrix();

    popMatrix();
  }
}

void rotateVector(PVector d) {
  float rx = asin(-d.y);
  float ry = atan2(d.x, d.z);
  rotateY(ry);
  rotateX(rx);
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
