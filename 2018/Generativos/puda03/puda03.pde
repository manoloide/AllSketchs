import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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
  
  blendMode(ADD);


  randomSeed(seed);
  noiseSeed(seed);
  background(#010101);

  desAng = random(1000);
  detAng = random(0.002, 0.01)*0.1;
  desDes = random(1000);
  detDes = random(0.002, 0.01)*0.2;

  noiseDetail(2);



  int cc = int(random(300, 360));
  float bb = 20;
  float ss = (width-bb*2.)/cc;
  
  strokeWeight(1.4);
  stroke(255, 20);
  float ic = random(1);
  float dc = random(0.002)*random(1);
  noFill();
  for (int j = 0; j < cc; j++) {
    fill(getColor(ic+dc*j), 80);
    nline(bb, bb+j*ss, width-bb, bb+j*ss);
  }
}

void nline(float x1, float y1, float x2, float y2) {
  int cc = int(dist(x1, y1, x2, y2));
  beginShape();
  for (int i = 0; i < cc; i++) {
    float v = map(i, 0, cc-1, 0, 1);
    PVector p = desform(lerp(x1, x2, v), lerp(y1, y2, v));
    vertex(p.x, p.y);
  }
  endShape();
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*3;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*30; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FEAFCC, #70A7FB, #010101, #BE0117, #007ECB, #BE0117};
int colors[] = {#FFFFFF, #D9D9E5, #FFCC01, #FF598D, #FEAFCC, #BE0117, #2A1B52};
//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
//int colors[] = {#F6C9CC, #119489, #7AC3AB, #F47AD4, #6AC8EC, #5BD5D4, #1E4C5B, #CF350A, #F5A71C};
//int colors[] = {#3102F7, #F6C9CC, #F47AD4, #CF350A, #F5A71C};
//int colors[] = {#FFF4D4, #FD8BA4, #FF5500, #018CC7, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000};
//int colors[] = {#FCF0E3, #F3C6BD, #F36B7F, #F8CF61, #3040C4};
//int colors[] = {#FFFFFF, #FFFFFF, #000000, #000000, #000000, #000000, #000000, #000000, #FFFFFF, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
