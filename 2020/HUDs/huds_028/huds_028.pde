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
  blendMode(NORMAL);
  background(0);

  int grid = 20;

  noStroke();
  rectGrad(grid, grid, width-grid*2, height-grid*2);

  int cw = int(width/grid);
  int ch = int(height/grid);

  blendMode(ADD);
  stroke(255, 120);
  for (int j = 1; j < ch; j++) {
    for (int i = 1; i < cw; i++) {
      strokeWeight(random(3));
      point(i*grid, j*grid);
    }
  }

  noStroke();
  for (int i = 0; i < cw*ch*0.1; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%grid;
    yy -= yy%grid;
    float ss = grid*int(random(1, random(1, 7)));
    fill(rcol());
    ellipse(xx, yy, ss, ss);
  }

  copy(0, 0, width, height, 0, 0, width, height);
}

void rectGrad(float x, float y, float w, float h) {
  float cx = x+w*0.5;
  float cy = y+h*0.5;

  int c1 = color(#2C102A);
  int c2 = color(#3E3378);

  float alp1 = 120;
  float alp2 = 60;

  beginShape();
  fill(c1, alp1);
  vertex(x, y);
  vertex(x+w, y);
  fill(c2, alp2);
  vertex(cx, cy);

  fill(c1, alp1);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(c2, alp2);
  vertex(cx, cy);

  fill(c1, alp1);
  vertex(x, y+h);
  vertex(x+w, y+h);
  fill(c2, alp2);
  vertex(cx, cy);

  fill(c1, alp1);
  vertex(x, y);
  vertex(x, y+h);
  fill(c2, alp2);
  vertex(cx, cy);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#A06CA9, #A86679, #63A6A0, #8093D3, #193FD4};
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
