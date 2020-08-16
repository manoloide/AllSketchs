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

  background(0);
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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(50);

  desAng = random(1000);
  detAng = random(0.007, 0.01)*random(0.4, 1)*0.2;
  desDes = random(1000);
  detDes = random(0.006, 0.01)*0.08;
  desAmp = random(1000);
  detAmp = random(0.006, 0.01)*0.8;

  desAng2 = random(1000);
  detAng2 = random(0.007, 0.01)*random(0.4, 1)*0.2;
  desDes2 = random(1000);
  detDes2 = random(0.006, 0.01)*0.08;
  desAmp2 = random(1000);
  detAmp2 = random(0.006, 0.01)*10;


  float des1 = random(1000);
  float det1 = random(0.001, 0.002);

  float des2 = random(1000);
  float det2 = random(0.001, 0.002)*random(0.4, 0.5)*0.5;

  float des3 = random(1000);
  float det3 = random(0.001, 0.002)*random(0.4, 0.5)*3;


  float des4 = random(1000);
  float det4 = random(0.001, 0.002)*random(0.4, 0.5)*3;

  stroke(0, 220);
  noStroke();



  int particleCount = int(8000000);// 0000;
  blendMode(NORMAL);

  //strokeWeight(2);

  for (int i = 0; i < particleCount; i++) {


    blendMode(NORMAL);
    if (random(1) < 0.01) blendMode(ADD);

    float xx = width*random(-0.2, 1.2); 
    float yy = height*random(-0.2, 1.2);


    float amp1 = noise(des1+xx*det1, des1+yy*det1);
    float ss = lerp(2, 4, amp1)*0.6;

    float mask = noise(des3+xx*det3, des3+yy*det3)+random(-0.1, 0.1)*random(1);

    int colors[] = (mask < 0.5)? colors1 : colors2;
    //colors = colors1;
    float valCol = noise(des2+xx*det2, des2+yy*det2);
    valCol *= colors.length*3;
    //valCol = 0;
    int col = getColor(valCol, colors);

    if (random(1) < 0.05) col = color(255, 0, 0);
    if (random(1) < 0.05) col = color(0, 0, 255);

    PVector pos = desform(xx, yy);
    pos = desform2(pos.x, pos.y);
    pos = desform(pos.x, pos.y);

    pos = desform2(pos.x, pos.y);

    if (random(1) < 0.4) pos = desform(pos.x, pos.y);

    strokeWeight(ss*random(0.5, 1));//random(1, 3)*random(0.2, 1)*random(1));
    for (int k = 0; k < 1; k++) {
      col = lerpColor(getColor(valCol, colors), color(255), random(1)*random(1));
      stroke(col, random(200, 240)*0.7*0.5);
      point(pos.x+random(-1, 1)*random(1), pos.y+random(-1, 1)*random(1));
    }
    /*
    fill(col, random(200, 240)*0.6);
     //ellipse(pos.x, pos.y, ss, ss);
     */
  }
}


float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.006, 0.01);
float desAmp = random(1000);
float detAmp = random(0.006, 0.01);


float desAng2 = random(1000);
float detAng2 = random(0.01);
float desDes2 = random(1000);
float detDes2 = random(0.006, 0.01);
float desAmp2 = random(1000);
float detAmp2 = random(0.006, 0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float amp = (float) SimplexNoise.noise(desAmp+x*detAmp, desAmp+y*detAmp);
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*80*amp*random(0.5, 1); 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

PVector desform2(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng2+x*detAng2, desAng2+y*detAng2)*TAU*2;
  float amp = (float) SimplexNoise.noise(desAmp2+x*detAmp2, desAmp2+y*detAmp2);
  float des = (float) SimplexNoise.noise(desDes2+x*detDes2, desDes2+y*detDes2)*3*amp*random(0.4, 1); 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.25, 2));
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



//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors1[] = {#02142A, #063449, #18BEAD, #CFFDDA};
int colors1[] = {#0D0A18, #192E24, #5C8B55, #BCCEA8, #FFFFFF, #FFEE00};

//int colors1[] = {#000000, #000000, #000000};
//int colors2[] = {#FCF2C9, #FFD79C, #F98847};
int colors2[] = {#F76AE2, #F4251A, #EAEAEA, #88D8A3, #024091};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length), colors);
}
int getColor(float v, int colors[]) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
