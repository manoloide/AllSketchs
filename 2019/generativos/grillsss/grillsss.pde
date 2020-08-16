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

  int cc = int(random(40, 120)*0.5);
  float dd = width*1./(cc+2);

  fill(rcol());
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = dd*(i+1.5);
      float yy = dd*(j+1.5);
      float ss = dd*0.12*2;
      if (random(1) < 0.5) continue;
      if (random(1) < 0.08) ss *= 4;
      ellipse(xx, yy, ss, ss);
    }
  }

  stroke(rcol());
  for (int i = 0; i < cc; i++) {
    float x1 = dd*(int(random(cc))+1.5);
    float y1 = dd*(int(random(cc))+1.5);
    float x2 = dd*(int(random(cc))+1.5);
    float y2 = dd*(int(random(cc))+1.5);
    if (random(1) < 0.4) x1 = x2;
    else y1 = y2;
    line(x1, y1, x2, y2);
  }

  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = dd*(i+1.5);
      float yy = dd*(j+1.5);
      float ss = dd*0.12;

      if (random(1) < random(0.03)) continue;

      noStroke();
      fill(0);
      if (random(1) < 0.08) ss *= 4;
      ellipse(xx, yy, ss, ss);

      if (random(1) < 0.016) {

        ellipse(xx+0.5, yy+0.5, ss*10, ss*10);
        fill(250);
        ellipse(xx, yy, ss, ss);
      }

      if (random(1) < 0.01) {
        fill(0, 10);
        ellipse(xx, yy, ss*20, ss*20);
      }

      if (random(1) < 0.08) {
        fill(0, 20);
        ellipse(xx, yy, ss*2, ss*2);
      }

      if (random(1) < 0.01) {
        noFill();
        stroke(0, 80);
        fill(rcol());
        float sss = dd*int(random(2, 10));
        noStroke();//
        rect(xx-0.5, yy-0.5, sss, sss);
      }

      if (random(1) < 0.01) {
        noFill();
        stroke(0, 80);
        float sss = dd*int(random(2, 10));
        ellipse(xx-0.5, yy-0.5, sss, sss);
      }
    }
  }  
  float bb = random(20, 50);


  noStroke();

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 90; i++) {
    float ss = int(random(10, random(20, 50)))*10;
    float xx = random(bb+ss*0.5, width-bb-ss*0.5);
    float yy = random(bb+ss*0.5, height-bb-ss*0.5);
    xx -= xx%10;
    yy -= yy%10;
    int col = rcol();
    fill(col, random(40, 50));
    //ellipse(xx, yy, ss, ss);
    fill(col, 250);
    if (random(1) < 0.2) ellipse(xx, yy, ss*0.5, ss*0.5);
    fill(255, 180);
    ellipse(xx, yy, ss*0.11, ss*0.11);
    fill(rcol());
    ellipse(xx, yy, ss*0.1, ss*0.1);
    fill(rcol());
    ellipse(xx, yy, ss*0.02, ss*0.02);

    points.add(new PVector(xx, yy));
  }

  for (int i = 0; i < 20; i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size())));
    noFill();
    stroke(rcol());
    lineNoise(p1.x, p1.y, p2.x, p2.y);
  }
}

void lineNoise(float x1, float y1, float x2, float y2) {
  ArrayList<PVector> points = new ArrayList<PVector>();

  int lar = int(dist(x1, y1, x2, y2));
  float newAng = atan2(y2-y1, x2-x1);

  float ix = 0;
  float iy = 0;
  float det = random(0.01);
  float des = random(1000);
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar; k++) {
    float ang = ((float)SimplexNoise.noise(des+ix*det, des+iy*det)*2-1)*PI*3.8;
    ix += cos(ang);
    iy += sin(ang);
    points.add(new PVector(ix, iy));
  }

  PVector p1 = points.get(0);
  PVector p2 = points.get(points.size()-1);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float dis = p1.dist(p2);

  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    p.rotate(-ang+newAng);
    p.mult((lar*1./dis));
  }

  strokeWeight(random(1, random(1, 6)));
  beginShape(LINES);
  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    vertex(x1+p.x, y1+p.y);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F4F751, #000000, #FAFAFA};
int colors[] = {#97B7D8, #121872, #FFD454, #F7E6EB, #E52B06};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
