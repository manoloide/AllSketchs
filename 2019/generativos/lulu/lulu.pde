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

  if (mw < 2 || mh < 2) return;
  rects.add(new Rect(r.x, r.y, mw, mh));
  rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
  rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
  rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

  rects.remove(r);
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y; 
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }

  ArrayList<Box> sub() {
    ArrayList<Box> aux = new ArrayList<Box>();
    float mw = w*0.5;
    float mh = h*0.5;
    float md = d*0.5;

    if (mw < 4 || mh < 4 || md < 4) return aux;

    aux.add(new Box(x-mw*0.5, y-mh*0.5, z-md*0.5, mw, mh, md));
    aux.add(new Box(x+mw*0.5, y-mh*0.5, z-md*0.5, mw, mh, md));
    aux.add(new Box(x-mw*0.5, y+mh*0.5, z-md*0.5, mw, mh, md));
    aux.add(new Box(x+mw*0.5, y+mh*0.5, z-md*0.5, mw, mh, md));
    aux.add(new Box(x-mw*0.5, y-mh*0.5, z+md*0.5, mw, mh, md));
    aux.add(new Box(x+mw*0.5, y-mh*0.5, z+md*0.5, mw, mh, md));
    aux.add(new Box(x-mw*0.5, y+mh*0.5, z+md*0.5, mw, mh, md));
    aux.add(new Box(x+mw*0.5, y+mh*0.5, z+md*0.5, mw, mh, md));

    return aux;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);



  hint(DISABLE_DEPTH_TEST);

  background(2);
  blendMode(ADD);

  float dc = 100;

  translate(width*0.5+random(-dc, dc), height*0.5+random(-dc, dc), 800+random(-dc, dc));
  rotateX(random(TAU));
  rotateY(random(TAU));  
  rotateZ(random(TAU));

  strokeWeight(0.7);
  noStroke();

  ambientLight(240, 240, 240);
  directionalLight(30, 20, 10, -1, 1, 0.5);

  scale(2);


  float fov = PI/random(1.12, 1.2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  for (int k = 0; k < 8; k++) {

    float size = random(800, 900)*1.3;
    ArrayList<Box> boxes = new ArrayList<Box>();
    boxes.add(new Box(0, 0, 0, size, size, size));

    for (int i = 0; i < 8000; i++) {
      int ind = int(random(boxes.size()*random(0.4, 0.8)));
      Box b = boxes.get(ind);
      boxes.addAll(b.sub());
      boxes.remove(ind);
    }

    float prob = random(0.6, 0.9);
    float ss = 0.01;
    float rot = 0.05;
    int col = rcol();
    for (int i = 0; i < boxes.size(); i++) {
      Box b = boxes.get(i);

      pushMatrix();
      translate(b.x, b.y, b.z);
      rotateX(random(-rot, rot));
      rotateY(random(-rot, rot));
      rotateZ(random(-rot, rot));
      //fill(col);
      noFill();
      strokeWeight(random(0.2, 0.6));
      stroke(col, random(160, 200));
      //box(b.w*ss, b.h*ss, b.d*ss);

      gridCube(b.w, int(random(1, random(1, b.w*0.02))));
      point(0, 0, 0);

      noStroke();
      stroke(col, 4);
      box(b.w*0.99, b.h*0.99, b.d*0.99);

      popMatrix();
    }
  }
}

void gridCube(float s, int cc) {
  float ms = s*0.5;
  for (int k = 0; k < cc; k++) {
    float z = lerp(-ms, ms, k*1./cc);
    for (int j = 0; j < cc; j++) {
      float y = lerp(-ms, ms, j*1./cc);
      for (int i = 0; i < cc; i++) {
        float x = lerp(-ms, ms, i*1./cc);
        point(x, y, z);
      }
    }
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
