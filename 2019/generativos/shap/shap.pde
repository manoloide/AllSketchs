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
}

class Cube {
  float x, y, z, w, h, d;
  Cube(float x, float y, float z, float w, float h, float d) {
    this.x = x; 
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);


  background(#04000F);

  blendMode(ADD);

  ortho();

  pushMatrix();
  translate(width*0.5, height*0.5, -300);
  rotateX(-atan(sin(radians(45))));
  rotateY(radians(45));

  //float v1 = random(0.6, 1);
  //float v2 = random(0.6, 1);
  //directionalLight(240*v1, 0, 240*v1, 1, 1, 0);
  //directionalLight(250*v2, 250*v2, 250*v2, 0, 1, 0);
  //directionalLight(250, 250, 250, 0, 1, 1);

  ArrayList<Cube> cubes = new ArrayList<Cube>();
  float s = width*1.2;
  cubes.add(new Cube(0, 0, 0, s, s, s)); 

  int sub = int(random(10, 60)*10);
  for (int i = 0; i < sub; i++) {
    int ind = int(random(cubes.size()*random(0.8, 1)));
    Cube c = cubes.get(ind);
    float mw1 = c.w*random(0.5, 0.5);
    float mw2 = c.w-mw1;
    float mh1 = c.h*random(0.5, 0.5);
    float mh2 = c.h-mh1;
    float md1 = c.d*random(0.5, 0.5);
    float md2 = c.d-md1;
    cubes.add(new Cube(c.x-mw1*0.5, c.y-mh1*0.5, c.z-md1*0.5, mw1, mh1, md1));
    cubes.add(new Cube(c.x+mw2*0.5, c.y-mh1*0.5, c.z-md1*0.5, mw2, mh1, md1));
    cubes.add(new Cube(c.x-mw1*0.5, c.y+mh2*0.5, c.z-md1*0.5, mw1, mh2, md1));
    cubes.add(new Cube(c.x+mw2*0.5, c.y+mh2*0.5, c.z-md1*0.5, mw2, mh2, md1));
    cubes.add(new Cube(c.x-mw1*0.5, c.y-mh1*0.5, c.z+md2*0.5, mw1, mh1, md2));
    cubes.add(new Cube(c.x+mw2*0.5, c.y-mh1*0.5, c.z+md2*0.5, mw2, mh1, md2));
    cubes.add(new Cube(c.x-mw1*0.5, c.y+mh2*0.5, c.z+md2*0.5, mw1, mh2, md2));
    cubes.add(new Cube(c.x+mw2*0.5, c.y+mh2*0.5, c.z+md2*0.5, mw2, mh2, md2));
    if (random(1) < 0.5) cubes.remove(ind);
  }

  for (int i = 0; i < cubes.size(); i++) {
    Cube c = cubes.get(i);
    if (random(1) < 0.3) continue;
    pushMatrix();
    translate(c.x, c.y, c.z);
    noStroke();
    noFill();
    fill(rcol());
    //box(c.w, c.h, c.d);
    int cc = int(c.w*c.h*c.d*0.01*random(1, 2));
    stroke(rcol(), random(30));
    float xx, yy, zz;
    float dd = random(random(0.3, 0.5), random(0.5, 0.95));
    for (int k = 0; k < cc; k++) {
      strokeWeight(random(0.2, 1.2));
      int rnd = int(random(3));
      xx = 0.5*int(int(random(2))*2-1);
      if (rnd != 0) xx *= random(random(dd, 1), 1);
      else xx *= random(random(0.1, 1), 1);
      yy = 0.5*int(int(random(2))*2-1);
      if (rnd != 1) yy *= random(random(dd, 1), 1);
      else yy *= random(random(0.1, 1), 1);
      zz = 0.5*int(int(random(2))*2-1);
      if (rnd != 2) zz *= random(random(dd, 1), 1);
      else zz *= random(random(0.1, 1), 1);
      point(xx*c.w, yy*c.h, zz*c.d);
    }
    popMatrix();
  }
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#F7F9F9, #F7D2DC, #F79620, #04000F, #1A3289};//, #895B00};
int colors[] = {#A00414, #0E2249, #35936E};

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
  return lerpColor(c1, c2, pow(v%1, 1.8));
}
