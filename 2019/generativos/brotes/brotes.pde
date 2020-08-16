import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960*2; 
float nheight = 960*2;
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

  generate();
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

  background(#0A0A15);

  pushMatrix();
  translate(width*0.5, height*0.5);
  for (int i = 0; i < 30; i++) {
    float x1 = width*random(-0.35, 0.35)*random(1);
    float y1 = height*random(0.35, 0.45);
    float x2 = width*random(-0.35, 0.35)*random(1);
    float y2 = height*random(-0.45, -0.25);
    
    x1 = width*random(-0.65, 0.65);
    y1 = width*random(-0.65, 0.65);
    x2 = height*random(-0.65, 0.65);
    y2 = height*random(-0.65, 0.65);
    
    three(x1, y1, x2, y2);
  }
  //scale(1.4);
  popMatrix();
}

void three(float x1, float y1, float x2, float y2) {

  ArrayList<Line> lines = new ArrayList<Line>();

  lines.add(new Line(x1, y1, x2, y2));
  int sub = 90000;
  for (int i = 0; i < sub; i++) {
    //int ind = int(random(random(lines.size())*random(1), lines.size()));
    int ind = int(random(lines.size())*random(0.8, 1));
    Line l = lines.get(ind);

    float ang = atan2(l.y2-l.y1, l.x2-l.x1);
    float dis = dist(l.x1, l.y1, l.x2, l.y2);

    if (dis < 4) continue;
    float ampAng = 1.4;

    if (!l.divide) {
      float mul = random(random(0.6, 0.7), random(0.8));

      float nx = lerp(l.x1, l.x2, mul);
      float ny = lerp(l.y1, l.y2, mul);

      l.x2 = nx;
      l.y2 = ny;

      float ampAng1 = random(1.2)*random(0.2, 1)*ampAng;
      float ampAng2 = random(1.2)*random(0.2, 1)*ampAng;

      float range = lerp(ampAng1, ampAng2, random(1));

      //ampAng1 -= range;
      //ampAng2 -= range;

      float des1 = dis*(1-mul)*random(0.9, 1.2);
      float des2 = dis*(1-mul)*random(0.9, 1.2);
      float des3 = dis*(1-mul)*random(0.9, 1.2);

      float a1 = ang+ampAng1;
      float a2 = ang-ampAng2;
      float a3 = ang+random(-0.1, 0.1);

      l.divide = true;

      Line l1 = new Line(nx, ny, nx+cos(a1)*des1, ny+sin(a1)*des1);
      Line l2 = new Line(nx, ny, nx+cos(a2)*des2, ny+sin(a2)*des2);
      Line l3 = new Line(nx, ny, nx+cos(a3)*des3, ny+sin(a3)*des3);

      int sel = int(random(3));

      if (sel == 1) {

        lines.add(l1);
        lines.add(l2);
      } else if (sel == 2) {

        lines.add(l3);
      } else if (sel == 2) {

        lines.add(l3);
        if (random(1) < 0.5) {

          lines.add(l1);
        } else {

          lines.add(l2);
        }
      }
    } else {

      float mul = random(random(0.6, 0.7), random(0.8))*0.4;

      float nx = lerp(l.x1, l.x2, mul);
      float ny = lerp(l.y1, l.y2, mul);

      Line l2 = new Line(nx, ny, l.x2, l.y2);
      l2.divide = true;

      l.x2 = nx;
      l.y2 = ny;

      lines.add(l2);


      float desAng = random(0.1, 0.4)*((random(1) < 0.5)? -1 : 1)*2;
      float des = dis*(1-mul)*random(0.9, 1.1);

      lines.add(new Line(nx, ny, nx+cos(ang+desAng)*des, ny+sin(ang+desAng)*des));
    }
  }

  int greens[] = new int[100];
  for (int i = 0; i < greens.length; i++) {
    float val = map(i, 0, greens.length-1, 0, 1);
    greens[i] = color(random(256), random(256), random(256));//lerpColor(#8D7E43, #70804C, val);
  }

  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    float alp = random(160, 210)-150;
    alp = 60;
    strokeWeight(1.4);
    
    if(random(1) < 0.2) blendMode(ADD);
    else blendMode(NORMAL);
    
    beginShape(LINES);
    stroke(greens[int(random(greens.length))], alp);
    vertex(l.x1, l.y1);
    stroke(greens[int(random(greens.length))], alp*0.9);
    vertex(l.x2, l.y2);
    endShape();
  }

  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);

    if (!l.divide) {

      if (random(1) < 0.95) continue;
      noStroke();
      //fill(255, 0, 40);
      fill(rcol());
      float ps = random(0.5, random(2, 5));
      ellipse(l.x2, l.y2, ps, ps);
    }
  }
}

class Line {

  boolean divide;
  float x1, y1, x2, y2;
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1; 
    this.x2 = x2; 
    this.y2 = y2;

    divide = false;
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
//int colors[] = {#F5B4C4, #FCCE44, #ED493D, #77C9EC, #C5C4C4};
//int colors[] = {#2B81A2, #040109, #82BA94, #82BA94, #2B81A2};
int colors[] = {#EB4313, #E9CA54, #749AB2};
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
