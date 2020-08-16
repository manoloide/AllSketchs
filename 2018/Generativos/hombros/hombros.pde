import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

// montaña rusa
// cables entre edificios
// añadir carteles
// edificio en obra


// pantallas publictarias
// añadir parque

int farolColor;
int sandColor;

ArrayList<PVector> builds;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  hint(ENABLE_STROKE_PERSPECTIVE);
  rectMode(CENTER);

  generate();
}

void draw() {
  /*
  if (frameCount%60 == 0) {
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

void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(255);

  translate(width*0.5, height*0.55, -200);
  rotateX(HALF_PI);
  rotateY(random(-0.1, 0.1));
  rotateZ(random(-0.1, 0.1));
  
  scale(0.6);
  
  //stroke(rcol(), 200);
  
  stroke(0, 20);
  strokeWeight(0.2);
  
  float ss = random(20, 120);
  for(int i = 0; i < 100000; i++){
    float xx = random(-width, width);
    float yy = random(-height, height);
    float zz = random(-height, height);
    
    xx -= xx%ss;
    yy -= yy%ss;
    zz -= zz%ss;
    noFill();
    pushMatrix();
    translate(xx, yy, zz);
    //box(40);
    modulo1(ss);
    popMatrix();
  } 
}

void modulo1(float s) {modulo1(s, s, s);}

void modulo1(float w, float h, float d){
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;
  int cc = 16;
  for(int i = 0; i < cc; i++){
     float v = map(i, 0, cc-1, -1, 1);
     if(random(1) < 0.5) line(mw*v, -mh, -md, mw*v, +mh, +md);
     if(random(1) < 0.5) line(mw*v, +mh, -md, mw*v, -mh, +md);
     if(random(1) < 0.5) line(mw*v, +mh, +md, mw*v, +mh, -md);
     if(random(1) < 0.5) line(mw*v, -mh, +md, mw*v, -mh, -md);
     if(random(1) < 0.5) line(mw*v, -mh, -md, mw*v, +mh, +md);
     if(random(1) < 0.5) line(mw*v, +mh, -md, mw*v, -mh, +md);
     if(random(1) < 0.5) line(mw, +mh*v, +md, mw, +mh*v, -md);
     if(random(1) < 0.5) line(mw, -mh*v, +md, mw, -mh*v, -md);
     
     
     if(random(1) < 0.5) line(-mw, +mh*v, -md, mw, +mh*v, -md);
     if(random(1) < 0.5) line(-mw, -mh*v, +md, mw, -mh*v, +md);
  }
  //line(-mw, -mh, -md, -mw, +mh, -md);
  //line(-mw, -mh, +md, -mw, +mh, +md);
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
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EFF1F4, #81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
