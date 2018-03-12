
int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void draw() {
}

void generate() {
  randomSeed(seed);
  background(234);

  generateQuads(); 

  for (int i = 0; i < quads.size (); i++) {
    Quad q = quads.get(i);
    float cx = q.cx;
    float cy = q.cy;
    float r1 = q.w*random(0.3, 0.4);
    float r2 = r1*random(0.2, random(0.5, 0.9));
    float v1 = random(TWO_PI);
    int cc = 2*int(random(4, 34));
    circular(cx, cy, r1, r2, v1, v1, cc);
  }

  int c = int(random(5, random(5, 120)));
  for (int i = 0; i < c; i++) {
    float cx = random(width);
    float cy = random(height);
    float w = width/pow(2, int(random(5)));
    float r1 = w*random(0.3, 0.4);
    float r2 = r1*random(0.2, random(0.5, 0.9));
    float v1 = random(TWO_PI);
    int cc = 2*int(random(4, 34));
    circular(cx, cy, r1, r2, v1, v1, cc);
  }
}

void circular(float cx, float cy, float r1, float r2, float v1, float v2, int cc) {
  float da = TWO_PI/cc;
  fill(60);
  stroke(210);
  strokeWeight(2);
  for (int i = 0; i <= cc; i++) {
    float a1 = i*da+v1;
    float a2 = i*da+v2;
    ellipse(cx+cos(a1)*r1, cy+sin(a1)*r1, 6, 6);
    ellipse(cx+cos(a2)*r2, cy+sin(a2)*r2, 6, 6);
  }
  noFill();
  for (int i = 0; i <= cc*random (0.1, 40); i++) {
    int c1 = int(random(cc+1));
    int c2 = c1+int(random(-4, 4));
    float dd = 2;

    float a1 = c1*da+v1;
    float a2 = c2*da+v2;

    float aa = a2-a1;
    float dr = r1-r2;
    dr = dist(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a2)*r2, cy+sin(a2)*r2);

    float amp = random(0.1, 0.9);

    stroke(0, 22);
    strokeWeight(3);
    bezier(cx+cos(a1)*r1, cy+sin(a1)*r1+dd, cx+cos(a1)*(r1-dr*amp), cy+sin(a1)*(r1-dr*amp)+dd, cx+cos(a2)*(r2+dr*amp), cy+sin(a2)*(r2+dr*amp)+dd, cx+cos(a2)*r2, cy+sin(a2)*r2+dd);
    stroke(rcol());
    strokeWeight(2);
    bezier(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a1)*(r1-dr*amp), cy+sin(a1)*(r1-dr*amp), cx+cos(a2)*(r2+dr*amp), cy+sin(a2)*(r2+dr*amp), cx+cos(a2)*r2, cy+sin(a2)*r2);

    //line(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a2)*r2, cy+sin(a2)*r2); 
    /*
    stroke(0, 16);
     strokeWeight(3);
     bezier(x, y+dy*c1+dd, x+w*0.5, y+dy*c1+dd, x+w*0.5, y+dy*c2+dd, x+w, y+dy*c2+dd);
     stroke(200, 255, 20);
     strokeWeight(2);
     bezier(x, y+dy*c1, x+w*0.5, y+dy*c1, x+w*0.5, y+dy*c2, x+w, y+dy*c2);
     */
  }
}

ArrayList<Quad> quads = new ArrayList<Quad>();

class Quad {
  boolean remove;
  float x, y, w, h, cx, cy;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    cx = x + w/2;
    cy = y + h/2;
    remove = false;
  }

  void subdivice(int subs) {
    if (subs > 1) {
      remove = true;
      float xx = x;
      float yy = y;
      float dw = w/subs;
      float dh = h/subs;
      for (int j = 0; j < subs; j++) {
        for (int i = 0; i < subs; i++) {
          quads.add(new Quad(xx+dw*i, yy+dh*j, dw, dh));
        }
      }
    }
  }
}

void generateQuads() {
  quads = new ArrayList<Quad>(); 
  quads.add(new Quad(0, 0, width, height));
  int cc = int(random(3, 9));
  for (int i = 0; i < cc; i++) {
    int val = int(random(quads.size()));
    Quad quad = quads.get(val);
    int subs = int(random(4));
    quad.subdivice(subs);
    if (quad.remove) {
      quads.remove(val);
    }
  }

  for (int i = 0; i < quads.size (); i++) {
    Quad q = quads.get(i);
    float col = random(230, 238);
    noStroke();
    fill(col);
    //fill(random(256), random(256), random(256));
    rect(q.x, q.y, q.w, q.h);
    fill(col+6);
    rect(q.x, q.y, q.w, 1);
    rect(q.x, q.y, 1, q.h);
    fill(col-6);
    rect(q.x, q.y+q.h-1, q.w, 1);
    rect(q.x+q.w-1, q.y, 1, q.h);
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

color rcol() {
  return (random(1) < 0.4)?  color(200, 255, 20) : (random(1) < 0.5)? color(20, 255, 200) : color(255, 20, 200);
}