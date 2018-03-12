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

void generate() {
  seed = int(random(999999));

  background(240);//getColor(random(colors.length)));
  translate(width/2, height/2);
  translate(random(-50, 50), random(-50, 50));
  rotate(random(TWO_PI));

  ArrayList<Tri> tris = new ArrayList<Tri>();
  float ss = width*random(1.8, 2.4);
  for (int k = 0; k < 6; k++) {
    float da = TWO_PI/6;
    float ang = da*k-PI/6;
    float rr = ss*0.25;
    tris.add(new Tri(cos(ang)*rr, sin(ang)*rr, ss*0.5, da*(k+0.5), 1));
  }

  int sub = int(random(1, random(10000)));
  for (int k = 0; k < sub; k++) {
    int ind = int(random(tris.size()*random(1)));
    ArrayList<Tri> aux = tris.get(ind).sub();
    tris.addAll(aux);
    tris.remove(ind);
  }
  int sb = 2;//int(pow(2, int(random(2, 12))));//int(random(3, 60));

  stroke(0, 20);
  for (int c = 0; c < tris.size(); c++) {
    //if (random(1) < 0.1) continue;

    Tri t = tris.get(c);
    noStroke();
    fill(getColor(random(colors.length)));
    fill(rcol());
    t.show();

    float a = random(TWO_PI);
    float r = t.r*random(1);
    r *= map(abs((a+t.a)%(TWO_PI/3)-(PI/3)), 0, PI/3, 0.8, 0.4);
    float cx = t.x+cos(a)*r;
    float cy = t.y+sin(a)*r;
    for (int i = 0; i < 3; i++) {
      float da = TWO_PI/3.0;
      float ang = t.a+da*i;
      float x1 = t.x+cos(ang)*t.r;
      float x2 = t.x+cos(ang+da)*t.r;
      float y1 = t.y+sin(ang)*t.r;
      float y2 = t.y+sin(ang+da)*t.r;
      float val = map(abs(atan2(cy-(y2+y1)*0.5, cx-(x2+x1)*0.5)-PI), 0, PI, 0, 70);
      beginShape();
      fill(0, val*0.5);
      vertex(cx, cy);
      fill(0, val*0.8);
      vertex(x1, y1);
      fill(0, val);
      vertex(x2, y2);
      endShape();
    }
    /*
    for (int j = 0; j < 3; j++) {
     float da = TWO_PI/3;
     float ang = t.a+da*j;
     float x1 = t.x+cos(ang)*t.r;
     float x2 = t.x+cos(ang+da)*t.r;
     float y1 = t.y+sin(ang)*t.r;
     float y2 = t.y+sin(ang+da)*t.r;
     
     float sb2 = sb/pow(2, t.sub);
     for (int i = 0; i < sb2; i++) {
     float xx = map(i, 0, sb2, x1, x2);
     float yy = map(i, 0, sb2, y1, y2);
     //stroke(getColor(random(colors.length)), 160);
     line(cx, cy, xx, yy);
     }
     }*/
  }
}

float sign (PVector p1, PVector p2, PVector p3) {
  return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

boolean PointInTriangle (PVector pt, PVector v1, PVector v2, PVector v3) {
  boolean b1, b2, b3;
  b1 = sign(pt, v1, v2) < 0.0f;
  b2 = sign(pt, v2, v3) < 0.0f;
  b3 = sign(pt, v3, v1) < 0.0f;
  return ((b1 == b2) && (b2 == b3));
}

class Tri {
  int sub;
  float x, y, s, r, a;
  Tri(float x, float y, float s, float a, int sub) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.a = a;
    this.sub = sub;
    r = s*0.5;
  }

  void show() {
    show(1);
  }

  void show(float rr) {
    float da = TWO_PI/3; 
    beginShape();
    for (int i = 0; i < 3; i++) {
      float ang = da*i+a;
      vertex(x+cos(ang)*r*rr, y+sin(ang)*r*rr);
    }
    endShape(CLOSE);
  }

  ArrayList<Tri> sub() {
    ArrayList<Tri> aux = new ArrayList<Tri>();
    aux.add(new Tri(x, y, s*0.5, (a+PI)%TWO_PI, sub+1));
    float da = TWO_PI/3.0;
    float mr = r*0.5;
    float ang = 0;
    for (int i = 0; i < 3; i++) {
      ang = (da*i+a)%TWO_PI;
      aux.add(new Tri(x+cos(ang)*mr, y+sin(ang)*mr, r, a, sub+1));
    }
    return aux;
  }
}

int colors[] = {#BCBDAC, #E0A92A, #F27435, #F02475, #33222F };
//int colors[] = {#470031, #971549, #FF5200, #F7F09B};
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