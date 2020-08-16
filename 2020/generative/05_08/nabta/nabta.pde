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
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  
  float detSize = random(0.008);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 10000; i++) {
    float x = random(width)*random(1);
    float y = random(height)*random(1);
    float s = noise(x*detSize, y*detSize)*2;
    float g = pow(2, int(random(1, 5)));
    x -= x%g;
    y -= y%g;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x-10, other.y-10) < 40*s) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x+10, y+10, s));
  }

  float det = random(0.01);
  noStroke();
  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = triangles.get(i);
    fill(getColor(noise(t.p1.x*det, t.p1.y*det)*6));
    vertex(t.p1.x, t.p1.y); 
    fill(getColor(noise(t.p2.x*det, t.p2.y*det)*6));
    vertex(t.p2.x, t.p2.y); 
    fill(getColor(noise(t.p3.x*det, t.p3.y*det)*6));
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#EDF67D, #F896D8, #CA7DF9, #724CF9, #564592};
//int colors[] = {#BF052A, #DBB304, #E1E7ED, #04140C};
int colors[] = {#057EBF, #DBB304, #E1E7ED, #04140C};
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
  return lerpColor(c1, c2, pow(v%1, 0.4));
} 
