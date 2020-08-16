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

  int back = lerpColor(color(#FB9845), getColor(), random(0.05));
  back = color(240);
  background(back);

  noStroke();
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    x -= x%20;
    float y = random(width);
    y -= y%20;
    float s = random(20)*random(0.4);
    fill(rcol(), random(180)*random(0.4, 1));
    ellipse(x, y, s, s);
  }

  noStroke();
  for (int i = 0; i < 4; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(width);
    fill(rcol(), 20);
    ellipse(xx, yy, ss, ss);


    noStroke();
    arc2(xx, yy, ss, ss*0.96, 0, TAU, color(60), random(8, 20), 0);
    arc2(xx, yy, ss, ss*0.8, 0, TAU, color(40), random(8, 20), 0);
    //arc2(xx, yy, ss, ss*1.4, 0, TAU, color(240), random(30, 60), 0);
  }

  stroke(255, 60);
  for (int j = 0; j <= height; j+=10) {
    for (int i = 0; i <= width; i+=10) {
      point(i, j);
    }
  }



  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  int count = 30;
  for (int i = 0; i < count; i++) {
    double x = width*random(-0.2, 1.2);
    double y = height*random(-0.2, 1.2);
    float scale = random(0.8, 1.4)*0.6*random(0.4, 1);
    float minSize = width*random(0.04, 0.2)*scale;
    float maxSize = minSize*random(1, 3)*scale*0.5;
    float des1 = random(10000);
    float det1 = random(0.001)*random(2);
    float des2 = random(10000);
    float det2 = random(0.001)*random(2);
    float ic = random(100);
    float dc = random(0.004)*random(0.2, 1)*random(0.5, 1);
    float da = random(0.004, 0.006)*((random(1) < 0.5)? -1 : 1)*0.8;

    int cc = int(random(2000, 2800));
    int ccc = int(random(4, 7));
    float dd = TAU/ccc;
    float ia = random(TAU);

    float rrr = random(0.04, 0.08);

    float black = random(0.4)*random(1);

    for (int j = 0; j < cc; j++) {
      double a = SimplexNoise.noise(des1+x*det1, des1+y*det1)*2*TAU;
      float amp = 0.5+pow(sin(j*PI/cc), 2)*0.5;
      float s = 0.3*lerp(minSize, maxSize, (float)SimplexNoise.noise(des2+x*det2, des2+y*det2))*amp;
      int col = lerpColor(back, getColor(ic+dc*j), 0.2+pow(i*1./count, 0.2)*0.8);
      col = lerpColor(col, color(0), black);
      fill(col, 250);
      ellipse((float)x, (float)y, s, s);

      if (random(1) < 0.0001) {
        stroke(col, 160);
        noFill();
        ellipse((float)x, (float)y, s*5, s*5);
        noStroke();
        fill(col, 80);
        ellipse((float)x, (float)y, s*4, s*4);
        points.add(new PVector((float)x, (float)y));
      }

      x += Math.cos(a)*0.4*scale;
      y += Math.sin(a)*0.4*scale;

      if (random(1) < 0.06) {
        float a2 = random(TAU);
        double xx = x+Math.cos(a2)*s*1.0;
        double yy = y+Math.sin(a2)*s*1.0;
        float ss = s*random(0.01, 0.08);
        stroke(col, 160);
        strokeWeight(s*0.02);
        line((float)xx, (float)yy, (float)x, (float)y);
        noStroke();
        ellipse((float)xx, (float)yy, ss, ss);
        fill(255, 40);
        ellipse((float)xx, (float)yy, ss*0.9, ss*0.9);


        if (random(1) < 0.005) {
          stroke(col, 220);
          noFill();
          ellipse((float)xx, (float)yy, ss*5, ss*5);
        }
      }

      noStroke();
      strokeWeight(1);


      float amprad = pow(sin(j*PI/cc), 0.4)*0.2;
      fill(lerpColor(back, getColor(ic+dc*j+2), 0.2+pow(i*1./count, 1.2)*0.8), 240);
      //fill(0, 40);
      for (int k = 0; k < ccc; k++) {
        float aa = ia+dd*k+da*j;
        float r = s*(1-rrr*0.5)*2.4*scale;
        ellipse((float)x+cos(aa)*r, (float)y+sin(aa)*r, s*rrr*amprad, s*rrr*amprad);
      }
    }
  }


  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  noFill();
  beginShape(LINES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = triangles.get(i);
    stroke(rcol(), random(40));
    vertex(t.p1.x, t.p1.y);
    stroke(rcol(), random(40));
    vertex(t.p2.x, t.p2.y);
    stroke(rcol(), random(40));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();



  noStroke();
  fill(250, 80);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 2, 2);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));

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

int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
