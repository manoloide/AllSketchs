import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

// añadir textura serpiente
// deformar la malla

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  background(getColor());

  hint(DISABLE_DEPTH_TEST);
  stroke(255, 20);
  for (int j = 0; j <= height; j+=40) {
    for (int i = 0; i <= width; i+=40) {
      noFill();
      if (random(1) < 0.08) fill(rcol());
      rect(i, j, 40, 40); 
      fill(rcol(), random(255));
      rect(i+19, j+19, 2, 2);
    }
  }

  hint(DISABLE_DEPTH_TEST);
  noStroke();
  for (int i = 0; i < 50; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(120, 240)*random(0.5, 1.8);

    xx -= xx%20;
    yy -= yy%20;

    fill(rcol(), random(20, 180));
    ellipse(xx, yy, ss, ss);
    fill(rcol());
    ellipse(xx, yy, ss*0.2, ss*0.2);
  }

  noStroke();
  for (int i = 0; i < 110; i++) {
    float xx = random(width);
    float yy = random(height);

    float dd = 20;
    float ss = random(12, 20);

    xx -= xx%dd;
    yy -= yy%dd;

    arc2(xx, yy, ss-2, random(ss-2, ss*2), 0, TAU, rcol(), random(0, 50), 0);
    int c1 = rcol();
    ellipse(xx, yy, ss-2, ss-2);
    c1 = rcol();
    ellipse(xx, yy, ss*0.4, ss*0.4);
  }

  float detCol = random(0.0006, 0.001)*4.2;
  float desCol = random(10000);

  for (int i = 0; i < 80; i++) {
    float xx = random(width);
    float yy = random(height);

    xx -= xx%40;
    yy -= yy%40;

    float ss = random(20, random(60, 180)*random(0.5, 1.8))*2.2;
    float ic = noise(desCol+xx*detCol, desCol+yy*detCol)*colors.length;
    float mdc = random(0.3);
    float mdc2 = random(0.05, 0.2);

    int cc = int(random(8, 20));
    float da = TAU/cc;

    int div = int(random(6, 10));//int(random(3, 8));

    //stroke(0, 20);
    noStroke();
    float maxRot = random(0.1, 0.6)*random(1);

    hint(ENABLE_DEPTH_TEST);
    pushMatrix();
    rotateX(HALF_PI*random(-maxRot, maxRot));
    rotateY(HALF_PI*random(-maxRot, maxRot));
    float desZ = random(20, 140);
    for (int k = 0; k < div; k++) {
      pushMatrix();
      translate(xx, yy, desZ+k*8);
      rotateZ(random(TAU));
      float mult = map(k, 0, div, 0.5, 0);
      float amp = random(0.3, random(0.4, 0.6));

      for (int j = 0; j < cc; j++) {
        rotateZ(da);
        pushMatrix();
        rotateX(0.1);
        rotateZ(HALF_PI);
        circle(ss*0.6*mult, 0, ss*mult, ss*amp*mult, getColor(ic+random(mdc)+k*mdc2), getColor(ic+random(mdc)+k*mdc2));
        popMatrix();
      }  
      popMatrix();
    }
    popMatrix();


    hint(DISABLE_DEPTH_MASK);
  }
}

void circle(float x, float y, float w, float h, int c1, int c2) {
  float rw = w*0.5; 
  float rh = h*0.5; 

  int cc = int(w*h*TAU*0.025);
  float da = TAU/cc;
  beginShape();
  for (int i = 0; i < cc; i++) {
    fill(lerpColor(c1, c2, abs(i*2./(cc-1)-1)));
    PVector p = new PVector(x+cos(da*i)*rw, y+sin(da*i)*rh);//desform(x+cos(da*i)*rw, y+sin(da*i)*rh);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void gradient(float x, float y, float w, float h, int c1, float a1, int c2, float a2) {
  float mw = w*0.5; 
  float mh = h*0.5;
  beginShape();
  fill(c1, a1);
  vertex(x-mw, y-mh);
  vertex(x+mw, y-mh);
  fill(c2, a2);
  vertex(x+mw, y+mh);
  vertex(x-mw, y+mh);
  endShape(CLOSE);
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.006, 0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*48; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
