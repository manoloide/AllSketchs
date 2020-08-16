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

  background(10);

  float det1 = random(0.005);
  float des1 = random(10000);
  float det2 = random(0.005);
  float des2 = random(10000);

  for (int i = 0; i < 100; i++) {
    float x = random(-80, width+80);
    float y = random(-80, height+80);

    if (random(1) < 1) {
      x -= x%40;
      y -= y%40;
    }

    rectMode(CENTER);

    noStroke();
    fill(rcol());
    pushMatrix();
    translate(x, y);
    rotate(HALF_PI*int(random(8)));
    float w = 4*int(pow(2, int(random(2, random(4)))));
    float h = 200;

    int c1 = getColor(noise(des1+x*det1, des1+y*det1)*colors.length*2);
    int c2 = getColor(noise(des2+x*det2, des2+y*det2)*colors.length*2);

    int sub = 20*int(random(1, 5));
    float hh = h*2./sub;

    for (int j = 0; j < sub; j++) {
      float h1 = map(j, 0, sub, -h, h);
      float h2 = map(j+0.8, 0, sub, -h, h);
      beginShape();
      fill(c1);
      vertex(-w, h1);
      vertex(+w, h1);
      fill(c2, 80);
      vertex(+w, h2);
      vertex(-w, h2);
      endShape();
      //rect(0, 0, 20, 200);
    }
    popMatrix();


    fill(255, 12);
    ellipse(x, y, 120, 120);

    fill(255);
    ellipse(x, y, 20, 20);
    fill(lerpColor(rcol(), color(0), random(1)*random(1)));
    ellipse(x, y, 16, 16);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#4703BC, #CC8BE0, #EA1E3D, #F9CD07, #E5E5E5};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
