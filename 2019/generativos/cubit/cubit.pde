import org.processing.wiki.triangulate.*;

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

  background(0);

  int cc = 20;
  float ss = width*1./cc;

  noStroke();
  /*
  rectMode(CENTER);
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   
   if (random(3) < 1) {
   if (random(1) < 0.5) fill(255, 0, 0);
   else fill(255, 255, 0);
   } else {
   fill(0, 0, 255);
   }
   rect((i+0.5)*ss, (j+0.5)*ss, 2, 2);
   }
   }
   */

  noFill();
  for (int i = 0; i < 50; i++) {
    float x = int(random(2, cc-2))*ss+ss*0.5;
    float y = int(random(2, cc-2))*ss+ss*0.5; 

    float dx = (random(1) < 0.5)? -ss : ss;
    float dy = (random(1) < 0.5)? -ss : ss;

    int face = int(random(6));

    if (random(3) < 2) {
      if (random(1) < 0.5) stroke(255, 0, 0);
      else stroke(255, 255, 0);
    } else {
      stroke(0, 0, 255);
    }

    float sss = ss;
    if (random(8) < 1) {
      if (random(1) < 0.5) sss = ss*0.5; 
      else sss = ss*0.25;
    }

    strokeWeight(1.4);
    box(x, y, sss, dx, dy, face);
  }
}

void box(float x, float y, float ss, float dx, float dy, int face) {
  float ms = ss;

  if (face == 0 || face == 2) setNormal();
  else setBold();
  line(x-ms, y-ms, x+ms, y-ms);  
  if (face == 0 || face == 3) setNormal();
  else setBold();
  line(x-ms, y+ms, x+ms, y+ms);
  if (face == 0 || face == 4) setNormal();
  else setBold();
  line(x-ms, y-ms, x-ms, y+ms);
  if (face == 0 || face == 5) setNormal();
  else setBold();
  line(x+ms, y+ms, x+ms, y-ms);



  if (face == 2 || face == 5) setNormal();
  else setBold();
  line(x+ms+dx, y-ms+dy, x+ms, y-ms);  
  if (face == 3 || face == 5) setNormal();
  else setBold();
  line(x+ms+dx, y+ms+dy, x+ms, y+ms);  
  if (face == 3 || face == 4) setNormal();
  else setBold();
  line(x-ms+dx, y+ms+dy, x-ms, y+ms);  
  if (face == 2 || face == 4) setNormal();
  else setBold();
  line(x-ms+dx, y-ms+dy, x-ms, y-ms);


  if (face == 1  || face == 2) setNormal();
  else setBold();
  line(x-ms+dx, y-ms+dy, x+ms+dx, y-ms+dy);
  if (face == 1 || face == 3) setNormal();
  else setBold();
  line(x-ms+dx, y+ms+dy, x+ms+dx, y+ms+dy);
  if (face == 1 || face == 4) setNormal();
  else setBold();
  line(x-ms+dx, y-ms+dy, x-ms+dx, y+ms+dy);
  if (face == 1 || face == 5) setNormal();
  else setBold();
  line(x+ms+dx, y+ms+dy, x+ms+dx, y-ms+dy);
}

void setNormal() {
  int col = g.strokeColor;
  stroke(red(col), green(col), blue(col), 250);
}

void setBold() {
  int col = g.strokeColor;
  stroke(red(col), green(col), blue(col), 90);
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(4, PI*pow(max(s1, s2)*0.1, 1)*3);

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

int colors[] = {#7E5C25, #B8BA89, #EBE5BB, #ECDD6A, #E58F28, #E72E05};
//int colors[] = {#80D2F0, #D4F5F4, #472176, #030234, #F7CE5B };
//int colors[] = {#F7AA06, #35B1CA, #DA4974, #B9100F, #214CA2};
//int colors[] = {#FBFF38, #889DD8, #FFD8EB, #F41D3A, #164BB7, #ffffff, #000000};
//int colors[] = {#E255EB, #2A6DD1, #E255EB, #F5C203};
//int colors[] = {#0F2442, #0168AD, #8AC339, #E65B61, #EDA787};
//int colors[] = {#EFE5D1, #F09BC4, #F54034, #1F43B1, #02ADDC};
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
