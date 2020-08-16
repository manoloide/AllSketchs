int seed = int(random(999999));
PFont chivo;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  chivo = createFont("Chivo", 10, true);

  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

ArrayList<Atractor> pointers;

class Atractor {
  float x, y, s, p; 
  Atractor(float x, float y, float s, float p) {
    this.x = x; 
    this.y = y; 
    this.s = s; 
    this.p = p;
  }
}


void generate() {
  //background(5);
  background(#1C1528);

  blendMode(ADD);

  int cc = int(random(30, 80));
  float s = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      stroke(rcol(), 50);
      point((i+0.5)*s, (j+0.5)*s);
    }
  }

  int res = width*3;

  noFill();

  pointers = new ArrayList<Atractor>();
  int c = int(random(4, 10));
  for (int i = 0; i < c; i++) {
    float ss = width*random(0.8);
    float xx = random(ss*0.5, width-ss*0.5);
    float yy = random(ss*0.5, height-ss*0.5);
    float pp = (random(1) < 0.5)? random(1, 10) : 1./random(1, 10);
    pointers.add(new Atractor(xx, yy, ss, pp));
  }


  noFill();
  for (int i = 0; i < pointers.size(); i++) {
    Atractor p = pointers.get(i);
    stroke(rcol(), 20);
    ellipse(p.x, p.y, p.s, p.s);
  }


  for (int i = 1; i < cc; i++) {
    float xx = map(i, 0, cc, 0, width);
    stroke(rcol(), 40);
    beginShape();
    for (int k = 0; k < res; k++) {
      float yy = map(k, 0, res, 0, height);
      PVector p = def(xx, yy);
      vertex(p.x, p.y);
    }
    endShape();
  }

  for (int i = 1; i < cc; i++) {
    float yy = map(i, 0, cc, 0, height);
    stroke(rcol(), 40);
    beginShape();
    for (int k = 0; k < res; k++) {
      float xx = map(k, 0, res, 0, width);
      PVector p = def(xx, yy);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

PVector def(float x, float y) {
  float dx = 0; 
  float dy = 0;
  for (int i = 0; i < pointers.size(); i++) {
    Atractor p = pointers.get(i);
    float dis = dist(x, y, p.x, p.y);
    float r = p.s*0.5;
    if (dis < r) {
      float v = (1-pow(map(dis, 0, r, 0, 1), p.p))*r;
      float ang = atan2(p.y-y, p.x-x);
      dx += cos(ang)*v;
      dy += sin(ang)*v;
    }
  }
  return new PVector(x+dx, y+dy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF5949, #FFC956, #1CEA64, #53EFF4};
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
  return lerpColor(c1, c2, v%1);
}