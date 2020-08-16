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

  for (int i = 0; i < 10000; i++) {
    stroke(rcol(), random(200));
    point(random(width), random(height));
  }

  rectMode(CENTER);
  noStroke();

  float des = 5;

  for (int i = 0; i < 400; i++) {
    float x = random(width+des);
    float y = random(height+des);
    float s = random(520)*random(1)*random(1*random(1))*random(0.5, 1);
    x -= x%des;
    y -= y%des;

    int ddd = int(random(28, 65));
    float da = TAU/ddd;
    for (int j = 0; j < ddd; j++) {
      noStroke();
      fill(rcol());
      float amp = 1;//noise(cos(j+i));
      arc2(x, y, s, s*2*amp, j*da, j*da+da*0.8, rcol(), 200, 0);
    }

    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);

    float a1 = random(TAU);
    float amp = random(0.012)*0.6;
    arc2(x, y, s, s*12, a1-amp*0.5, a1+amp*0.5, rcol(), 255, 0);
    //amp *= 0.2;
    //arc2(x, y, s, s*12, a1-amp*0.5, a1+amp*0.5, color(255), 200, 0);

    a1 = random(TAU);
    amp = random(0.012)*4;
    //arc2(x, y, s, s*12, a1-amp*0.5, a1+amp*0.5, rcol(), 255, 255);

    //arc2(x, y, s*0.05, s, 0, TAU, rcol(), random(120), 0);
    arc2(x, y, s, s*8, 0, TAU, rcol(), random(28)*random(1), 0);
    //arc2(x, y, s, s*1.8, 0, TAU, color(255), random(50)*random(1), 0);

    arc2(x, y, s*0.4, s, 0, TAU, color(0), random(50, 100)*random(1), 0);
    arc2(x, y, s*0.4, s*0.6, 0, TAU, color(0), random(30, 40)*random(1), 0);

    int div = int(random(8, 20));
    fill(rcol());
    for (int j = 0; j < div; j++) {
      pushMatrix();
      translate(x, y);
      rotate(j*PI*1./div);
      ellipse(0, 0, s*0.5, s*0.09);
      popMatrix();
    } 


    boolean inv = (random(1) < 0.5);

    fill(rcol());
    ellipse(x, y, s*0.4, s*0.4);
    fill(0);
    if (inv) fill(255);
    ellipse(x, y, s*0.32, s*0.32);

    fill(255);
    if (inv) fill(0);
    float dd = s*random(0.02, 0.12);
    float ss = s*random(0.02, 0.03);
    ellipse(x-dd, y-dd*0.2, ss, ss);
    ellipse(x+dd, y-dd*0.2, ss, ss);

    float d1 = dd*random(0.6, 0.9)*0.8;
    float d2 = dd*random(0.6, 0.9)*0.8;
    noFill();
    stroke(255);
    if (inv) stroke(0);
    strokeWeight(s*0.006);

    if (random(1) < 0.4) {
      arc(x, y+dd*0.1, d1, d2, 0, PI);
    } else {
      arc(x, y+dd*0.1+d2*0.5, d1, d2, PI, TAU);
    }
    
    noStroke();
    fill(0, 20);
    ellipse(x, y+s*0.3, s*0.3, s*0.05);
    
    stroke(0);
    if (inv) stroke(255);
    line(x-dd*0.8, y+s*0.1, x-dd*0.8, y+s*0.3);
    line(x+dd*0.8, y+s*0.1, x+dd*0.8, y+s*0.3);
    
  }
  strokeWeight(1);

  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width+des);
    float y = random(height+des);
    x -= x%(des*0.5);
    y -= y%(des*0.5);

    float s = random(4);

    int cc = int(random(100)*random(1));
    for (int j = 0; j < cc; j++) {
      fill(rcol());
      rect(x+j*s*0.25, y, s, s);
    }
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


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
