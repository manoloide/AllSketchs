import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage sprites;
PImage sprite[][];
PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  sprites = loadImage("sprites.png");
  sprite = cutSprites(128, 128, sprites);

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

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(10);

  scale(scale);

  rectMode(CENTER);
  imageMode(CENTER);

  float detCol = random(0.01, 0.005)*0.2;

  //blendMode(ADD);
  noStroke();
  for (int i = 0; i < 100000; i++) {
    float x = random(swidth)*random(0.8, 1.1);
    float y = random(sheight)*random(1.1);
    int col = getColor(noise(x*detCol, y*detCol)*water.length*2+random(1), water);
    fill(col, 40);
    ellipse(x, y, 40, 40);
    //tint(col, 40);
    //image(sprite[int(random(4))] [int(random(4))], x, y, 80, 80);
  }
  blendMode(NORMAL);

  /*
  noStroke();
   for (int i = 0; i < 100; i++) {
   float vx = random(1)*random(0.8, 1.1);
   float vy = random(0.5, 1)*random(1.1);
   float x = swidth*vx;
   float y = sheight*vy;
   float ww = 100*lerp(0.3, 1, vy)*lerp(0.8, 1, vx); 
   float hh = 40*lerp(0.1, 1, vy);
   float valCol = noise(x/vx*detCol*10, y*detCol*10)*flowers.length*2+random(1);
   for (int k = 0; k < 10; k++) { 
   float v = 1-(k+1.)/10.0;
   int col = getColor(valCol+v*random(3), flowers);
   fill(col, 240);
   pushMatrix();
   translate(x, y);
   rotate(PI*random(-0.4, 0.4)*(1-v));
   ellipse(0, 0, ww*v, hh*v);
   popMatrix();
   }
   }
   */

  /*
  fill(rcol(petalos), 180);
   rect(0, sheight*0.72, swidth, sheight*0.28);
   
   
   fill(rcol(petalos), 180);
   rect(swidth*0.55, sheight*0.5, swidth*0.2, sheight*0.3);
   */

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  for (int i = 0; i < 100; i++) {
    float xx = lerp(random(0.1, 0.9), 0.7, random(0.4))*swidth;
    float yy = sheight*lerp(random(0.15, 0.65), 0.3, random(0.5));
    float ss = random(100, 200)*random(0.4, 1);
    points.add(new PVector(xx, yy, ss));
  }

  float cx = width*0.55;
  float cy = height*0.9;


  //connects(points);

  noFill();
  for (int i = 0; i < points.size(); i++) {
    if(random(1) < 0.9) continue;
    PVector p = points.get(i);
    strokeWeight(random(1, 4));
    curve(cx+random(-100, 100), cy+random(-200, 200), cx, cy, p.x, p.y, p.x+random(-100, 100), p.y-random(400, 700));
  }


  noStroke();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float r = p.z*0.5;
    float ic = int(random(petalos.length));
    //ellipse(xx, yy, ss, ss);
    int cc = int(PI*r*r*0.5);
    for (int k = 0; k < cc; k++) {
      float a = random(TAU);
      float d = random(r)*random(0.6, 1);
      float s = p.z*random(0.02, 0.05);
      float x = p.x+cos(a)*d*1.1;
      float y = p.y+sin(a)*d;
      float nc = noise(x*0.03, y*0.03)*2;
      float alp = random(160, 255);
      tint(getColor(nc+ic+random(1)*random(1), petalos), alp);
      pushMatrix();
      translate(x, y);
      rotate(random(TAU));
      //rect(0, 0, s, s);

      image(sprite[int(random(4))] [int(random(4))], 0, 0, s*4, s*4);
      popMatrix();
    }
  }
}

void connects(ArrayList<PVector> points) {
  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < points.size(); i++) {
    unreached.add(points.get(i));
  }

  if (unreached.size() > 0) {
    int ind = int(random(unreached.size()));
    reached.add(unreached.get(ind));
    unreached.remove(ind);
  }


  while (unreached.size() > 0) {
    float record = 10000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      PVector v1 = reached.get(i);
      for (int j = 0; j < unreached.size(); j++) {
        PVector v2 = unreached.get(j);
        if (abs(v2.x-v1.x) > record || abs(v2.y-v1.y) > record) {
          continue;
        }
        float d = v1.dist(v2);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }

    stroke(0);
    strokeWeight(4);
    line(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);

    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#A5D0A8, #8CADA7, #110B11, #B7990D, #F2F4CB};
//int colors[] = {#02AAE0, #F47EF3, #0ABB8B, #F6DE21, #F63528, #000000, #ffffff};
int petalos[] = {#FBFEF9, #EBCDE3, #BC3B4E, #A667A7, #8584C3, #905DA7, #52519A, #180F1D};
//int petalos[] = {#FBB362, #CC4C0A, #CB2D0A, #7D2C1D, #4E201C};
int water[] = {#BB9987, #A098A9, #96802C, #617E7B, #383413, #101E16};
int flowers[] = {#E5C663, #FBF8BF, #DBA937, #AF4936, #F07B42, #F0CDB9};

//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
int rcol(int[] colors) {
  return colors[int(random(colors.length))];
}

int getColor(int[] colors) {
  return getColor(random(colors.length), colors);
}

int getColor(float v, int[] colors) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 0.5));
}

PImage[][] cutSprites(int sw, int sh, PImage aux) {
  int cx = aux.width/sw;
  int cy = aux.height/sw;
  PImage res[][] = new PImage[cx][cy];
  for (int j = 0; j < cy; j++) {
    for (int i = 0; i < cx; i++) {
      res[i][j] = createImage(sw, sh, ARGB);
      res[i][j].copy(aux, i*sw, j*sh, sw, sh, 0, 0, sw, sh);
    }
  }
  return res;
}
