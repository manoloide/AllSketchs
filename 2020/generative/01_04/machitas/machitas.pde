import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brushes[];
PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  
  brushes = new PImage[4];
  for(int i = 0; i < 4; i++){
    brushes[i] = loadImage("brush/brush0"+str(i+1)+".png");
  }

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
  
  float detAng = random(0.0001);
  float desAng = random(10000);
  
  
  float detCol = random(0.001);
  float desCol = random(10000);
  
  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  
  //blendMode(ADD);
  for(int i = 0; i < 2000; i++){
     float xx = random(width);
     float yy = random(height);
     float ww = random(4, 12)*random(1);
     float hh = random(20)*random(1);
     hh = ww*random(0.1, 0.3);
     
     //int col = getCol(xx, yy);
     int col = getColor(noise(desCol+xx*detCol, desCol+yy*detCol)*colors.length*2);
     col = lerpColor(col, color(255), random(0.5, 1));
     float brig = brightness(col)/255.;
     tint(col, random(255)*random(1));
     pushMatrix();
     translate(xx+random(-2, 2), yy+random(-2, 2));
     rotate(noise(desAng+xx*detAng, desAng+yy*detAng)*TAU*10+brig*8);
     //rect(0, 0, ww, hh);
     float sca = 2+brig+random(2);
     sca *= 16;
     image(brushes[int(random(4))], 0, 0, ww*sca, hh*sca);
     popMatrix();
  }
}

color getCol(float x, float y){
  int xx = int(map(x, 0, width, 0, img.width));
  int yy = int(map(y, 0, height, 0, img.height));
  return img.get(xx, yy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#5BBAEA, #019075, #9697A9, #F31676, #F10246};
int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#0A0B0B, #2E361E, #ACB2A4, #B66F3A, #B91A1B};
//int colors[] = {#B85807, #FAC440, #F4C8BF, #A0B9A6, #A1B2EA};
//int colors[] = {#B2734B, #A69050, #897E6A, #5B6066, #292E31};
//int colors[] = {#FCB375, #FEAE02, #FED400, #F0EBBE, #B0DECE, #01B6D2, #18AD92, #90BC96};
//int colors[] = {#F3CD18, #C64F6B, #954670, #402047, #0E060B, #73321D};
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
