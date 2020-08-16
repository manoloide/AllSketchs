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

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
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

class Quad {
  PVector p1, p2, p3, p4;
  Quad(PVector p1, PVector p2, PVector p3, PVector p4) {
    this.p1 = p1; 
    this.p2 = p2; 
    this.p3 = p3; 
    this.p4 = p4;
  }

  void show() {
    int col = rcol();
    float alp1 = random(250);
    float alp2 = random(250);
    float alp3 = random(250);
    float alp4 = random(250);
    if (random(1) < 0.5) {
      alp1 = alp2;
      alp3 = alp4;
    } else {
      alp1 = alp4;
      alp3 = alp2;
    }
    beginShape();
    fill(col, alp1);
    vertex(p1.x, p1.y);
    fill(col, alp2);
    vertex(p2.x, p2.y);
    fill(col, alp3);
    vertex(p3.x, p3.y);
    fill(col, alp4);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
  }
}

PVector[][] vertices;
ArrayList<Quad> quads;



void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(#d1ccc2);


  for (int i = 0; i < 220; i++) {

    float grid = 20*int(random(1, 3));
    float w = width*random(0.01, 0.14);
    float h = height*random(0.1, 0.34);

    w = max(w, 20);
    h = max(h, 20);
    w -= w%grid;
    h -= h%grid;

    float x = random(width-w-grid);  
    float y = random(height-h-grid);

    x -= x%(grid*2);
    y -= y%(grid*2);
    x += grid;
    y += grid;

    int c1 = rcol();
    float a1 = random(200, 250);
    int c2 = rcol();
    float a2 = 0;

    noStroke();
    blendMode(NORMAL);
    shadow(x, y, w, h);
    fill(rcol(), 200);
    rect(x, y, w, h);
    blendMode(ADD);
    grad(x, y, w, h, c1, a1, c2, a2);
  }
}

void shadow(float x1, float y1, float w, float h) {
  int sel = int(random(4));
  float x2 = x1+w; 
  float y2 = y1+h;
  float amp = 2;
  beginShape();
  if (sel == 0) {
    fill(0, 60);
    vertex(x1, y1);
    vertex(x1, y2);
    fill(0, 0);
    vertex(x1-w*amp, y2);
    vertex(x1-w*amp, y1);
  } else if (sel == 1) {
    fill(0, 60);
    vertex(x2, y1);
    vertex(x2, y2);
    fill(0, 0);
    vertex(x2+w*amp, y2);
    vertex(x2+w*amp, y1);
  }
  if (sel == 2) {
    fill(0, 60);
    vertex(x1, y1);
    vertex(x2, y1);
    fill(0, 0);
    vertex(x2, y1-h*amp);
    vertex(x1, y1-h*amp);
  } else if (sel == 3) {
    fill(0, 60);
    vertex(x1, y2);
    vertex(x2, y2);
    fill(0, 0);
    vertex(x2, y2+h*amp);
    vertex(x1, y2+h*amp);
  }
  endShape();
}

void grad(float x, float y, float w, float h, int col1, float alp1, int col2, float alp2) {

  int val = int(random(4));

  beginShape();
  fill(col1, alp1);
  if (val != 0) vertex(x, y);
  if (val != 1) vertex(x+w, y);
  fill(col2, alp2);
  if (val != 2) vertex(x+w, y+h);
  if (val != 3) vertex(x, y+h);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
int colors[] = {#240118, #6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
