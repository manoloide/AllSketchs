import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
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

  int grid = 20;

  randomSeed(seed);
  noiseSeed(seed);

  background(#241B15);
  rectMode(CENTER);
  noStroke();
  fill(255, 14);
  for (int j = grid; j < height; j+=grid) {
    for (int i = grid; i < width; i+=grid) {
      rect(i, j, 2, 2);
    }
  }

  for (int i = 0; i < 60; i++) {
    float s1 = grid*int(random(1, 10));
    float s2 = grid*int(random(1, 10));
    float r1 = s1*0.5;
    float r2 = s2*0.5;
    float x1 = random(s1, width-s1*0.5); 
    float y1 = random(s1, height-s1*0.5); 
    float x2 = random(s2, width-s2*0.5); 
    float y2 = random(s2, height-s2*0.5); 

    x1 -= x1%s1;
    y1 -= y1%s1;
    x2 -= x2%s2;
    y2 -= y2%s2;

    stroke(255, 90);
    fill(255, 10);
    /*
    line(x1-r1, y1-r1, x2-r2, y2-r2);
     line(x1+r1, y1-r1, x2+r2, y2-r2);
     line(x1+r1, y1+r1, x2+r2, y2+r2);
     line(x1-r1, y1+r1, x2-r2, y2+r2);
     */

    noStroke();

    float maxAlp = random(160, 220)*0.8;
    noFill();
    stroke(rcol(), 180);
    for (int k = 0; k <= 700; k++) {
      float vv = pow(map(k, 0, 20, 0, 1), 0.6);
      float xx = lerp(x1, x2, vv);
      float yy = lerp(y1, y2, vv);
      float ss = lerp(s1, s2, vv);
      rect(xx, yy, ss, ss);
    }


    /*
    beginShape(QUADS);
     fill(rcol(), random(maxAlp));
     vertex(x1-r1, y1-r1);
     vertex(x2-r2, y2-r2);
     fill(rcol(), random(maxAlp));
     vertex(x2+r2, y2-r2);
     vertex(x1+r1, y1-r1);
     
     
     fill(rcol(), random(maxAlp));
     vertex(x1+r1, y1+r1);
     vertex(x1+r1, y1-r1); 
     fill(rcol(), random(maxAlp));
     vertex(x2+r2, y2-r2);
     vertex(x2+r2, y2+r2); 
     
     fill(rcol(), random(maxAlp));
     vertex(x1-r1, y1+r1);
     vertex(x1+r1, y1+r1);
     fill(rcol(), random(maxAlp));
     vertex(x2+r2, y2+r2);
     vertex(x2-r2, y2+r2);
     
     fill(rcol(), random(maxAlp));
     vertex(x2-r2, y2+r2);
     vertex(x2-r2, y2-r2);
     fill(rcol(), random(maxAlp));
     vertex(x1-r1, y1-r1); 
     vertex(x1-r1, y1+r1); 
     
     endShape(); */


    fill(rcol(), random(maxAlp));
    //rect(x1, y1, s1, s1);
    //rect(x2, y2, s2, s2);

    fill(255, 60);
    rect(x1, y1, 2, 2);
    rect(x2, y2, 2, 2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#241B15, #9E9F97, #D8D8D0, #FE4D7B, #003F7F};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
