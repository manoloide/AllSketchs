import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  //background(lerpColor(rcol(), color(0), random(0.9, 1)*0.8  ));
  background(240);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(20, 80));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.z, r.z);
    circle(r.x+r.z*0.5, r.y+r.z*0.5, r.z);
    circle(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.2);
  }
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  noStroke();
  fill(0, 60);
  ellipse(x+2, y+2, s, s);
  fill(rcol());
  ellipse(x, y, s, s);

  int cc = int(r*r*PI*random(1, 5));
  if (random(1) < 0.5) blendMode(ADD);
  else blendMode(NORMAL);

  beginShape(POINTS);
  for (int j = 0; j < cc; j++) {
    float ang = random(TAU);
    float dis = random(random(0.5, 0.98));
    stroke(rcol(), 80);
    vertex(x+cos(ang)*dis*r, y+sin(ang)*dis*r);
  }
  endShape();

  beginShape(POINTS);
  for (int j = 0; j < cc*0.4; j++) {
    float ang = random(TAU);
    float dis = random(1, random(1, 1.4));
    stroke(rcol(), 80);
    vertex(x+cos(ang)*dis*r, y+sin(ang)*dis*r);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

int colors[] = {#FFA9E7, #FF84E8, #7F2CCB, #414361, #2A2D43};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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
  return lerpColor(c1, c2, pow(v%1, 3.8));
}
