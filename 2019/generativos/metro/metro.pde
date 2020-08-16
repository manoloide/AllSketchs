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
  size(int(swidth*scale), int(sheight*scale));
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

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(250);

  //background(rcol());
  rectMode(CENTER);

  hint(DISABLE_DEPTH_TEST);

  blendMode(DARKEST);

  int cc = 80;
  float ss = width*1./cc;

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 280; i++) {
    float s = ss*int(pow(2, int(random(6)*random(0.5, 1))));
    float xx = random(s, width-s);
    float yy = random(s, height-s);

    xx -= xx%(ss*4);
    yy -= yy%(ss*4);

    xx += ss*0.5;
    yy += ss*0.5;
    points.add(new PVector(xx, yy, s));
  }

  int angDiv = 8;//int(random(3, 16));//8;//int(random(3, 25));
  println("angDiv", angDiv);

  ArrayList<PVector> spots = new ArrayList<PVector>();
  ArrayList<PVector> pps = new ArrayList<PVector>();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float da = TAU/angDiv;
    int dir = int(random(angDiv));

    float det = random(0.006, 0.008)*0.6;
    float des = random(1000);
    int col = rcol();
    float alp = random(190, 280)*random(0.5, 1);
    float xx = p.x; 
    float yy = p.y;

    if (random(1) < 0.3) {
      dir  += int(random(2))*2-1;
    }

    strokeWeight(random(0.6, 1.6));
    for (int j = 0; j < 320; j++) {
      float ax = xx;
      float ay = yy;
      float noi = pow(noise(des+xx*det, des+yy*det), 0.8);
      //if (noi < 0.5) break;
      float amp = int(1+noi*4);//int(random(1, 4))*
      if (random(1) < 0.2) {
        float ang = da*dir;
        xx += cos(ang)*ss*amp;
        yy += sin(ang)*ss*amp;
      } else {
        float ang = da*dir;
        xx += cos(ang)*ss*amp;
        yy += sin(ang)*ss*amp;
        if (random(1) < 0.5) {
          xx += cos(ang+da)*ss*amp;
          yy += sin(ang+da)*ss*amp;
        } else {
          xx += cos(ang-da)*ss*amp;
          yy += sin(ang-da)*ss*amp;
        }
      }

      stroke(col, alp);
      line(xx, yy, ax, ay);


      float cx = (ax+xx)*0.5;
      float cy = (ay+yy)*0.5;
      noStroke();
      fill(rcol());
      float sss = ss*random(0.18, 0.25);
      ellipse(cx, cy, sss, sss);

      if (random(1) < 0.02) {
        spots.add(new PVector(cx, cy, ss));
      }

      if (random(1) < 0.02) {
        //fill(rcol(), random(40));
        //ellipse(cx, cy, ss*12*noi, ss*12*noi);
        pps.add(new PVector(cx, cy, ss*noi*random(0.5, 1)));
      }
    }
  }

  strokeWeight(1);

  for (int i = 0; i < pps.size(); i++) {
    //if (random(1) > 0.004) continue;
    PVector p = pps.get(i);
    
    

    int sub = int(random(1, 5));
    fill(rcol(), random(200, 250)*random(1));
    ellipse(p.x, p.y, p.z*1*sub, p.z*1*sub);
    ellipse(p.x, p.y, p.z*2*sub, p.z*2*sub);

    noStroke();
    fill(rcol(), random(20));
    //stroke(0, 20);
    //ellipse(p.x, p.y, p.z*24, p.z*24);
    //ellipse(p.x, p.y, p.z*4, p.z*4);
    noStroke();
  }

  ArrayList triangles = Triangulate.triangulate(spots);

  float maxAlp = 80;
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.6) continue;
    Triangle t = (Triangle) triangles.get(i);
    int col = rcol();
    stroke(col, 20);
    fill(col, random(maxAlp));
    vertex(t.p1.x, t.p1.y);
    fill(col, random(maxAlp));
    vertex(t.p2.x, t.p2.y);
    fill(col, random(maxAlp));
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);

  for (int i = 0; i < spots.size(); i++) {
    if (random(1) > 0.1) continue;
    PVector spt = spots.get(i);
    
    
    int sub = int(random(1, 5));
    
    stroke(rcol());
    noFill();
    fill(rcol(), random(10)*random(1));
    ellipse(spt.x, spt.y, spt.z*2.5*sub, spt.z*2.5*sub);

    noStroke();
    fill(rcol(), random(40)*random(1)*random(1));
    ellipse(spt.x, spt.y, spt.z*5*sub, spt.z*5*sub);
  }
}  


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#E9C500, #DB92AE, #E44509, #42A1C1, #37377A, #D87291, #D65269, #000000};
//int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
int colors[] = {#EA449F, #EFACDB, #F2C05C, #D62C06, #214CA2};

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
