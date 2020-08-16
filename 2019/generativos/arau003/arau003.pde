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

  //background(4);//250);
  background(10);

  //back();
  stroke(0, 20);
  noStroke();
  for (int i = 0; i < 12000; i++) {
    float x = random(width);
    float y = random(1)*height;
    float s = width*random(0.01, 0.04)*0.08;
    fill(lerpColor(getColor(), color(0), random(0.8)));
    pushMatrix();
    translate(x, y);
    rotate(random(TAU));
    ellipse(0, 0, s*0.4, s);
    popMatrix();
  }


  float desCol = random(1000);
  float detCol = random(0.008, 0.01)*0.3;

  int cc = 260;//10;// 2000;
  for (int i = 0; i < cc; i++) {
    float v = pow(map(i, 0, cc, 0, 1), 1);
    float x = width*random(-0.1, 1.1);
    float y = height*map(v, 0, 1, 0.04, 1.1);
    float s = width*map(v, 0, 1, 0.81, 1)*0.16*random(0.6, 1);
    float ic = noise(desCol+x*detCol, desCol+y*detCol)*colors.length*2+random(0.1);
    pushMatrix();
    translate(x, y);
    rotate(random(-0.1, 0.1)*random(1));
    fill(rcol());
    noStroke();
    ellipse(0, 0, s*0.2, s*0.04);
    ara(0, 0, s*0.9, ic);
    popMatrix();
  }

  //ara(width*0.5, height*0.8, width*0.6, random(colors.length));
}

void back() {
  float des = 5;

  for (int i = 0; i < 1000; i++) {
    float x = random(width+des);
    float y = random(height+des);
    float s = random(380)*random(1)*random(1*random(1))*random(0.5, 1);
    x -= x%des;
    y -= y%des;

    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);

    arc2(x, y, s*0.05, s, 0, TAU, rcol(), random(120), 0);
    arc2(x, y, s, s*8, 0, TAU, rcol(), random(80)*random(1), 0);
    arc2(x, y, s, s*1.8, 0, TAU, color(255), random(50)*random(1), 0);

    int div = int(random(8, 20));
    fill(rcol());
    for (int j = 0; j < div; j++) {
      pushMatrix();
      translate(x, y);
      rotate(j*PI*1./div);
      ellipse(0, 0, s*0.6, s*0.1);
      popMatrix();
    }  

    fill(rcol());
    ellipse(x, y, s*0.4, s*0.4);
    fill(0);
    ellipse(x, y, s*0.32, s*0.32);

    fill(255);
    float dd = s*random(0.02, 0.12);
    float ss = s*random(0.02, 0.03);
    ellipse(x-dd, y-dd*0.2, ss, ss);
    ellipse(x+dd, y-dd*0.2, ss, ss);

    float d1 = dd*random(0.6, 0.9)*0.8;
    float d2 = dd*random(0.6, 0.9)*0.8;
    noFill();
    stroke(255);
    strokeWeight(s*0.006);
    arc(x, y+dd*0.1, d1, d2, 0, PI);
  }

  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width+des);
    float y = random(height+des);
    x -= x%(des*0.5);
    y -= y%(des*0.5);

    float s = random(4);

    fill(rcol());
    rect(x, y, s, s);
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(4, PI*pow(max(s1, s2)*0.1, 1)*3);

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}

void ara(float x, float y, float s, float ic) {

  float dc = random(0.008, 0.01);

  strokeWeight(s*0.001+0.7);
  //blendMode(ADD);

  //strokeWeight(2);
  float pwrTron = 1.1;
  float mov = 0;
  for (int i = 0; i < s; i++) {
    float v = map(i, 0, s, 0.5, 0);
    float xx = x;
    float yy = y+map(i, 0, s, 0, -s); 
    v = pow(v, pwrTron);
    fill(getColor(ic+dc*v+random(0.1)), 120);
    ellipse(xx+mov, yy, s*0.04*(v+0.1), s*0.03*(v+0.1));

    mov *= 0.9;
    mov += random(-1, 1)*random(0.35)*random(0.5, 1);
  }

  float den = 0.3;//random(1.5, 3);

  for (int i = 0; i < s*den; i++) {

    stroke(getColor(ic+dc*i));
    float v = random(1)*random(0.6, 1); 
    float pwrAmp = 1.6;   
    float curAmp = v+abs(v-0.5)*0.04;
    curAmp = pow(pow(1-curAmp, 0.45), pwrAmp);
    float amp = cos(map(curAmp, 0, 1, HALF_PI, PI*1.5));

    float des = amp*s*random(0.4, 0.42);
    float angV = pow(v, 3)*1.2-0.8+random(0.05);//map(v, 0, 1, -PI*0.1, PI*0.8);//random(-0.02, 0.02);

    float dx = cos(angV)*des;
    float dy = sin(angV)*des;

    float ang = HALF_PI*random(1)*random(0.8, 1);//sqrt(random(1)*random(0.9, 1));
    if (random(1) < 0.5) ang = map(ang, 0, HALF_PI, PI, HALF_PI);

    //ang *= random(1);

    //v = pow(v, pwrTron);
    float xx = x+cos(ang)*s*0.01*pow(v, pwrTron);
    float yy = y-s*(1-v)+sin(ang)*s*0.01;

    float x1 = xx; 
    float y1 = yy;
    float x2 = xx-dx*cos(ang);
    float y2 = yy-dy*sin(ang)*0.2;



    float dd = -s*0.2*map(pow(v, 0.6), 0, 1, -1, 1)*random(0.5, 1);

    y2 -= dd*0.2;


    noFill();
    stroke(getColor(ic+dc+random(1)*random(1)), random(26, 30)*12);
    curve(x1, y1-dd, x1, y1, x2, y2, x2, y2-dd);


    blendMode(ADD);
    noStroke();
    float ss = 0.8+s*0.002;
    fill(getColor(ic+dc*i+random(1)), random(200, 250));
    ellipse(x2, y2, ss, ss);
    blendMode(NORMAL);
  }
  
  fill(255);
  //ellipse(x, y, 4, 4);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
//int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
