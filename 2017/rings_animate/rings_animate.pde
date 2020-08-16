ArrayList<Ring> rings;

int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {

  for (int i = 0; i < rings.size(); i++) {
    rings.get(i).update();
    rings.get(i).show();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

PVector des(PVector pos, float d, float s) {
  pos.x += noise(pos.x*d, pos.y*d)*s-s*0.5; 
  pos.y += noise(pos.x*d+100, pos.y*d)*s-s*0.5;
  return pos;
}

void generate() {
  seed = int(random(999999));
  //background(getColor(random(colors.length)));
  rings = new ArrayList<Ring>();
  noiseSeed(seed);
  randomSeed(seed);

  for (int i = 0; i < 60; i++) {
    rings.add(new Ring(random(width), random(height), width*random(0.05, 0.3)));
  }
}

class Ring {
  float x, y, s, r;
  float dir, col;
  float vel, vc, vr;
  Ring(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    r = s*0.5;

    vc = random(1)*random(0.2);
    vel = random(1, 2)*random(0.1, 1);

    dir = random(TWO_PI);
    col = random(colors.length);

    vr = random(0.99, 1);
  }

  void update() {
    dir += random(-0.1, 0.1);
    x += cos(dir)*vel;
    y += sin(dir)*vel;
    col += vc;
    r*=vr;
  }

  void show() {
    int res = 16; 
    float da = TWO_PI/res;
    float gro = 0.7;

    noStroke();
    beginShape(POLYGON);
    fill(getColor(col), 180);
    float amp = 0.3;
    for (int k = 0; k <= res; k++) {
      float ang = da*k;
      PVector n = new PVector(x+cos(ang+da)*r, y+sin(ang+da)*r);
      des(n, 0.2/r, r*0.8);
      PVector p = new PVector(x+cos(ang)*r, y+sin(ang)*r);
      des(p, 0.2/r, r*0.8);
      //if (k == 0 || k == sub) curveVertex(p.x, p.y);
      curveVertex(p.x, p.y);

      float dis = dist(p.x, p.y, n.x, n.y)*amp;
      float angg = atan2(n.y-p.y, n.x-p.x)+HALF_PI*(1-((k%2)*2));
      n.add(p).mult(0.5).add(new PVector(cos(angg)*dis, sin(angg)*dis));
      curveVertex(n.x, n.y);
    }

    beginContour();
    for (int k = 0; k <= res; k++) {
      float ang = TWO_PI-da*k;
      PVector n = new PVector(x+cos(ang-da)*r*gro, y+sin(ang-da)*r*gro);
      des(n, 0.2/r, r*0.8);
      PVector p = new PVector(x+cos(ang)*r*gro, y+sin(ang)*r*gro);
      des(p, 0.2/r, r*0.8);
      curveVertex(p.x, p.y);

      float dis = dist(p.x, p.y, n.x, n.y)*amp;
      float angg = atan2(n.y-p.y, n.x-p.x)+HALF_PI*(1-((k%2)*2));
      n.add(p).mult(0.5).add(new PVector(cos(angg)*dis, sin(angg)*dis));
      curveVertex(n.x, n.y);
    }
    endContour();
    endShape(CLOSE);
  }
}

//https://coolors.co/230d51-95e03a-f9cd04-f2eded-ff82d7
int colors[] = {#050D0f, #222423, #7C5467, #977B76, #BC9BA3, #D5A7A5, #D7BFBA, #EA7900, #E2442C, #CC2148, #9D032E};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}