import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;


// añadir data viz puntos grilla
// aadir coneixones meido arboles a la grilla de putnos
// mejorar arboles
// añadir molinos electrnicos

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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  scale(scale);

  float zooom = 1;
  float zx = 0.5;
  float zy = 0.5;
  //pushMatrix();
  translate(+width*zx, +height*zy);
  scale(zooom);
  translate(-width*zx, -height*zy);
  //popMatrix();

  //background(rcol());

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(5, 5, width-10));

  int sub = int(random(10, 20));
  noStroke();
  noFill();
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));

    rects.remove(ind);
  }

  skys();

  gridBack(rects);
  sun(rects);
  miniCity();

  pasto();
  campo();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int res = int(max(2, (r1*r2)*PI*0.2));
  float da = (a2-a1)/res;
  //col = rcol();
  beginShape(QUAD_STRIP);
  for (int i = 0; i < res; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(col, alp2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a}; 

//https://coolors.co/ff8eff-f7f718-92ccbc-0c0002-1544a3
//int colors[];
int colors1[] = {#ff8eff, #f7f718, #92ccbc, #0c0002, #1544a3};
int colors2[] = {#060B06, #0806A8, #8ABCF9, #FBDADE, #FF2705};
int colors3[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a};

void randPallet() {
  int rnd = int(random(3));
  if (rnd == 0) colors =  colors1;
  if (rnd == 1) colors =  colors2;
  if (rnd == 2) colors =  colors3;
}

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
  return lerpColor(c1, c2, pow(v%1, 3));
}
