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
  detAng = random(0.002, 0.01);
  desDes = random(1000);
  detDes = random(0.002, 0.01);

  noiseDetail(2);

  stroke(255, 2);
  noStroke();
  
  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(1)*random(1);
    fill(rcol(), random(120, 255));
    circle(x, y, s);
    fill(rcol());
    circle(x, y, s*0.9);
    //ellipse(x, y, s, s);
    fill(rcol());
    circle(x, y, s*0.4);
    stroke(rcol(), 20);
    aro(x, y, s*0.6, s*0.9);
    //ellipse(x, y, s*0.4, s*0.4);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  int c1 = col;
  int c2 = lerpColor(col, color(255*int(random(2))), 0.1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(c1, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(c2, shd2);
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
  float ang = noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = noise(desDes+x*detDes, desDes+y*detDes)*80; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  int c1 = rcol();
  int c2 = rcol();
  c1 = c2;
  float alp1 = 240;//random(120)*random(1);
  float alp2 = 240;//random(120)*random(1);
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      fill(c1, alp1);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(c2, alp2);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
}

void aro(float x, float y, float s1, float s2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = int(max(8, max(r1, r2)*PI));
  float da = TAU/cc;
  int c1 = rcol();
  int c2 = rcol();
  c1 = c2;
  float alp1 = 240;//random(120)*random(1);
  float alp2 = 240;//random(120)*random(1);
  PVector a1 = new PVector();
  PVector a2 = new PVector();
  PVector c = desform(x, y);
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= cc; i++) {
    a1 = desform(x+cos(da*i)*r1, y+sin(da*i)*r1);
    if (i > 0) {
      fill(c1, alp1);
      vertex(a1.x, a1.y);
      vertex(a2.x, a2.y);
    }
    a2.set(a1);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
//int colors[] = {#F6C9CC, #119489, #7AC3AB, #F47AD4, #6AC8EC, #5BD5D4, #1E4C5B, #CF350A, #F5A71C};
//int colors[] = {#3102F7, #F6C9CC, #F47AD4, #CF350A, #F5A71C};
int colors[] = {#FFF4D4, #FD8BA4, #FF5500, #018CC7, #000000};
//int colors[] = {#FCF0E3, #F3C6BD, #F36B7F, #F8CF61, #3040C4};
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
