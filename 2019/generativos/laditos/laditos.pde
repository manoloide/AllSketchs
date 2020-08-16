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

  scale(scale);

  background(240);
  noStroke();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(10, 30)*0.8);
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    if (r.w < 4) continue;

    float div = random(0.25, 0.75);
    float w1 = r.w*div;
    float w2 = r.w*(1-div);

    rects.add(new Rect(r.x, r.y, w1, r.h));
    rects.add(new Rect(r.x+w1, r.y, w2, r.h)); 

    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);

    float alp1 = random(50);
    float alp2 = 0;
    if (i%2 == 0) {
      alp2 = alp1;
      alp1 = 0;
    }

    beginShape();
    fill(0, alp1);
    vertex(r.x, r.y);
    vertex(r.x, r.y+r.h);
    fill(0, alp2);
    vertex(r.x+r.w, r.y+r.h);
    vertex(r.x+r.w, r.y);
    endShape();


    int div = int(random(5, 20));
    float dd = r.w*random(0.2, 0.3);
    float cc = height/r.w+2;

    float dy = dd*random(0.2)*3*random(0.6, 1);
    if (i%2 == 0) dy *= -1;

    for (float j = random(-2, -1); j < cc; j++) {

      if (random(1) < 0.2) continue;
      beginShape();
      fill(rcol());
      vertex(r.x+dd, r.y+r.w*j+dd*0.5+dy);
      vertex(r.x+r.w-dd, r.y+r.w*j+dd*0.5-dy);
      if (random(1) < 0.2) fill(rcol());
      vertex(r.x+r.w-dd, r.y+r.w*(j+1)-dd*0.5-dy);
      vertex(r.x+dd, r.y+r.w*(j+1)-dd*0.5+dy);
      endShape();

      //stroke(255);
      //line(r.x+r.w, r.y+r.w*(j+1)-dy, r.x, r.y+r.w*(j+1)+dy);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#320399, #E07AFF, #EA1026, #FFD70F};// #E5E5E5};
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
