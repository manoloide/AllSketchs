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
    float det = random(100);
    int c1 = rcol();
    int c2 = rcol();
    while (c1 == c2) c2 = rcol();
    fill(shaw, 120);
    noStroke();
    ellipse(0, 0, s, s);
    translate(dd, dd);
    fill(c1);
    ellipse(0, 0, s, s);
    c1 = lerpColor(c1, color(0, 5, 10), 0.05);
    for (int j = 0; j < 100; j++) {
      float ang = random(TWO_PI);
      float ss = s*random(0.08, 0.12);
      float des = acos(random(PI))*(s-ss)*0.33;
      fill(c1);
      ellipse(cos(ang)*des-ss*0.03, sin(ang)*des-ss*0.03, ss, ss);
      fill(c2);
      ellipse(cos(ang)*des, sin(ang)*des, ss, ss);
    }
    popMatrix();
  }
}
color rgb() {
  int r = int(random(2))*255;
  int g = int(random(2))*255;
  int b = int(random(2))*255;
  return color(r, g, b);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#434E20, #E8AF36, #F56546, #446E9A, #F6EDDD};
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