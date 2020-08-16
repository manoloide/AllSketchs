import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

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
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  randPallet();

  scale(scale);

  //background(rcol());

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(5, 5, width-10));

  int sub = int(random(2, 20));
  noStroke();
  noFill();
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));

    rects.remove(ind);
  }

  background(4, 0, 9);

  lights();

  hint(DISABLE_DEPTH_TEST);

  noFill();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    fill(255, random(150)*random(0.2, 1));
    rect(1+r.x, 1+r.y, r.z-2, r.z-2);
    fill(255, 40);
    ellipse(r.x+r.z*0.5, r.y+r.z*0.5, 4, 4);
  }

  hint(ENABLE_DEPTH_TEST);

  for (int i = 0; i < rects.size(); i++) {

    PVector r = rects.get(i);

    float tt = time*random(-1, 1)*random(1);
    float vrx = random(1);
    float vry = random(1);
    float vrz = random(1);

    float ss = r.z*random(0.3, 0.4);

    pushMatrix();
    translate(r.x+r.z*0.5, r.y+r.z*0.5);
    rotateX(vrx*tt);
    rotateY(vry*tt);
    rotateZ(vrz*tt);
    fill(rcol());
    box(ss);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a}; 

//https://coolors.co/ff8eff-f7f718-92ccbc-0c0002-1544a3
//int colors[];
int colors1[] = {#ff8eff, #f7f718, #92ccbc, #0c0002, #1544a3};
int colors2[] = {#060B06, #0806A8, #8ABCF9, #FBDADE, #FF2705};
int colors3[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a};

void randPallet() {
  int rnd = int(random(3));
  if (rnd == 0) colors =  colors1;
  if (rnd == 1) colors =  colors2;
  if (rnd == 2) colors =  colors3;
}
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
  return lerpColor(c1, c2, pow(v%1, 3));
}
