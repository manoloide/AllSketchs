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
  background(#414127);//#546C57);

  ArrayList<PVector> flowers = new ArrayList<PVector>();

  float detCol = random(0.7, 1)*0.0008;
  float detCol2 = random(0.7, 1)*0.001;
  
  int aux[] = {#979C30, #578574, #458787, #4D6626, #9F860B};
  colors = aux;

  int col = rcol();
  //blendMode(ADD);
  strokeCap(SQUARE);
  for (int i = 0; i < 40000; i++) {
    float yy = height*random(1.2)*random(0.6, 1);
    float val = yy*1./height;
    float xx = width*random(-0.1, 1.1);
    if (random(1) < 0.1) yy = lerp(yy, height*0.5, random(0.4));
    if (random(1) < 0.1) xx = lerp(xx, width*0.5, random(0.4));
    strokeWeight(map(yy, 0, height, 0.8, 1.6)*random(3));
    float ic = noise(xx*detCol*(1-val)*50, yy*detCol)*colors.length+random(0.2);
    //, random(100, 200)*0.3);
    noFill();
    beginShape();
    float des = 0.7+val*0.8;
    des *= 1.4*5;
    float det = random(0.7, 1)*lerp(0.0015, 0.005, val)*1.4;
    det *= 20;
    int seg = 60/5;
    for (int j = 0; j < seg; j++) {
      float v2 = j*1./seg; 
      stroke(getColor(ic+j*0.1+random(2)), 140*v2);
      vertex(xx, yy);
      float ang = PI+noise(xx*det, yy*det, i*0.0000001)*PI;
      xx += cos(ang)*des;
      yy += sin(ang)*des;
      des *= 0.999;
      det *= 1.001;
    }
    endShape();
    if (random(1) < 0.08) flowers.add(new PVector(xx, yy));
  }
  
  int aux2[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
  colors = aux2;

  blendMode(NORMAL);
  for (int i = 0; i < flowers.size(); i++) {
    PVector f = flowers.get(i);
    float val = f.y*1./height;
    float ss = lerp(random(3), random(20), val);
    noStroke();
    float ic = int(random(f.x*detCol2, f.y*detCol2)*colors.length*3);
    for (int j = 0; j < 120; j++) {
      float ang = random(TAU);
      float s = ss*random(0.5)*5;
      float dis = sqrt(random(1))*s*random(0.5);
      s *= random(1);
      fill(getColor(ic+random(2.6)*random(1)), random(100, 300)*0.4);
      ellipse(f.x+cos(ang)*dis, f.y+sin(ang)*dis, s, s);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
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
