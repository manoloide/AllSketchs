int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

float det = 0.001;
void generate() {
  seed = int(random(999999));

  det = random(0.002);

  background(250);
  translate(width/2, height/2);
  rotate(random(TWO_PI));

  noFill();
  stroke(255);
  Tri t = new Tri(0, height*0.1, width*random(3, 3.6), PI*1.5);
  //t.show();

  ArrayList<Tri> tris = new ArrayList<Tri>();
  tris.add(t);
  int sub = int(random(20000)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(tris.size()));
    ArrayList<Tri> nt = tris.get(ind).sub(int(random(2, 5)));
    tris.remove(ind);
    tris.addAll(nt);
  }

  int vv = int(random(5, 50));
  strokeWeight(0.8);
  for (int c = 0; c < tris.size(); c++) {
    Tri tri = tris.get(c);
    fill(getColor(random(colors.length)));
    noStroke();
    tri.show();
    PVector cen = tri.getCen();
    fill(getColor(random(colors.length)));
    //stroke(0, 40);
    //tri.showLine(vv);
    //ellipse(cen.x, cen.y, 4, 4);
  }
}

class Tri {
  float x1, y1, x2, y2, x3, y3;
  Tri(float x, float y, float s, float a) {
    float da = TWO_PI/3;
    float r = s*0.5;
    x1 = x+cos(a+da*0)*r;
    y1 = y+sin(a+da*0)*r;
    x2 = x+cos(a+da*1)*r;
    y2 = y+sin(a+da*1)*r;
    x3 = x+cos(a+da*2)*r;
    y3 = y+sin(a+da*2)*r;
  }
  Tri(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2; 
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
  }

  void show() {
    //triangle(x1, y1, x2, y2, x3, y3);
    float v = 0; 
    beginShape();
    fill(getColor(noise(x1*det, y1*det, frameCount)*colors.length*2));
    vertex(x1, y1);
    fill(getColor(noise(x2*det, y2*det, frameCount)*colors.length*2));
    vertex(x2, y2);
    fill(getColor(noise(x3*det, y3*det, frameCount)*colors.length*2));
    vertex(x3, y3);
    endShape();
  }

  PVector getCen() {
    PVector aux = new PVector(x1, y1);
    aux.add(x2, y2);
    aux.add(x3, y3);
    aux.div(3);
    return aux;
  }

  ArrayList<Tri> sub(int cc) {
    deorder();
    ArrayList<Tri> aux = new ArrayList<Tri>();
    for (int i = 0; i < cc; i++) {
      float ax1 = map(i, 0, cc, x2, x3); 
      float ay1 = map(i, 0, cc, y2, y3);
      float ax2 = map(i+1, 0, cc, x2, x3); 
      float ay2 = map(i+1, 0, cc, y2, y3); 
      aux.add(new Tri(x1, y1, ax1, ay1, ax2, ay2));
    }
    return aux;
  }

  void showLine(int vv) {
    PVector cen = getCen();
    for (int i = 0; i < 3; i++) {
      float xx1, yy1, xx2, yy2;
      xx1 = yy1 = xx2 = yy2 = 0;
      if (i == 0) {
        xx1 = x1;
        yy1 = y1; 
        xx2 = x2; 
        yy2 = y2;
      }
      if (i == 1) {
        xx1 = x2;
        yy1 = y2; 
        xx2 = x3; 
        yy2 = y3;
      }
      if (i == 2) {
        xx1 = x3;
        yy1 = y3; 
        xx2 = x1; 
        yy2 = y1;
      }
      for (int j = 0; j < vv; j++) {
        float xx = map(j, 0, vv-1, xx1, xx2);
        float yy = map(j, 0, vv-1, yy1, yy2); 
        line(cen.x, cen.y, xx, yy);
      }
    }
  }

  void deorder() {
    float d1 = dist(x1, y1, x2, y2)+dist(x1, y1, x3, y3);
    float d2 = dist(x2, y2, x1, y1)+dist(x2, y2, x3, y3);
    float d3 = dist(x3, y3, x1, y1)+dist(x3, y3, x2, y2);
    float ax = x1; 
    float ay = y1;
    if (d2 <= d1 && d2 <= d3) {
      x1 = x2; 
      y1 = y2;
      x2 = ax;
      y2 = ay;
    } else if (d3 <= d1 && d3 <= d2) {
      x1 = x3; 
      y1 = y3;
      x3 = ax;
      y3 = ay;
    }
  }
}


int colors[] = {#BCBDAC, #CFBE27, #F27435, #F02475, #3B2D38 };
int rcol() { 
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}


void form(float x, float y, float s) {
  int seg = 1200; 

  float r1 = s*random(0.3, 0.5);
  float r2 = s*random(0.5);

  float d1 = s*random(0.1);
  float d2 = s*random(0.1);

  r1 -= d1;
  r2 -= d2;

  float mr1 = 1-random(0.4);
  float mr2 = 1-random(0.4);

  float osc1 = TWO_PI/seg*int(random(1, 14));
  float osc2 = TWO_PI/seg*int(random(1, 14));

  float da1 = TWO_PI/seg*int(random(6, random(40)));
  float da2 = TWO_PI/seg*int(random(6, random(40)));

  float a1 = random(TWO_PI);
  float a2 = random(TWO_PI);

  float dd1 = (TWO_PI/seg)*int(random(1, random(40)));
  float dd2 = (TWO_PI/seg)*int(random(1, random(40)));

  for (int i = 0; i < seg; i++) {
    float o1 = map(cos(osc1*i), -1, 1, mr1, 1);
    float o2 = map(cos(osc2*i), -1, 1, mr2, 1);
    float x1 = x+cos(a1+da1*i)*r1*o1+cos(dd1*i)*d1;
    float y1 = y+sin(a1+da1*i)*r1*o1+sin(dd1*i)*d1;
    float x2 = x+cos(a2+da2*i)*r2*o2+cos(dd2*i)*d2;
    float y2 = y+sin(a2+da2*i)*r2*o2+sin(dd2*i)*d2;

    line(x1, y1, x2, y2);
  }
}

void cross(float x, float y, float s, float amp, float a) {
  float r = s/2;
  float d = s*amp*0.5;
  float r2 = d*sqrt(2);

  beginShape();
  for (int i = 0; i < 4; i++) {
    float a1 = a+HALF_PI*i;
    float ax = x+cos(a1)*r; 
    float ay = y+sin(a1)*r;  
    float dx = cos(a1-HALF_PI)*d;
    float dy = sin(a1-HALF_PI)*d;
    vertex(ax+dx, ay+dy);
    //vertex(ax, ay);
    vertex(ax-dx, ay-dy);

    vertex(x+cos(a1+HALF_PI*0.5)*r2, y+sin(a1+HALF_PI*0.5)*r2);
  }
  endShape(CLOSE);
}