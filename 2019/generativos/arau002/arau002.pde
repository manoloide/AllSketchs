import org.processing.wiki.triangulate.*;

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

  //mask = loadImage("image.jpg");

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

  background(4);//250);
  stroke(0, 20);
  for(int i = 0; i < 200000; i++){
     float x = random(width);
     float y = random(0.04, 1)*height;
     float s = width*random(0.01, 0.04)*0.1;
     fill(lerpColor(getColor(), color(0), random(0.8)));
     pushMatrix();
     translate(x, y);
     rotate(random(TAU));
     ellipse(0, 0, s*0.4, s);
     popMatrix();
  }
  

  float desCol = random(1000);
  float detCol = random(0.007, 0.01)*0.18;

  int cc = 800;
  for (int i = 0; i < cc; i++) {
    float v = pow(map(i, 0, cc, 0, 1), 3.8);
    float x = width*random(-0.1, 1.1);
    float y = height*map(v, 0, 1, 0.04, 1.1);
    float s = width*map(v, 0, 1, 0.1, 1)*0.26*random(0.6, 1);
    float ic = noise(desCol+x*detCol, desCol+y*detCol)*colors.length*2+random(1);
    pushMatrix();
    translate(x, y);
    rotate(random(-0.1, 0.1)*random(1));
    ara(0, 0, s, ic);
    popMatrix();
  }
  //ara(width*0.5, height*0.8, width*0.6);
}

void ara(float x, float y, float s, float ic) {

  float dc = random(0.01);

  strokeWeight(s*0.0035+0.7);
  //blendMode(ADD);

  //strokeWeight(2);
  float pwrTron = 1.1;
  float mov = 0;
  for (int i = 0; i < s; i++) {
    float v = map(i, 0, s, 1, 0);
    float xx = x;
    float yy = y+map(i, 0, s, s*0.1, -s); 
    v = pow(v, pwrTron);
    fill(getColor(ic+dc*i), 230);
    ellipse(xx+mov, yy, s*0.04*v, s*0.03*v);

    mov *= 0.9;
    mov += random(-1, 1)*random(0.35)*random(0.5, 1);
  }

  float den = random(1.5, 3);

  for (int i = 0; i < s*den; i++) {

    stroke(getColor(ic+dc*i));
    float v = random(1)*random(0.4, 1); 
    float pwrAmp = 1.6;   
    float curAmp = v+abs(v-0.5)*0.04;
    curAmp = pow(pow(1-curAmp, 0.45), pwrAmp);
    float amp = cos(map(curAmp, 0, 1, HALF_PI, PI*1.5));

    float des = amp*s*random(0.4, 0.42);
    float angV = pow(v, 3)*1.2-0.8+random(0.05);//map(v, 0, 1, -PI*0.1, PI*0.8);//random(-0.02, 0.02);

    float dx = cos(angV)*des;
    float dy = sin(angV)*des;

    float ang = sqrt(random(1)*random(0.9, 1))*HALF_PI;
    if (random(1) < 0.5) ang = map(ang, 0, HALF_PI, PI, HALF_PI);

    //ang *= random(1);

    //v = pow(v, pwrTron);
    float xx = x+cos(ang)*s*0.02*pow(v, pwrTron);
    float yy = y-s*(1-v)+sin(ang)*s*0.01;

    float x1 = xx; 
    float y1 = yy;
    float x2 = xx-dx*cos(ang);
    float y2 = yy-dy*sin(ang)*0.2;

    float dd = -s*0.2*map(pow(v, 0.4), 0, 1, -1, 1)*random(0.5, 1);


    noFill();
    stroke(getColor(ic+dc*i+random(1)), random(20, 40));
    curve(x1, y1-dd, x1, y1, x2, y2, x2, y2-dd);


    blendMode(ADD);
    noStroke();
    float ss = 0.8+s*0.004;
    fill(getColor(ic+dc*i+random(1)), 180);
    ellipse(x2, y2, ss, ss);
    blendMode(NORMAL);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
//int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
