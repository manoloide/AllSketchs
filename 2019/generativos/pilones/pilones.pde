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

  background(rcol());
  noStroke();

  ArrayList<PVector> points = new ArrayList<PVector>();

  float s = 20;

  rectMode(CENTER);
  
  
  for (int i = 0; i < 200; i++) {
    float x = random(width+s);
    float y = random(height+s);
    x -= x%s;
    y -= y%s;
    stroke(rcol());
    noFill();
    rect(x, y, 120, 120);
  }

  for (float j = 0; j < width+s; j+=s) {
    for (float i = 0; i < width+s; i+=s) {
      float x = i-s*0.5;
      float y = j-s*0.5;
      if (random(1) < 0.1) {
        fill(rcol());
        rect(x, y, 20, 20);
      }
    }
  }

  for (float j = 0; j < width+s; j+=s) {
    for (float i = 0; i < width+s; i+=s) {
      fill(rcol());
      if (random(1) < 0.8) rect(i, j, 2, 2);
      if (random(1) < 0.1) {
        fill(rcol());
        rect(i, j, 10, 10);
        fill(rcol());
        rect(i, j, 4, 4);
      }
    }
  }

  for (int i = 0; i < 200; i++) {
    float x = random(width+s);
    float y = random(height+s);
    x -= x%s;
    y -= y%s;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < 2) {
        add = false;
        break;
      }
    }

    if (add) points.add(new PVector(x, y));
  }

  ArrayList triangles = Triangulate.triangulate(points);

  for (int i = 0; i < triangles.size(); i++) {

    if (random(1) < 0.4) continue;
    Triangle t = (Triangle)triangles.get(i);
     
    stroke((random(1) < 0.5)? 0 : 255);
    int col = rcol();
    beginShape(TRIANGLES);
    fill(col);
    vertex(t.p1.x, t.p1.y);
    fill(col, random(180, 255));
    vertex(t.p2.x, t.p2.y);
    fill(col, random(180, 255));
    vertex(t.p3.x, t.p3.y);
    endShape();
  }
  
  noStroke();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, s*0.3, s*0.3);
    fill(int(random(2))*255);
    ellipse(p.x, p.y, s*0.1, s*0.1);
  }

  s = 80;
  for (int i = 0; i < 80; i++) {
    float x = random(width+s);
    float y = random(height+s);
    x -= x%s;
    y -= y%s;
    float ss = s;
    fill(rcol());
    ellipse(x, y, ss-8, ss-8);
    arc2(x, y, ss*0.5-8, ss*2, 0, TAU, color(0), 30, 0);
    arc2(x, y, ss*0.5-8, ss*0.52, 0, TAU, color(0), 50, 0);
    boolean inv = random(1) < 0.5;
    fill((inv)? 0 : 255);
    ellipse(x, y, ss*0.5-8, ss*0.5-8);
    
    fill((inv)? 255 : 0);
    noStroke();
    if (random(1) < 0.8) {
      float rot = HALF_PI*int(random(2));
      float ang = random(random(PI*0.5), random(PI*0.5, PI));
      arc(x, y, ss*0.5-8, ss*0.5-8, PI*1.5-ang+rot, PI*1.5+ang+rot, 2);
    } else {
      float sss = random(ss*0.5-3)*random(0.2, 0.8);
      fill(rcol());
      //ellipse(x, y, sss, sss);
      sss = random(ss*0.5-3)*random(0.2, 0.9);
      fill((inv)? 255 : 0);
      ellipse(x, y, sss, sss);
    }
  }

  s = 40;
  for (int i = 0; i < 80; i++) {
    float x = random(width+s);
    float y = random(height+s);
    x -= x%s;
    y -= y%s;
    fill(rcol());
    ellipse(x, y, s-8, s-8);
    fill(int(random(2))*255);
    ellipse(x, y, s*0.4, s*0.4);
    arc2(x, y, s-8, s*2, 0, TAU, color(0), 20, 0);


    if (random(1) < 0.1 ) {
      arc2(x, y, s*6, s*5, 0, TAU, color(rcol()), 255, 0);
      arc2(x, y, s*6, s*12, 0, TAU, color(0), 20, 0);
      arc2(x, y, s*6, s*8, 0, TAU, color(0), 20, 0);
    }
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

//int colors[] = {#F7AA06, #35B1CA, #DA4974, #B9100F, #214CA2};
int colors[] = {#FBFF38, #889DD8, #FFD8EB, #F41D3A, #164BB7, #ffffff, #000000};
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
