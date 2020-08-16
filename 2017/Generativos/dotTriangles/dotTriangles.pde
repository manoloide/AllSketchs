int seed = int(random(999999));
void setup() {
  size(960, 960);
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

  background(255);
  translate(width/2, height/2);
  translate(random(-50, 50), random(-50, 50));
  rotate(random(TWO_PI));

  ArrayList<Tri> tris = new ArrayList<Tri>();
  for (int k = 0; k < 6; k++) {
    float ss = width*random(1.8, 2.4);
    float da = TWO_PI/6;
    float ang = da*k-PI/6;
    float rr = ss*0.25;
    tris.add(new Tri(cos(ang)*rr, sin(ang)*rr, ss*0.5, da*(k+0.5)));
  }

  int sub = int(random(1, 140));
  for (int k = 0; k < sub; k++) {
    int ind = int(random(tris.size()*random(1)));
    ArrayList<Tri> aux = tris.get(ind).sub();
    tris.addAll(aux);
    tris.remove(ind);
  }

  for (int i = 0; i < tris.size(); i++) {
    Tri t = tris.get(i);
    //t.show();
  }  


  int cc = int(random(2, random(10, 100)));
  noStroke();
  for (int i = 0; i < tris.size(); i++) {
    Tri t = tris.get(i);
    float x = t.x;//random(width);
    float y = t.y;//random(height);
    float sep = random(1, 8);
    float ss = sep*random(0.7, 0.9);
    float det = random(0.002);
    float s = t.s-sep*0.5;//width*random(0.8);
    float r = s*0.5;
    float a = t.a;//random(TWO_PI);
    PVector p1, p2, p3;
    float da = TWO_PI/3;
    p1 = new PVector(x+cos(a)*r, y+sin(a)*r);
    p2 = new PVector(x+cos(a+da)*r, y+sin(a+da)*r);
    p3 = new PVector(x+cos(a+da*2)*r, y+sin(a+da*2)*r);

    float ang = a;
    fill(0);
    if (random(1) < 0.5) {
      fill(0);
      t.show();
      fill(255);
    }
    float dh = sqrt(3)*sep*0.5;
    int cw = int(r/dh);
    int ch = int(r/sep);
    for (int dy = -cw; dy <= cw; dy++) {
      float dd = (dy%2==0)? 0 : sep*0.5;
      for (int dx = -ch; dx <= ch; dx++) {
        float xx = x+cos(ang)*(dx*sep+dd)+cos(ang+HALF_PI)*(dy*dh);
        float yy = y+sin(ang)*(dx*sep+dd)+sin(ang+HALF_PI)*(dy*dh);
        float sss = 0.1+ss*noise(xx*det, yy*det);
        if (PointInTriangle(new PVector(xx, yy), p1, p2, p3)) {
          ellipse(xx, yy, sss, sss);
        }
      }
    }
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
  float x, y, s, r, a;
  Tri(float x, float y, float s, float a) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.a = a;
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
    aux.add(new Tri(x, y, s*0.5, (a+PI)%TWO_PI));
    float da = TWO_PI/3.0;
    for (int i = 0; i < 3; i++) {
      float ang = (da*i+a)%TWO_PI;
      aux.add(new Tri(x+cos(ang)*r*0.5, y+sin(ang)*r*0.5, r, a));
    }

    return aux;
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