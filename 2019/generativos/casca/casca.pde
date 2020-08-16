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

  int back = rcol();
  background(back);


  int cc = 66;//int(random(40, 110));
  float ss = width*1./cc;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(ss, ss, width-ss*2, height-ss*2));
  int sub = int(random(190));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float mw = r.w*0.5;
    float mh = r.h*0.5;
    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
    rects.add(new Rect(r.x, r.y+mh, mw, mh));
    rects.remove(ind);
  }

  stroke(0, 180);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h);
    float d = min(r.w, r.h)*random(1);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, d, d);
    fill(rcol());
    rect(r.x, r.y, r.w*0.2, r.h*0.2);
    fill(rcol());
    rect(r.x+r.w*0.08, r.y+r.h*0.08, r.w*0.04, r.h*0.04);
  }

  noFill();
  for (float j = 1; j < cc; j++) {
    for (float i = 1; i < cc; i++) {
      stroke(0, 10);
      fill(255, random(4));
      rect(i*ss, j*ss, ss, ss);
      float ns = ss*random(1)*random(0.4, 1);
      if (random(1) < 0.4) {
        fill(rcol());
        ellipse(i*ss, j*ss, ns, ns);
        fill(rcol());
        ellipse(i*ss, j*ss, ns*0.5, ns*0.5);
      }
      if (random(1) < 0.1) {
        stroke(0, random(10));
        fill(255, random(8));
        rect(i*ss, j*ss, ss, ss);
      }
      /*
      if (random(1) < 0.02) {
       fill(0, 60);
       rect(i*ss, j*ss, ss, ss);
       }
       */
    }
  }


  translate(width*0.5, height*0.5);


  float desCol = random(1000);
  float detCol = random(0.01);

  float des = random(1000);
  float det = random(0.0006, 0.001);

  for (int k = 0; k < 5; k++) {
    for (int i = 0; i < (34000/5)/(1+k*0.8); i++) {
      float x = width*random(-0.55, 0.55);
      float y = height*random(-0.55, 0.55);

      float aa = random(TAU);
      float dd = pow(map(k, 0, 5, 0.1, 0.75), 0.6)*1.4;//*sqrt(random(1));

      x = width*cos(aa)*0.5*dd;
      y = height*sin(aa)*0.5*dd;


      float lar = random(20, random(100, 400))*random(1)*0.4;
      beginShape();
      noFill();
      stroke(getColor(noise(desCol+x*detCol, desCol+y*detCol)*8+random(1)));
      strokeWeight(random(0.8, 1.7));
      for (int j = 0; j < lar; j++) {
        float ang = noise(des+x*det, des+y*det)*TAU*2;
        vertex(x, y);
        x += cos(ang);
        y += sin(ang);
      }
      endShape();
      float s = noise(des+x*det, des+y*det)*random(160)*random(1);
      noStroke();
      int c1 = getColor(noise(desCol+x*detCol, desCol+y*detCol)*8+random(1)+2);
      fill(c1, 60);
      ellipse(x, y, s, s);    
      fill(c1);
      ellipse(x, y, s*0.4, s*0.4);
      float dc = random(colors.length);
      int c = int(random(4, 60)*2);
      c = 0;
      for (int l = 0; l < c; l++) {
        float ang = random(TAU); 
        float dis = s*sqrt(random(1))*0.5;
        float sss = random(2)*random(1);
        float xx = x+cos(ang)*dis;
        float yy = y+sin(ang)*dis;
        int col = getColor(dc+random(0.2));
        stroke(col, random(120));
        //line(x, y, xx, yy);
        noStroke();
        fill(rcol(), random(255));
        ellipse(xx, yy, sss, sss);
      }
    }
  }

  translate(-width*0.5, -height*0.5);
  strokeWeight(1);

  stroke(0, 180);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float cx = r.x+r.w*0.5;
    float cy = r.y+r.h*0.5;
    float dc = random(colors.length);
    int c = int(PI*min(r.w, r.h)*0.1);
    float ac = random(0.1, 2);
    for (int l = 0; l < c; l++) {
      float a1 = random(TAU); 
      float a2 = random(PI); 
      float dis = min(r.w, r.h)*0.5;//*sqrt(random(1));
      float sss = random(2)*random(1);
      float x1 = cx+cos(a1)*cos(a2)*dis*0.9;
      float y1 = cy+sin(a1)*cos(a2)*dis*0.9;
      float x2 = cx+cos(a1)*cos(a2)*dis*0.85;
      float y2 = cy+sin(a1)*cos(a2)*dis*0.85;
      int col = getColor(dc+random(ac));
      stroke(col, random(255));
      line(x1, y1, x2, y2);
      //noStroke();
      //fill(rcol(), random(255));
      //ellipse(xx, yy, sss, sss);
    }
    noStroke();
    fill(rcol());
    ellipse(cx, cy, r.w*0.1, r.h*0.1);
    fill(rcol());
    ellipse(cx, cy, r.w*0.01, r.h*0.01);
  }
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

//int colors[] = {#001077, #FA1359, #EA6395, #E8E7E9, #DDBD00, #007F4B};
//int colors[] = {#0F2442, #0168AD, #8AC339, #E65B61, #EDA787};
//int colors[] = {#EFE5D1, #F09BC4, #F54034, #1F43B1, #02ADDC};
//int colors[] = {#EA449F, #EFACDB, #F2D091, #BF052A, #214CA2};
int colors[] = {#CE44EA, #EFACDB, #EFF246, #D60686, #214CA2};
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
