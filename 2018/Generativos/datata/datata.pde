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
  background(rcol());

  noStroke();
  float ss = width*random(0.56, 0.65);
  float cx = width*0.5; 
  float cy = height*0.5; 

  arc2(cx, cy, ss, ss*1.2, 0, TWO_PI, 0, 30, 0);
  fill(rcol());
  ellipse(cx, cy, ss, ss);

  ArrayList<PVector> points = new ArrayList<PVector>();
  float r = ss*0.5;
  int cc = int(PI*r*r*2*random(0.00001, 0.001));
  for (int i = 0; i < cc; i++) {
    float s = random(2, 10);
    float rr = r-s*0.5;
    rr = sqrt(random(rr*rr));
    float a = random(TWO_PI);
    float x = cx+cos(a)*rr;
    float y = cy+sin(a)*rr;
    points.add(new PVector(x, y, s));
  }

  Triangulator triangulator = new Triangulator();
  ArrayList<Triangle> tris = triangulator.triangulate(points.toArray(new PVector[points.size()]));
  println(tris.size());
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    if (dist(cx, cy, t.p1.x, t.p1.y) > ss*0.5) continue;
    fill(rcol());
    triangle(t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y);

    beginShape();
    fill(0, 0);
    vertex(t.p1.x, t.p1.y);
    fill(0, 10);
    vertex(t.p2.x, t.p2.y);
    fill(0, 50);
    vertex(t.p3.x, t.p3.y);
    endShape(CLOSE);
  }

  /*
  for (int i = 0; i < cc; i++) {
   PVector p = points.get(i);
   float x = p.x; 
   float y = p.y;
   float s = p.z;
   float a = atan2(y-cy, x-cx);
   int col = rcol();
   float x1 = cx+cos(a)*width*0.5;
   float y1 = cy+sin(a)*height*0.5;
   
   
   arc2(x, y, s, s*1.8, 0, TWO_PI, 0, 20, 0);
   stroke(0, 10);
   line(x+1, y+1, x1+1, y1+1);
   stroke(col);
   line(x, y, x1, y1);
   noStroke();
   fill(col);
   ellipse(x, y, s, s);
   }
   */
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#121435, #FAF9F0, #EDEBCA, #FF5722};
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