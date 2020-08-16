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

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  //background(#7F7F7F);
  //background(255);
  background(0);

  float det1 = random(0.002, 0.003)*1.8;
  float det2 = random(0.002, 0.003)*0.6;

  blendMode(ADD);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 40000; i++) {
    float x = random(width);
    float y = random(height);
    float noi = pow((float) SimplexNoise.noise(x*det1, y*det1, seed*0.01)*0.5+0.5, 1.9)*random(0.8, 1);
    noi = cos(noi*TAU*4);
    noi = abs(noi)%1;
    float noi2 = pow((float) SimplexNoise.noise(x*det2, y*det2, seed*0.01)*0.5+0.5, 1.6)*random(0.8, 1);
    float s = width*map(noi*noi2, 0, 1, 0.002, 0.09);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < (s+o.z)*0.2) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }


  float detRotX = random(0.002, 0.003)*0.2;
  float detRotY = random(0.002, 0.003);

  float detCol = random(0.005, 0.01)*0.1;
  float detLig = random(0.005, 0.01)*5.2;

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float ncol = sqrt(p.z)*0.3+noise(p.x*detCol, p.y*detCol)*colors.length;
    int col = getColor(ncol*2);
    float light = lerp(20, 200, noise(p.x*detLig, p.y*detLig))*0.8;
    fill(col, light);
    pushMatrix();
    translate(p.x, p.y);
    float rotx = noise(p.x*detRotX, p.y*detRotX)*TAU*5;
    float roty = noise(p.x*detRotY, p.y*detRotY)*TAU*5;
    rotate(rotx);
    rotateY(noise(p.x*detRotY, p.y*detRotY)*TAU*5);
    float ww = p.z*2;
    float hh = p.z*cos(roty);
    ellipse(0, 0, ww*1.25, hh*0.3);
    ellipse(0, 0, ww*0.25, hh*0.3);
    if (random(1) < 0.1) fill(rcol(), light);
    ellipse(0, 0, ww*0.27, hh*0.35);
    popMatrix();
  }
  /*
  ArrayList<PVector> pts = new ArrayList<PVector>();
   noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   p.z *= 1.2;
   pts.add(new PVector(p.x-p.z*0.5, p.y-p.z*0.5));
   pts.add(new PVector(p.x-p.z*0.5, p.y+p.z*0.5));
   pts.add(new PVector(p.x+p.z*0.5, p.y+p.z*0.5));
   pts.add(new PVector(p.x+p.z*0.5, p.y-p.z*0.5));
   pts.add(new PVector(p.x, p.y-p.z*0.8));
   }
   
   
   for (int i = 0; i < points.size(); i++) {
   if (random(1) < 0.5) continue;
   int ind = i*5;
   int c1 = rcol();
   int c2 = rcol();
   beginShape();
   for (int j = 0; j < 5; j++) {
   PVector p = pts.get(ind+j);
   fill((random(1) < 0.5)? c1 : c2, random(255));
   vertex(p.x, p.y);
   }
   endShape(CLOSE);
   }
   */
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
