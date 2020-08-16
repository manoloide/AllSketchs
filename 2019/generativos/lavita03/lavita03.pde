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

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}
class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);


  blendMode(NORMAL);
  //background(getColor());
  background(0);

  blendMode(ADD);
  noFill();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = 400; 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.5, 1)*random(0.01)));
    Rect r = rects.get(ind);

    r.x += random(-10, 10)*random(1);
    r.y += random(-10, 10)*random(1);

    if (random(1) < 0.5) {
      float mw = r.w*random(0.2, 0.8);
      rects.add(new Rect(r.x, r.y, mw, r.h));
      rects.add(new Rect(r.x+mw, r.y, r.w-mw, r.h));
    } else {
      float mh = r.h*random(0.2, 0.8);  
      rects.add(new Rect(r.x, r.y, r.w, mh));
      rects.add(new Rect(r.x, r.y+mh, r.w, r.h-mh));
    }

    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    tel(int(r.x), int(r.y), int(r.x+r.w), int(r.y+r.h));
  }
}


void tel(int x1, int y1, int x2, int y2) {

  randPallets();
  detDef = random(0.0008, 0.001)*0.8;

  float detAng = random(0.001);
  float desAng = random(10000);
  float detAng2 = random(0.001);
  float desAng2 = random(10000);
  float detCol = random(0.0004, 0.0006)*1.4;
  float desCol = random(10000);

  float detLar = random(0.001);
  float desLar = random(0.001);



  float radNoise = random(0.001);
  float detPwrCol = random(0.02);
  for (float j = y1; j < y2; j++) {
    for (float i = x1; i < x2; i++) {
      float x = i;
      float y = j+cos(x*0.2);

      //if(dist(x, y, width*0.5, height*0.5) > width*0.54) continue;


      float nc = noise(desCol+x*detCol, desCol+y*detCol)*colors.length;
      beginShape(LINES);
      float lar = noise(desLar+x*detLar, desLar+y+detLar)*26;
      for (int k = 0; k < lar; k++) {
        float ang = (float) SimplexNoise.noise(detAng+x*desAng, detAng+y*desAng);
        ang += noise(desAng2+x+cos(ang)*radNoise, desAng2+y+radNoise);
        float n2 = (float) SimplexNoise.noise(nc*0.2, k*0.001);
        float pwrCol = noise(x*detPwrCol, y*detPwrCol)*2;

        float grid = ((floor(i*0.05)+floor(j*0.01)+j/100))%colors.length;
        float vc = n2*30+ang*0.5;
        int col = getColor(vc+grid*0, pwrCol);
        stroke(col, 38);

        PVector p = def(x, y);

        vertex(p.x, p.y);
        x += cos(ang);
        y += sin(ang);
      }
      endShape();
    }
  }
} 


float detDef;
PVector def(float x, float y) {
  float ang = (float) SimplexNoise.noise(x*detDef, y*detDef, seed)*TAU*2.2;
  float amp = 20;
  return new PVector(x+cos(ang)*amp, y+sin(ang)*amp);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

void randPallets() {
  int aux[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a};
  colors = aux;

  int aux2[] = new int[int(random(3, 6))];
  for (int i = 0; i < aux2.length; i++) {
    aux2[i] = rcol();
  }
  //colors = aux2;
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#F7DF04, #EAE5E5, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a};
int colors[] = {#A19CA0, #A98D8C, #9E6463, #604242, #000000, #B94C4F, #FAED7D, #7A8AD5};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length), 1);
}
int getColor(float v, float p) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, p));
}
