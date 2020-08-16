import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  if (frameCount%120 == 0) {
    seed = int(random(999999));
    //generate();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  //blendMode(ADD);

  randomSeed(seed);
  noiseSeed(seed);

  background(240);
  
  float des = random(1000);
  float det = random(0.001);

  int grid = 80;
  int cc = int(width*1./grid);
  noFill();
  stroke(230);
  for (int j = 1; j < cc-1; j++) {
    for (int i = 1; i < cc-1; i++) {
      noFill();
      float x = i*grid;
      float y = j*grid;
      rect(x, y, grid, grid);
      fill(rcol());
      float noi = noise(des+x*det, des+y*det);
      ellipse((i+0.5)*grid, (j+0.5)*grid, grid*0.1*noi, grid*0.1*noi);
    }
  }

  noStroke();
  for (int i = 0; i < cc; i++) {

    int ww = int(random(1, cc*0.5));
    int hh = int(random(1, cc*0.5));

    int xx = int(random(1, cc-ww));
    int yy = int(random(1, cc-hh));

    int c1 = rcol();
    int c2 = rcol();
    float a1 = random(255)*random(1);
    float a2 = random(255)*random(1);
    boolean altCol = (random(1) < 0.5);

    beginShape();
    fill(c1, a1);
    vertex(xx*grid, yy*grid);
    if (altCol) fill(c2, a2);
    vertex((xx+ww)*grid, yy*grid);
    fill(c2, a2);
    vertex((xx+ww)*+grid, (yy+hh)*grid);
    if (altCol) fill(c1, a1);
    vertex(xx*grid, (yy+hh)*grid);
    endShape(CLOSE);
  }

  for (int j = 0; j < cc; j++) {
    float xx = int(random(1, cc-1))*grid;
    float yy = int(random(1, cc-1))*grid;
    fill(rcol());

    float ms = grid*0.5;
    float cx = xx+ms;
    float cy = yy+ms;

    int dis = int(random(2, 8));
    int col = rcol();
    noStroke();
    stroke(0);


    float dx = -1;
    float dy = -1;
    if (random(1) < 0.5) dx = 1; 

    float mirH = (random(1) < 0.5)? -1 : 1;
    float mirV = (random(1) < 0.5)? -1 : 1;



    noStroke();
    beginShape();
    fill(col, random(200));
    vertex(cx-ms*dx*mirH, cy-ms*dy*mirV);
    vertex(cx+ms*dx*mirH, cy+ms*dy*mirV);
    fill(col, 0);
    vertex(cx+ms*dx*mirH+ms*dis*mirH, cy+ms*dy*mirV+ms*dis*mirV);
    vertex(cx-ms*dx*mirH+ms*dis*mirH, cy-ms*dy*mirV+ms*dis*mirV);
    endShape(CLOSE);

    noStroke();
    float alp = random(20);
    fill(0, alp);
    rect(xx+ms*random(-0.3, 0.3)*random(1), yy+ms*random(-0.3, 0.3)*random(1), grid, grid);
    fill(rcol());
    rect(xx, yy, grid, grid);
  }

  translate(width*0.5, height*0.5);

  noStroke();
  for (int i = 0; i < 60; i++) {
    float xx = width*random(-0.5, 0.5)*random(0.4, 1);
    float yy = height*random(-0.5, 0.5)*random(0.4, 1);
    float ss = 4*int(random(2, 16)*random(1));

    xx -= xx%grid;
    yy -= yy%grid;

    pushMatrix();
    translate(xx, yy);
    rotate(HALF_PI*int(random(4)));
    if (random(1) < 0.2) rotate(random(TAU));

    fill(rcol());
    ellipse(0, 0, ss*1.8, ss*1.8);
    noStroke();
    arc2(0, 0, ss*1.8, ss*3, 0, TAU, rcol(), 100, 0);

    float ic = random(colors.length);
    float dc = random(0.04)*random(1)*random(0.5, 1);

    xx = 0;
    yy = 0;

    float oscVel = random(random(0.1), 0.2)*random(0.5, 1);
    float oscAmp = random(random(0.5), random(1));
    float modAmp = random(random(0.97, 1), random(1, 1.03));

    int ddd = int(random(50, 250)*random(1));

    for (int j = 0; j < ddd; j++) {

      oscAmp *= modAmp;

      float dx = sin(j*oscVel)*ss*oscAmp;

      /*
      fill(255, 1);
       ellipse(xx+dx, yy-j, ss*2, ss*2);
       */

      float alp = 255;
      alp = constrain(map(j, ddd*0.9, ddd, 255, 0), 0, 255);

      fill(getColor(ic+dc*j), alp);
      ellipse(xx+dx, yy-j, ss, ss);
    }
    popMatrix();
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*max(s1, s2)*0.25);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/f76fc1-ff9129-afe36b-29a8cc-100082

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#F76FC1, #FF7028, #AFE36B, #29a8cc, #100082}; //
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int colors[] = {#EDFFFC, #FFFF3D, #F393FF, #01CCCC, #5967FF}; //


int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
