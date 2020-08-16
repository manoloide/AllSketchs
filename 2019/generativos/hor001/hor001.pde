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
  size(int(swidth*scale), int(sheight*scale), P3D);
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

  background(lerpColor(rcol(), color(0), random(0.9, 1)));

  for (int i = 0; i < 10; i++) {
    float x = random(width); 
    float y = height*random(0.2);
    float s = random(200)*random(1);
    noStroke(); 
    fill(rcol(), 40);
    ellipse(x, y, s, s);
  }  


  noStroke();
  beginShape();
  fill(rcol(), 20);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 20);
  vertex(width, height*0.2);
  vertex(0, height*0.2);
  endShape();

  ArrayList<PVector> pts = new ArrayList<PVector>();

  noStroke();
  stroke(255, 180);
  for (int i = 0; i < 10000; i++) {
    float val = random(0.2, random(random(0.2), random(0.4, 1.2)));
    float x = random(width);
    float y = height*val;
    float s = random(8, 10)*5;
    //fill(rcol());
    //ellipse(x, y, 2, 2);
    float y2 = y-s*(val-0.18);
    line(x, y, x, y2);
    ellipse(x, y2, 4*val, 4*val);
    pts.add(new PVector(x, y2));
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(pts);
  beginShape(TRIANGLES);
  noFill();
  for (int i = 0; i < tris.size(); i++) {
    if (random(1) < 0.9) continue;
    fill(rcol());
    Triangle t = tris.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
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

int colors[] = {#F71630, #3A6B58, #82B754, #E8DD4C, #CE7B0E};
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
