import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 404532;//int(random(999999));

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

  generate();
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
  //background(252, 250, 245);
  background(255);

  float ss = width*0.24;
  int cols[] = {#E86710, #4131FF, #657451};




  stroke(255, 0, 0, 180);
  noFill();
  for (int i = 0; i < 30; i++) {
    float v = i*(1./(30-1));
    float x1 = width*(lerp(0.38+0.003, 0.62-0.003, v)); 
    float x2 = width*lerp(0, 1, v); 
    //line(x1, height*0.25, x2, height);
    float cx = (x1+x2)*0.5;
    strokeWeight(pow((1-sin(v*PI)), 0.6)*5);
    beginShape();
    curveVertex(x1, height*0.0);
    curveVertex(x1, height*0.25);
    curveVertex(x1, height*0.6);
    curveVertex(cx, height*0.8);
    curveVertex(x2, height);
    curveVertex(x2, height);
    endShape();
    //curve(x1-200, 0, x1, height*0.25, x2, height, x2+200, height*1.5);
  }


  noStroke();
  fill(0);
  int cc = int(random(1000, 4000));
  for (int i = 0; i < cc; i++) {
    float vy = pow(i*(1.0/cc), 0.4);
    float x = random(width);
    float y = height*lerp(0.5, 1, vy);
    float s = 18*(0.2+vy);
    //ellipse(x, y, s, s);
    person(x, y, s, cols[int(random(cols.length))]);
  }


  noFill();
  stroke(0);//0, 255, 0);
  for (int i = 0; i < 30; i++) {
    float v = i*(0.04);
    float xx = width*0.5;
    float yy = height*0.25;
    float s = width*lerp(0.2, 1.6, pow(v, 2));
    strokeWeight(0.5+pow(v, 1.4)*3);
    ellipse(xx, yy, s, s);
  }

  noStroke();
  fill(0);
  ellipse(width*0.5, height*0.25, ss, ss);
  fill(255);
  ellipse(width*0.5, height*0.25, ss*0.02, ss*0.02);

  person(width*0.35, height*0.6, height*0.3, cols[0]);
  person(width*0.5, height*0.6, height*0.32, cols[1]);
  person(width*0.65, height*0.6, height*0.29, cols[2]);
}

void person(float x, float y, float s, int col) {
  fill(col);
  ellipse(x, y-s*0.75, s*0.3, s*0.3);
  ellipse(x, y-s*0.65, s*0.2, s*0.44);


  fill(0);
  ellipse(x-s*0.05, y-s*0.25, s*0.16*0.3, s*0.5);
  ellipse(x+s*0.05, y-s*0.25, s*0.16*0.3, s*0.5);


  float head = s*(1.0/7.0);
  fill(255);
  ellipse(x, y-s+head*0.5, head, head);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
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
