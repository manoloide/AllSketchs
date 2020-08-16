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

  background(3);

  {

    float x = width*0.5;
    float y = height*0.5;
    float s = width*1.41;
    boolean inv = true;
    float mul = random(0.95, 0.97)+0.025;
    noStroke();
    while (s > 1) {
      if (inv) fill(0);
      else fill(255);
      ellipse(x, y, s, s);
      inv = !inv;
      s *= mul;
    }
  }

  for (int i = 0; i < 20; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    x -= x%120;
    y -= y%60;
    float s = width*random(0.2, 0.4);
    boolean inv = true;
    float mul = random(0.91, 0.97);
    noStroke();
    while (s > 1) {
      if (inv) fill(0);
      else fill(255);
      ellipse(x, y, s, s);
      inv = !inv;
      s *= mul;
    }
  }


  for (int i = 0; i < 120; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    float s = random(1, 2)*random(0.5, 1);
    if (random(1) < 0.5) fill(0);
    else fill(255);
    ellipse(x, y, s, s);
  }

  for (int i = 0; i < 30; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    //x -= x%120;
    //y -= y%60;
    float s = width*random(0.2, 0.4)*0.25;
    boolean inv = true;
    float mul = random(0.91, 0.97);
    noStroke();
    while (s > 1) {
      if (inv) fill(0);
      else fill(255);
      ellipse(x, y, s, s);
      inv = !inv;
      s *= mul;
    }
  }


  for (int i = 0; i < 20; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    x -= x%120;
    y -= y%60;

    x += 60;
    y += 30;
    
    int col = 240*int(random(2));

    rectMode(CENTER);
    noStroke();
    fill(col, 80);
    rect(x, y, 30+4, 15+4);
    fill(col);
    rect(x, y, 30, 15);
  }

  rectMode(CORNER);
  for (int i = 0; i < 20; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    x -= x%120;
    y -= y%60;

    noStroke();
    fill((random(1) < 0.5)? 240 : 0);
    int cc = 20;
    float ss = 120/cc;
    for (int j = 0; j < cc; j++) {
      rect(x+ss*j, y, ss*0.8, 60);
    }
  }

  strokeWeight(2);
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    float d = random(70, 100)*0.9;
    float a1 = random(TAU);
    float a2 = a1+random(3, 7)*TAU;
    stroke(255*int(random(2)));
    lineSine(x, y, a1, x+d, y, a2, 2);
  }


  ArrayList<PVector> points = new ArrayList<PVector>();
  float minDis = random(2, 12);
  for (int i = 0; i < 28; i++) {
    float x = random(0, width+120);
    float y = random(0, height+120);
    x -= x%120;
    y -= y%60;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < minDis) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y));
  }


  ArrayList triangles = Triangulate.triangulate(points);
  stroke(240, 20);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(random(255), random(40*0.4));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  float ss = 80;

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);

    noStroke();
    fill(250);
    ellipse(p.x, p.y, ss*1.06, ss*1.06);
    fill(rcol());
    ellipse(p.x, p.y, ss, ss);

    ArrayList<PVector> ps = new ArrayList<PVector>();

    for (int j = 0; j < 3000; j++) {
      float a = random(TAU);
      float r = sqrt(random(1))*random(1);

      float x = p.x+cos(a)*r*ss*0.5;      
      float y = p.y+sin(a)*r*ss*0.5;
      float s = ss*0.05*(1-r);

      boolean add = true;
      for (int k = 0; k < ps.size(); k++) {
        PVector o = ps.get(k);
        if (dist(x, y, o.x, o.y) < (s+o.z)*1.2) {
          add = false;
          break;
        }
      }
      if (add) {
        int col = color(255);
        if (random(1) < 0.1) col = (rcol());
        strokeWeight(s*0.4);
        beginShape(LINES);
        stroke(col, 60);
        vertex(x, y);
        stroke(col, 0);
        vertex(p.x, p.y);
        endShape();
        strokeWeight(s);
        stroke(col);
        point(x, y);
        ps.add(new PVector(x, y, s));
      }
    }
  }
}

void lineSine(float x1, float y1, float a1, float x2, float y2, float a2, float s) {
  int res = int(dist(x1, y1, x2, y2)+2);
  float ang = atan2(y2-y1, x2-x1);
  noFill();
  beginShape();
  float dx = cos(ang-HALF_PI);
  float dy = sin(ang-HALF_PI);
  for (int i = 0; i <= res; i++) {
    float xx = map(i, 0, res, x1, x2);
    float yy = map(i, 0, res, y1, y2);
    float aa = cos(map(i, 0, res, a1, a2))*s;
    vertex(xx+aa*dx, yy+aa*dy);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
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
