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

class Point {
  ArrayList<Point> brothers;
  float x, y, s, n; 
  Point(float x, float y, float s, float n) {
    this.x = x; 
    this.y = y; 
    this.s = s; 
    this.n = n;

    brothers = new ArrayList<Point>();
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);
  background(250);

  ArrayList<Point> points = new ArrayList<Point>();

  float detSize = random(0.0008, 0.001)*3;
  float maxSize = width*0.5;

  for (int i = 0; i < 10000; i++) {
    float x = random(width); 
    float y = random(height);
    //float noi = (float) SimplexNoise.noise(x*detSize, y*detSize, seed*0.01);
    float n = noise(x*detSize, y*detSize, seed*0.01)*random(0.8, 1);
    n = pow(n, 1.8);
    float s = n*maxSize;

    if (s < 2) continue;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      Point o = points.get(j);
      float dist = dist(o.x, o.y, x, y);
      float radius = (o.s+s);
      if (dist < radius) {
        if (dist < radius*(0.4-(n+o.n)*0.1)) {
          add = false;
          break;
        }
      }
    }  

    if (add) points.add(new Point(x, y, s, n));
  }

  for (int i = 0; i < 1000000; i++) {
    float x = random(width); 
    float y = random(height);
    float n = random(1)*random(0.5, 1);
    float s = n*maxSize;


    if (s < 2) continue;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      Point o = points.get(j);
      float dist = dist(o.x, o.y, x, y);
      float radius = (o.s+s)*0.4;
      if (dist < radius) {
        add = false;
        break;
      }
    }  

    if (add) points.add(new Point(x, y, s, n));
  }

  int cc = int(points.size()*0.1);
  for (int i = 0; i < cc; i++) {
    //points.remove(int(random(points.size())));
  }

  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);
    for (int j = i+1; j < points.size(); j++) {
      Point o = points.get(j);
      float dist = dist(o.x, o.y, p.x, p.y);
      float radius = (o.s+p.s);
      if (dist < radius) {
        p.brothers.add(o);
        o.brothers.add(p);
      }
    }
  }

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    Point p = points.get(i);


    float col = p.s*0.02;
    fill(getColor(col));
    int res = int(p.s*PI)+2;
    float da = TAU/res;
    float r = p.s*0.5;
    stroke(0, 60);

    float dist[] = new float[res];

    beginShape();
    for (int j = 0; j < res; j++) {
      float a = da*j;
      float ox = p.x+cos(a)*r*0.9;
      float oy = p.y+sin(a)*r*0.9;
      float x = p.x+cos(a)*r*0.82;
      float y = p.y+sin(a)*r*0.82;
      for (int k = 0; k < p.brothers.size(); k++) {
        Point b = p.brothers.get(k);
        float dis = dist(x, y, b.x, b.y);
        float ang = atan2(y-b.y, x-b.x);
        if (dis < b.s*0.5) {
          x = lerp(x, b.x+cos(ang)*b.s*0.5, 0.45);
          y = lerp(y, b.y+sin(ang)*b.s*0.5, 0.45);
        }
      }
      float xx = lerp(x, ox, 0.12);
      float yy = lerp(y, oy, 0.12);
      dist[j] = dist(xx, yy, p.x, p.y);
      vertex(xx, yy);
    }
    endShape();

    int ccc = int(r*r*PI*0.4);
    stroke(0, 120);
    for (int j = 0; j < ccc; j++) {
      float ang = random(TAU);
      float max = dist[int((ang/TAU)*res)]-0.5;
      float des = max*sqrt(random(random(1), 1));
      float val = des/max;
      float x = p.x+cos(ang)*des;
      float y = p.y+sin(ang)*des;
      //strokeWeight(r*random(0.05));
      stroke(getColor(col+pow(val, 1.8)*2.2), 220);
      point(x, y);
    }
    /*
    float rad = p.s*random(0.25)*random(0.2, 1);
     float ang = atan2(height*0.5-p.y, width*0.5-p.x);
     //ellipse(p.x, p.y, p.s, p.s);
     fill(rcol());
     ellipse(p.x+cos(ang)*rad, p.y+sin(ang)*rad, p.s*0.4, p.s*0.4);
     fill(0);
     ellipse(p.x+cos(ang)*rad, p.y+sin(ang)*rad, p.s*0.25, p.s*0.25);
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
