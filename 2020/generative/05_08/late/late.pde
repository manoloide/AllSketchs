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

  if (export) {
    saveImage();
    exit();
  }
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
  background(0);

  noStroke();
  rectMode(CENTER);
  float det = random(0.004, 0.01);
  for (int i = 0; i < 300; i++) {
    float x = random(width);
    float y = random(height);
    float s = pow(noise(x*det, y*det), 2.4)*320*random(0.5, 1);

    x -= x%8;     
    y -= y%8;

    beginShape();
    fill(0, 40);
    vertex(x-s*0.5, y+s*0.5);
    vertex(x+s*0.5, y+s*0.5);
    fill(0, 0);
    vertex(x+s*0.5, y+s*1.5);
    vertex(x-s*0.5, y+s*1.5);
    endShape();

    fill(rcol());
    rect(x, y, s, s);
    fill(rcol());
    rect(x, y, s-8, s-8);

    int cc = int(random(1, random(1, 14)));
    float ss = s*1./cc;
    float bb = 2;
    for (int k = 0; k < cc; k++) {
      for (int j = 0; j < cc; j++) {
        fill(rcol());
        rect(x+ss*(j-cc*0.5+0.5), y+ss*(k-cc*0.5+0.5), ss-bb, ss-bb);
        fill(rcol());
        rect(x+ss*(j-cc*0.5+0.5), y+ss*(k-cc*0.5+0.5), random(ss), random(ss));

        if (random(1) < 0.01) {
          float sss = random(10)*ss*random(1)*random(1);
          fill(rcol());
          ellipse(x+ss*(j-cc*0.5+0.5), y+ss*(k-cc*0.5+0.5), sss, sss);
          fill(rcol());
          ellipse(x+ss*(j-cc*0.5+0.5), y+ss*(k-cc*0.5+0.5), sss*0.1, sss*0.1);
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#EDF67D, #F896D8, #CA7DF9, #724CF9, #564592};
//int colors[] = {#BF052A, #DBB304, #E1E7ED, #04140C};
//int colors[] = {#057EBF, #DBB304, #E1E7ED, #04140C};
//int colors[] = {#00A878, #D8F1A0, #F3C178, #FE5E41, #0B0500};
int colors[] = {#FF0700, #FEC626, #FEDE88, #1AC1A2, #42040A};
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
  return lerpColor(c1, c2, pow(v%1, 0.1));
} 
