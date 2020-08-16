import org.processing.wiki.triangulate.*;

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

  int back = rcol();
  //back = colors[1];

  randomSeed(seed);
  noiseSeed(seed);
  background(back);

  desAng = random(1000);
  detAng = random(0.01);
  desDes = random(1000);
  detDes = random(0.01);

  noiseDetail(2);

  stroke(255, 2);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(1)*random(1)*random(1);
    points.add(new PVector(x, y, s));
    fill(rcol(), random(120, 255));
    circle(x, y, s);
    fill(rcol(), random(120, 255));
    circle(x, y, s*0.9);
    //ellipse(x, y, s, s);
    fill(rcol());
    circle(x, y, s*0.4);
    //ellipse(x, y, s*0.4, s*0.4);
  }


  ArrayList triangles = Triangulate.triangulate(points);

  // draw the mesh of triangles
  stroke(0, 40);
  fill(255, 40);
  //beginShape(TRIANGLES);
  noFill();
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    
    curvi(t.p1.x, t.p1.y, t.p2.x, t.p2.y);
    curvi(t.p2.x, t.p2.y, t.p3.x, t.p3.y);
    curvi(t.p3.x, t.p3.y, t.p1.x, t.p1.y);
    //vertex(t.p1.x, t.p1.y);
    //vertex(t.p2.x, t.p2.y);
    //vertex(t.p3.x, t.p3.y);
  }
  //endShape();
}

void curvi(float x1, float y1, float x2, float y2) {
  int cc = int(max(2, dist(x1, y1, x2, y2)*0.8));
  beginShape();
  int c1 = rcol();
  int c2 = rcol();
  for (int i = 0; i <= cc; i++) {
    float v = map(i, 0, cc, 0, 1);
    float xx = lerp(x1, x2, v);
    float yy = lerp(y1, y2, v);
    PVector p = desform(xx, yy);
    stroke(lerpColor(c1, c2, v), 80);
    vertex(p.x, p.y);
  }
  endShape();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
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

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = noise(desAng+x*detAng, desAng+y*detAng)*TAU*3;
  float des = noise(desDes+x*detDes, desDes+y*detDes)*80; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  int c1 = rcol();
  int c2 = rcol();
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      fill(c1);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(c2);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
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
