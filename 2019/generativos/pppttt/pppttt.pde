import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
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
  strokeCap(SQUARE);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(2, 0, 9);

  //blendMode(ADD);

  int sub = int(random(3, 10));
  float dd = height/(sub+1);

  stroke(255, 40);
  for (int j = 0; j < sub*10; j++) {
    for (int i = 0; i < sub*10; i++) {
      float xx = map(i+0.5, 0, sub*10, 0, width);
      float yy = map(j+0.5, 0, sub*10, 0, height);
      point(xx, yy);
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i <= sub; i++) {
    stroke(255, 20);
    float yy = (i+0.5)*dd;
    line(0, yy, width, yy);

    noStroke();
    for (int j = 0; j < 20; j++) {
      float xx = random(20, width-20);
      float ss = 2*pow(2, int(random(7)));
      xx -= xx%10;

      boolean add = true;
      for (int k = 0; k < points.size(); k++) {
        PVector p = points.get(k);
        if (dist(p.x, p.y, xx, yy) < 0.5) {
          add = false;
          break;
        }
      }
      if (add)
        points.add(new PVector(xx, yy));

      fill(255, 40);
      ellipse(xx, yy, ss, ss);
      fill(rcol(), 220);
      ellipse(xx, yy, ss*0.2, ss*0.2);
    }
  }

  noFill();
  stroke(0, 40);
  ArrayList<Triangle> tris = new ArrayList<Triangle>();
  tris = Triangulate.triangulate(points);
  beginShape(TRIANGLES);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);

    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
    float val = cos(cen.x*0.01)+sin(cen.y*0.2)*0.2;
    int col1 = getColor(val*4+random(0.2), 2);
    int col2 = getColor(val*4, 2);
    fill(col1, random(200, 250));
    vertex(t.p1.x, t.p1.y);
    fill(col2, random(200, 250));
    vertex(t.p2.x, t.p2.y);
    fill(col2, random(200, 250));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(int(random(points.size())));
    fill(rcol());
    ellipse(p.x, p.y, 5, 5);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int back[] = {#F7743B, #9DAAA9, #6894AA, #4F4873, #3A3A3A};
//int flowers[] = {#CC3622, #EDE374, #5A2F84, #2D38AF, #CC1818};
int colors[] = {#f7f033, #eef6f7, #c0e3f7, #bc94f4, #505edd};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float pwr) {
  return getColor(random(colors.length), pwr);
}
int getColor(float v, float pwr) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, pwr));
}

float random2 (float x, float y) {
  float d = x*12.9898+y*78.233;
  return (abs(sin(d)*43758.5453123))%1;
}


float noise2 (float x, float y) {
  float ix = floor(x);
  float iy = floor(y);
  float fx = x%1;
  float fy = y%1;

  // Four corners in 2D of a tile
  float a = random2(ix, iy);
  float b = random2(ix+1, iy);
  float c = random2(ix, iy+1);
  float d = random2(ix+1, iy+1);

  float ux = fx * fx * (3.0 - 2.0 * fx);
  float uy = fy * fy * (3.0 - 2.0 * fy);

  return lerp(a, b, ux) +
    (c - a)* uy * (1.0 - ux) +
    (d - b) * ux * uy;
}

float fbm (float x, float y) {
  int oct = 6;
  float val = 0.0;
  float amp = .5;
  for (int i = 0; i < oct; i++) {
    val += amp * noise2(x, y);
    x *= 2.;
    y *= 2.;
    amp *= .5;
  }
  return val;
}
