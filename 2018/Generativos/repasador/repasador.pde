import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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
  detAng = random(0.002, 0.01)*0.05;
  desDes = random(1000);
  detDes = random(0.002, 0.01)*0.2;

  noiseDetail(2);

  int cc = int(random(300, 360)*0.3);
  float bb = 20;
  float ss = (width-bb*2.)/cc;

  strokeWeight(5);
  stroke(255, 20);
  float ic = random(1);
  float dc = random(0.05)*random(1);
  noFill();
  for (int j = 0; j <= cc; j++) {
    stroke(getColor(ic+dc*j), 240);
    nline(bb, bb+j*ss, width-bb, bb+j*ss);
  }

  strokeWeight(2);
  for (int j = 0; j <= cc; j++) {
    stroke(getColor(ic+dc*j), 240);
    nline(bb+j*ss, bb, bb+j*ss, height-bb);
  }
  
  noStroke();
  for(int i = 0; i < 10; i++){
    fill(rcol());
     circle(width*random(0.25, 0.75), height*random(0.25, 0.75), width*random(0.05, 0.5)); 
  }
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
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

int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
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
