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
  background(10);

  float detDes = random(0.005, 0.003)*0.7;
  float detAmp = random(0.005, 0.003)*0.7;
  float detCol = random(0.0006);
  float detCol2 = random(0.02);

  //blendMode(ADD);


  for (int i = 0; i < 300000; i++) {
    float x = random(width);
    float y = random(height);
    float w = random(20)*noise(x*detAmp, y*detAmp)*random(1);
    strokeWeight(random(1.4));
    float col = noise(x*detCol, y*detCol)*14+random(1)+random(1)+constrain(noise(x*detCol2, y*detCol2)*3.5, 0, 1)*5;
    pushMatrix();
    translate(x, y);
    rotate(random(HALF_PI)*random(-1, 1)*random(-1, 1)*(w/20)*3);
    float dx = noise(x*detDes, 100, y*detDes)*100-50;
    float dy = noise(100, y*detDes, x*detDes)*100-50;
    stroke(getColor(col), random(260)*random(1));
    //if(random(1) < 0.02) stroke(0);
    line(-w*0.5+dx, 0, +w*0.5+dy, 0);

    float h = random(200)*random(1)*random(1);
    stroke(getColor(col), random(110)*random(1));
    line(x, y-h*0.0+dx, x, y+h*1.5+dy);
    popMatrix();
  }


  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float h = random(200)*random(1);
    float dx = noise(x*detDes, y*detDes)*100-50;
    float dy = noise(y*detDes, x*detDes)*100-50;
    line(x, y-h*0.0+dx, x, y+h*1.5+dy);
    fill(rcol());
    noStroke();
    float s = 3*(noise(x*detDes, y*detDes));
    ellipse(x, y, s, s);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#EDF67D, #F896D8, #CA7DF9, #724CF9, #564592};
//int colors[] = {#BF052A, #DBB304, #E1E7ED, #04140C};
//int colors[] = {#057EBF, #DBB304, #E1E7ED, #04140C};
int colors[] = {#00A878, #D8F1A0, #F3C178, #FE5E41, #0B0500};
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
