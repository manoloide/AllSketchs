import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
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

  background(rcol());

  noStroke();
  for (int i = 0; i < 400; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(20, 900)*random(1)*random(1)*random(1)*random(1);
    fill(rcol(), 220);
    ellipse(xx, yy, ss, ss);
    ellipse(xx, yy, ss-5, ss-5);
    float da = TAU/3.;
    float r = max(0, ss*0.5-5);
    float des = random(TAU);
    int col = rcol();
    fill(col);
    beginShape();
    for (int j = 0; j < 3; j++) {
      float ang = des+da*j;
      if(j == 2) fill(rcol(), 0);
      vertex(xx+cos(ang)*r, yy+sin(ang)*r);
    }
    endShape(CLOSE);
    fill(rcol());
    ellipse(xx, yy, ss*0.05, ss*0.05);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#D84004, #E8E8E8, #411BD6, #242B24, #EFEA53};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
