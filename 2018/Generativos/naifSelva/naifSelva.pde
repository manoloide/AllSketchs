int seed = int(random(999999));
ArrayList<PVector> points;
ArrayList<Triangle> tris;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  background(250);

  randomSeed(seed);

  noStroke();
  if (tris != null) {
    PVector p1, p2, p3, c1, c2, c3, i1, i2, i3, cen;
    float amp1 = random(1)*random(1);
    float amp2 = random(1)*random(1);//0.01;
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;
      cen = p1.copy().add(p2).add(p3).div(3);
      i1 = PVector.lerp(p1, cen, amp1);
      i2 = PVector.lerp(p2, cen, amp1);
      i3 = PVector.lerp(p3, cen, amp1);
      c1 = p1.copy().add(p2).div(2).lerp(cen, amp2);
      c2 = p2.copy().add(p3).div(2).lerp(cen, amp2);
      c3 = p3.copy().add(p1).div(2).lerp(cen, amp2);

      beginShape();
      fill(rcol());
      vertex(p1.x, p1.y);
      fill(rcol());
      vertex(p2.x, p2.y);
      fill(rcol());
      vertex(p3.x, p3.y);
      endShape(CLOSE);

      fill(0);
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      vertex(p1.x, p1.y);
      vertex(c3.x, c3.y);
      vertex(i3.x, i3.y);
      vertex(c2.x, c2.y);
      vertex(i2.x, i2.y);
      vertex(c1.x, c1.y);
      vertex(i1.x, i1.y);
      vertex(c3.x, c3.y);
      vertex(p1.x, p1.y);
      vertex(c3.x, c3.y);
      endShape(CLOSE);
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void mousePressed() {
  addPoint(mouseX, mouseY);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void addPoint(float nx, float ny) {
  points.add(new PVector(nx, ny));
  Triangulator triangulator = new Triangulator();
  tris = triangulator.triangulate(points.toArray(new PVector[points.size()]));
}

void generate() {

  seed = int(random(999999));

  points = new ArrayList<PVector>();

  float bb = 100;
  int cc = int(random(400, 1000));
  for (int i = 0; i < cc; i++) {
    addPoint(random(-bb, width+bb), random(-bb, height+bb));
  }
}


int colors[] = {#FAA270, #B5CA53, #FE8AB4, #24ACCE, #B5140B, #B083A8, #167E68,#015928, #35B77D, #003172, #E87823, #D8B04A, #001C77, #001C77};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}