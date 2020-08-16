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

  float size = width*0.2;
  int cc = int(random(60, 90)*0.15);
  float ss = size/cc;

  translate(width*0.5, height*0.5);
  rotateZ(HALF_PI*0.5);

  int div = 8;

  stroke(0, 40);
  noStroke();
  rectMode(CENTER);
  for (int l = 0; l < div; l++) {
    for (int k = 0; k < div; k++) {
      randomSeed(seed);
      pushMatrix();
      translate((k-div*0.5)*size, (l-div*0.5)*size);
      fill(rcol());
      ellipse(0, 0, size*0.9, size*0.9);
      fill(rcol());
      ellipse(0, 0, size*0.8, size*0.8);
      fill(rcol());
      ellipse(0, 0, size*0.4, size*0.4);



      fill(rcol());
      ellipse(size*0.5, size*0.5, size*0.2, size*0.2);
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          if(random(1) < 0.1) continue;
          float xx = ss*(i-cc*0.5);
          float yy = ss*(j-cc*0.5);
          if (i%2 == 0) xx *= -1;
          if (j%2 == i%2) yy *= -1;
          fill(rcol());
          rect(xx, yy, ss, ss);
          fill(rcol());
          rect(xx, yy, ss*0.5, ss*0.5);
        }
      }

      for (int i = 0; i < 20; i++) {
        float xx = ss*(int(random(cc))-cc*0.5);
        float yy = ss*(int(random(cc))-cc*0.5);
        fill(0);
        rect(xx, yy, ss, ss);
      }
      popMatrix();
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
