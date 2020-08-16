import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

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

  generate();
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


  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  background(20);
  rectMode(CENTER);
  noStroke();

  lights();
  ambientLight(60, 60, 60);


  pushMatrix();
  translate(width*0.5, height*0.7);

  float fov = PI/random(1.2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  rotateX(HALF_PI*random(0.4, 0.9));
  rotateZ(random(TAU)+time*random(-0.1, 0.1));


  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*3-100, height*3-100));

  for (int i = 0; i < 500; i++) {

    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);

    if (r.w < 4 || r.h < 4) continue;

    float w1 = r.w*0.5;
    float w2 = r.w-w1;
    float h1 = r.h*0.5;
    float h2 = r.h-h1;

    rects.add(new Rect(r.x-r.w*0.5+w1*0.5, r.y-r.h*0.5+h1*0.5, w1, h1));
    rects.add(new Rect(r.x+r.w*0.5-w2*0.5, r.y-r.h*0.5+h1*0.5, w2, h1));
    rects.add(new Rect(r.x+r.w*0.5-w2*0.5, r.y+r.h*0.5-h2*0.5, w2, h2));
    rects.add(new Rect(r.x-r.w*0.5+w1*0.5, r.y+r.h*0.5-h2*0.5, w1, h2));

    rects.remove(ind);
  }

  //blendMode(ADD);
  
  noiseDetail(2);

  strokeWeight(1.2);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    noStroke();
    fill(rcol());
    //rect(r.x, r.y, r.w, r.h);


    //noFill();
    //stroke(rcol());

    float hh = max(r.w, r.h)*random(0.5, random(1, 10));
    hh *= random(1);

    int div = int(random(hh/80, hh/120));
    float h = hh/div;

    float rx = random(-0.2, 0.2)*random(1)*noise(time*random(0.2)*random(1), 203);
    float ry = random(-0.2, 0.2)*random(1)*noise(time*random(0.2)*random(1), 100);
    float rz = random(-0.2, 0.2)*random(1)*noise(time*random(0.2)*random(1), 532);

    pushMatrix();
    translate(r.x, r.y, 0);

    //box(h*0.5, h*0.5, h*0.1);


    for (int j = 0; j < div*2; j++) {
      if (j%2 == 0) box(r.w, r.h, h*0.05);
      else box(h*0.02, h*0.02, h*0.02);
      translate(0, 0, h);
      rotateX(rx);
      rotateY(ry);
      rotateY(rz);
    }
    popMatrix();
  }

  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #ED493D, #77C9EC, #C5C4C4};
//int colors[] = {#2B81A2, #040109, #82BA94, #82BA94, #2B81A2};
int colors[] = {#F15005, #7C8EFA, #ffffff};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
