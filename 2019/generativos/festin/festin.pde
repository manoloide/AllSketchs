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


  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 120; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%40;
    y -= y%5;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < 10) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y));
  }


  ArrayList triangles = Triangulate.triangulate(points);
  
  
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector c = t.p1.copy().add(t.p2).add(t.p3).div(3);
    fill(rcol());
    ellipse(c.x, c.y, 4, 4);
    fill(0);
    ellipse(c.x, c.y, 2, 2);
  }
  
  stroke(0, 40);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(random(255), random(40));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  
  noStroke();
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) > 0.12) continue;
    Triangle t = (Triangle)triangles.get(i);
    int col = rcol();
    fill(col);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    fill(lerpColor(col, color(255), 0.5));
    vertex(t.p3.x, t.p3.y);
  }

  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) > 0.04) continue;
    Triangle t = (Triangle)triangles.get(i);

    float dx = random(-8, 8)*0.4;
    float dy = random(-8, 8)*0.4;
    for (int j = 0; j < 30; j++) {
      fill((j%2 == 0)? 0 : 250);
      vertex(t.p1.x+dx*j, t.p1.y+dy*j);
      vertex(t.p2.x+dx*j, t.p2.y+dy*j);
      vertex(t.p3.x+dx*j, t.p3.y+dy*j);
    }
  }
  endShape();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, 3, 3);
  }
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
