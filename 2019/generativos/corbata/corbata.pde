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
  size(int(swidth*scale), int(sheight*scale), P2D);
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

  background(rcol());

  int cc = int(random(40, 90)*0.09);
  float size = width*0.5;
  float ss = size*0.9/cc;

  translate(width*0.5, height*0.5);
  rotate(HALF_PI*0.5);

  scale(random(0.9, 1.2));

  int div = 2;

  stroke(0, 40);
  noStroke();
  rectMode(CENTER);
  strokeCap(SQUARE);
  strokeWeight(0.8);
  boolean hor = random(1) < 0.7;
  boolean ver = random(1) < 0.7;
  for (int l = 0; l <= div; l++) {
    for (int k = 0; k <= div; k++) {
      randomSeed(seed);
      pushMatrix();
      translate((k-div*0.5)*size, (l-div*0.5)*size);

      rectSub(0, 0, size, size, int(random(10, 18))*2, rcol(), rcol());
      fill(255);
      rect(0, 0, ss*cc, ss*cc);
      float ms = ss*0.5;
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          float xx = ss*(i-cc*0.5+0.5);
          float yy = ss*(j-cc*0.5+0.5);

          //if(random(1) < 0.2) continue;
          float bb = 0.48;
          float mb = ss*bb;
          beginShape();
          fill(0, 20);
          vertex(xx-mb, yy-mb);
          fill(0, 0);
          vertex(xx+mb, yy-mb);
          vertex(xx-mb, yy+mb);
          endShape();

          beginShape();
          fill(0, 20);
          vertex(xx-mb, yy-mb);
          fill(0, 0);
          vertex(xx+mb, yy-mb);
          vertex(xx+mb, yy+mb);
          endShape();

          beginShape();
          fill(255, 80);
          vertex(xx+mb, yy+mb);
          fill(255, 0);
          vertex(xx+mb, yy-mb);
          vertex(xx-mb, yy+mb);
          endShape();

          if (random(1) < 0.2) {
            fill(rcol());
            ellipse(xx, yy, ss*0.8, ss*0.8);
          }

          if ((hor && i%2 == 0) || (ver && j%2 == 0)) {
            stroke(rcol());
            if (hor && random(1) < 0.5) line(xx, yy-ms, xx, yy+ms);
            if (ver && random(1) < 0.5) line(xx-ms, yy, xx+ms, yy);

            noStroke();
            fill(0, 14);
            float sss = random(1);
            float dd = sss*ss*0.08;
            ellipse(xx+dd, yy+dd, ss*(0.1+sss*0.1), ss*(0.1+sss*0.1));
            //ellipse(xx+dd, yy+dd, ss*(0.1+sss*0.1)*0.1, ss*(0.1+sss*0.1)*0.1);

            fill(rcol());
            ellipse(xx, yy, ss*0.1, ss*0.1);
          } else {//if (true) {
            //if (i%2 == 0) xx *= -1;
            //if (j%2 == i%2) yy *= -1;
            fill(rcol());
            rect(xx, yy, ss, ss);
            float sss = ss*random(0.3, 0.5)*0.8;

            float dd = random(1)*sss*0.6;

            noStroke();
            fill(0, 20);
            rect(xx+dd, yy+dd, sss, sss);
            fill(rcol());
            rect(xx, yy, sss, sss);
            fill(rcol());
            rect(xx, yy, sss*0.1, sss*0.1);


            beginShape();
            fill(255, 80);
            vertex(xx+ss*0.5, yy+ss*0.5);
            fill(255, 0);
            vertex(xx+ss*0.5, yy-ss*0.5);
            vertex(xx-ss*0.5, yy+ss*0.5);
            endShape();
            /*
            */
          }
        }
      }
      popMatrix();
    }
  }
}

void rectSub(float x, float y, float w, float h, int sub, int c1, int c2) {
  float mw = w*0.5;
  float mh = h*0.5;
  for (int i = 0; i < sub; i++) {
    float v1 = map(i, 0, sub, -mw, mw);
    float v2 = map(i+1, 0, sub, -mw, mw);
    beginShape(TRIANGLES);
    fill((i%2 == 0)? c1 : c2);
    vertex(x+v1, y-mh);
    vertex(x+v2, y-mh);
    fill(0, 0);
    vertex(x, y);

    fill((i%2 == 0)? c1 : c2);
    vertex(x+mw, y+v1);
    vertex(x+mw, y+v2);
    fill(0, 0);
    vertex(x, y);


    fill((i%2 == 0)? c1 : c2);
    vertex(x-v1, y+mh);
    vertex(x-v2, y+mh);
    fill(0, 0);
    vertex(x, y);
    endShape();

    fill((i%2 == 0)? c1 : c2);
    vertex(x-mw, y-v1);
    vertex(x-mw, y-v2);
    fill(0, 0);
    vertex(x, y);
    endShape();
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
int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
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
