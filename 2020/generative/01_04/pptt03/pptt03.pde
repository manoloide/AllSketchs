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
  background(255);

  int cc = int(random(20, 40))*5;
  float ss = width*(1./cc);

  osc1 = int(random(10, 40)*random(1));
  osc2 = int(random(10, 60));
  amp = random(20, 80)*0.4;
  
  rot = random(10)*random(0.4, 1);

  noStroke();
  fill(0);
  for (int i = -40; i <= cc+40; i+=1) {
    beginShape(QUAD_STRIP);
    for (float j = -200; j <= height+200; j+=0.5) {
      fill(getColor(i+40+(j*5./height)));
      PVector p1 = def(i*ss, j);
      PVector p2 = def((i+1)*ss, j);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
    }
    endShape();
  }
}

float osc1, osc2, amp, rot;
PVector def(float x, float y) {

  float cx = width*0.5;
  float cy = height*0.5;
  float maxDist = width*0.4;
  float dist = dist(x, y, cx, cy);
  float ang = atan2(y-cy, x-cy);
  
  if (dist < maxDist) {
    float v1 = dist/maxDist;
    float v2 = 1-v1;
    float nx = cx+cos(ang+PI*v2*rot)*dist*v1*v1;
    float ny = cy+sin(ang-PI*v2*rot)*dist*v1*v1;
    
    x = lerp(x, nx, v2);
    y = lerp(y, ny, v2);
  }

  float vx = (y*1./width)*TAU*osc1;
  float vy = (x*1./height)*TAU*osc2;
  return new PVector(x+cos(vx)*amp, y+sin(vy)*amp);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #82023B};
//int colors[] = {#FFFFFF, #000000};//, #02B59E, #DCE404, #82023B};
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
