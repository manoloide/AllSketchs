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

  blendMode(ADD);


  float fov = PI/8.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  rotateX(random(-0.2, 0.2));
  rotateY(random(-0.2, 0.2));
  rotateZ(random(-0.4, 0.4));

  for (int k = 0; k < 160; k++) {
    pushMatrix();
    float ww = 20/pow(2, int(random(1, 7)));
    float hh = 30/pow(2, int(random(1, 7)));
    stroke(0, 70);
    translate(random(width), random(height));
    int main = rcol();
    beginShape(QUADS);
    float vo = random(0.04);
    float amp = random(30, 50)*0.6;
    for (int j = 0; j < 20; j++) {
      float alp = random(200, 240)*0.6;
      fill((random(1) < 0.5)? main : rcol(), alp);
      if (random(1) < 0.5) fill(rcol(), alp);
      float xx, yy, zz;
      for (int i = 0; i < 30; i++) {
        xx = i*ww;
        yy = j*hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww+ww;
        yy = j*hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww+ww;
        yy = j*hh+hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww;
        yy = j*hh+hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);

        xx = i*ww;
        yy = j*hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww+ww;
        yy = j*hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww+ww;
        yy = j*hh+hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
        xx = i*ww;
        yy = j*hh+hh;
        zz = cos(xx*vo)*amp;
        vertex(xx, yy, zz);
      }
    }
    endShape(CLOSE);
    popMatrix();
  }
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    endShape();
  }
}

int colors[] = {#F33F3E, #0155AD, #277143, #F33F3E, #0155AD, #277143, #F33F3E, #0155AD, #277143, #F1F5F4, #F1F5F4};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length), 1);
}
int getColor(float v, float p) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, p));
}
