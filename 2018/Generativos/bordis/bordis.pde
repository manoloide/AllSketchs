import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  pixelDensity(2);
  smooth(8);
  generate();
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

  float time = random(10);

  randomSeed(seed);
  noiseSeed(seed);
  background(230);

  int cc = int(random(160, 180)*1.2);
  float s = width*1./cc;
  
  fill(0, 40);
  noStroke();
  for(int j = 0; j < cc; j++){
    for(int i = 0; i < cc; i++){
       ellipse((i+0.5)*s, (j+0.5)*s, s*0.2, s*0.2); 
    }
  }

  float det = random(0.004, 0.012)*0.7;
  float des = random(1);

  float detc = random(0.004, 0.012);
  float desc = random(1);
  
  float detc2 = random(0.004, 0.012)*1;
  float desc2 = random(1);
  
  //noiseDetail(8);

  strokeWeight(0.7);
  stroke(0, 180);
  for (int i = 0; i < 120; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = s*(pow(2, int(pow(noise(des+xx*det, des+yy*det), 1.2)*8)));
    xx -= xx%ss;
    yy -= yy%ss;
    float ax = xx;
    float ay = yy;
    boolean rect = (random(1) < 0.5);
    float ic = random(1);
    float dc = random(0.006);
    for (int j = 0; j < 60; j++) {

      ax = xx;
      ay = yy;

      ss = s*(pow(2, int(noise(des+xx*det, des+yy*det)*7)));
      if (random(1) < 0.1) rect = !rect;
      if (rect) {
        xx += (int(random(-2, 2)))*ss;
        yy += (int(random(-2, 2)))*ss;
      } else {
        float aa = (TAU/6.)*int(random(6));
        xx += cos(aa)*ss;
        yy += sin(aa)*ss;
      }

      if(j > 0 && j < 59) line(xx, yy, ax, ay);
      fill(getColor(ic+dc*j));
      fill(getColor(noise(des+ax*det, des+ay*det)+random(0.1)), 240);
      ellipse(ax, ay, ss*0.5, ss*0.5);
      fill(getColor(noise(desc+ax*detc, desc+ay*detc)));
      ellipse(ax, ay, ss*0.2, ss*0.2);
      fill(255, 80);
      ellipse(ax, ay, ss*0.02, ss*0.02);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
//int colors[] = {#92C8FA, #0321A1, #07AE28, #F94D21, #FFFFFF};
//int colors[] = {#E20D71, #732FB7, #EFB632, #E1DAED, #32332D};
//int colors[] = {#000000, #1600FB, #01E5FF, #EFFF43, #F0F0F0};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
