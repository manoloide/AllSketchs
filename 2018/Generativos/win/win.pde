int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
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

void generate() {
  color back = rcol();
  color shaw = lerpColor(back, color(0), 0.05);
  color colo = rcol();
  while (colo == back) colo = rcol();
  background(back);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 200000; i++) {
    float x = random(width); 
    float y = random(height);
    float s = width*random(0.3)*random(1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < (o.z+s)*0.48) {
        add = false;
        break;
      }
    }
    if (add)points.add(new PVector(x, y, s));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x; 
    float y = p.y;
    float s = p.z;
    float dd = s*0.1;
    pushMatrix();
    translate(x-dd, y-dd);
    rotate(random(TWO_PI));
    fill(shaw);
    noStroke();
    float det = random(100);
    noisePoly(0, 0, s, 4, det);
    fill(colo);
    translate(dd, dd);
    noisePoly(0, 0, s, 4, det);
    noisePoly(0, 0, s, 4, det, rgb(), 80, 0);
    popMatrix();
  }
}
color rgb() {
  int r = int(random(2))*255;
  int g = int(random(2))*255;
  int b = int(random(2))*255;
  return color(r, g, b);
}

void noisePoly(float x, float y, float s, int cc, float det) {
  float r = s*0.5;
  float da = TWO_PI/cc;
  float des = s*cc;
  beginShape();
  for (int i = 0; i < cc; i++) {
    float a = da*i;
    float xx = x+cos(a);
    float yy = y+sin(a);
    float rr = (0.2+noise(des+xx*det, des+yy*det)*0.8)*r;
    vertex(xx*rr, yy*rr);
  }
  endShape(CLOSE);
}

void noisePoly(float x, float y, float s, int cc, float det, int col, float alp1, float alp2) {
  float r = s*0.5;
  float da = TWO_PI/cc;
  float des = s*cc;
  beginShape();
  for (int i = 0; i < cc; i++) {
    float a = da*i;
    float xx = x+cos(a);
    float yy = y+sin(a);
    float rr = (0.2+noise(des+xx*det, des+yy*det)*0.8)*r;
    fill(col, alp1);
    if (i >= cc/2.) fill(col, alp2);
    vertex(xx*rr, yy*rr);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#40CECF, #C8C8C0, #EFA5A3, #EF5B48};
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