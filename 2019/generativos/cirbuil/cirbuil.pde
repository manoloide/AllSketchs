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


  float fov = PI/random(1.14, 1.3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  translate(width*0.5+random(-4, 4), height*0.5+random(-4, 4), 710);
  float rot = 0.11;
  rotateX(random(-rot, rot));
  rotateY(random(-rot, rot));
  rotateZ(random(-rot, rot));

  float x = 0;
  float y = 0;
  float size = width*1.8;

  int sub = 300/2;
  int div = 80;

  lights();

  noStroke();
  //stroke(0, 240);

  for (int j = 0; j < sub; j++) {
    float r1 = map(j, 0, sub, 0, size)+0.2;
    float r2 = map(j+1, 0, sub, 0, size)-0.2;
    float v = pow(map(j, 0, sub, 0, 1), 2);
    float v2 = 0.8+v*0.2;
    float ss = 260;
    for (int i = 0; i < div; i++) {
      float a1 = map(i, 0, div, 0, TAU);
      float a2 = map(i+1, 0, div, 0, TAU);
      float hh = random(v*ss*v2, ss*v2)*random(1)*random(random(0.6, 2))*0.35;//*random(1);
      int col = rcol();
      int shw = lerpColor(col, color(0), 0.1);

      //col = color(255);
      //shw = color(200);

      float ca = (a1+a2)*0.5;
      float rr = (r1+r2);

      float cx = cos(ca*0.5)*rr*0.5;
      float cy = sin(ca*0.5)*rr*0.5;

      beginShape(QUAD);
      int cc = 10;
      for (int k = 0; k < cc; k++) {
        float mh1 = map(k, 0, cc, 0, hh);
        float mh2 = map(k+0.1, 0, cc, 0, hh);
        pushMatrix();
        translate(cx, cy, hh);
        //rotate(ca+HALF_PI);
        //box(1, 4, 1);
        popMatrix();
        /*
        vertex(x+cos(a1)*r1, y+sin(a1)*r1, mh2);
         vertex(x+cos(a2)*r1, y+sin(a2)*r1, mh2);
         fill(shw);
         vertex(x+cos(a2)*r1, y+sin(a2)*r1, mh1);
         vertex(x+cos(a1)*r1, y+sin(a1)*r1, mh1);
         
         
         fill(col);
         vertex(x+cos(a2)*r1, y+sin(a2)*r1, mh2);
         vertex(x+cos(a2)*r2, y+sin(a2)*r2, mh2);
         fill(shw);
         vertex(x+cos(a2)*r2, y+sin(a2)*r2, mh1);
         vertex(x+cos(a2)*r1, y+sin(a2)*r1, mh1);
         
         
         fill(col);
         vertex(x+cos(a2)*r2, y+sin(a2)*r2, mh2);
         vertex(x+cos(a1)*r2, y+sin(a1)*r2, mh2);
         fill(shw);
         vertex(x+cos(a1)*r2, y+sin(a1)*r2, mh1);
         vertex(x+cos(a2)*r2, y+sin(a2)*r2, mh1);
         
         
         fill(col);
         vertex(x+cos(a1)*r2, y+sin(a1)*r2, mh2);
         vertex(x+cos(a1)*r1, y+sin(a1)*r1, mh2);
         fill(shw);
         vertex(x+cos(a1)*r1, y+sin(a1)*r1, mh1);
         vertex(x+cos(a1)*r2, y+sin(a1)*r2, mh1);
         */
      }
      endShape();

      col = rcol();

      float ar1 = r1+2;
      float ar2 = r2+2;


      beginShape(QUAD);

      fill(col);
      vertex(x+cos(a1)*ar1, y+sin(a1)*ar1, hh);
      vertex(x+cos(a2)*ar1, y+sin(a2)*ar1, hh);
      //fill(rcol(), 0);
      vertex(x+cos(a2)*ar2, y+sin(a2)*ar2, hh);
      vertex(x+cos(a1)*ar2, y+sin(a1)*ar2, hh);




      fill(col);
      vertex(x+cos(a1)*ar1, y+sin(a1)*ar1, hh);
      vertex(x+cos(a2)*ar1, y+sin(a2)*ar1, hh);
      fill(shw);
      vertex(x+cos(a2)*ar1, y+sin(a2)*ar1, 0);
      vertex(x+cos(a1)*ar1, y+sin(a1)*ar1, 0);


      fill(col);
      vertex(x+cos(a2)*ar1, y+sin(a2)*ar1, hh);
      vertex(x+cos(a2)*ar2, y+sin(a2)*ar2, hh);
      fill(shw);
      vertex(x+cos(a2)*ar1, y+sin(a2)*ar1, 0);
      vertex(x+cos(a2)*ar2, y+sin(a2)*ar2, 0);

      fill(col);
      vertex(x+cos(a2)*ar2, y+sin(a2)*ar2, hh);
      vertex(x+cos(a1)*ar2, y+sin(a1)*ar2, hh);
      fill(shw);
      vertex(x+cos(a1)*ar2, y+sin(a1)*ar2, 0);
      vertex(x+cos(a2)*ar2, y+sin(a2)*ar2, 0);


      fill(col);
      vertex(x+cos(a1)*ar2, y+sin(a1)*ar2, hh);
      vertex(x+cos(a1)*ar1, y+sin(a1)*ar1, hh);
      fill(shw);
      vertex(x+cos(a1)*ar1, y+sin(a1)*ar1, 0);
      vertex(x+cos(a1)*ar2, y+sin(a1)*ar2, 0);

      endShape();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#E0DBD5, #F0C729, #E33526, #5557A0, #2C2B27};
//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
//int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
