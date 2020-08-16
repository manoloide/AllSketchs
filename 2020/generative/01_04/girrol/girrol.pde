import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brushes[];
PImage forms[];
PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brushes = new PImage[4];
  for (int i = 0; i < 4; i++) {
    brushes[i] = loadImage("brush/brush0"+str(i+1)+".png");
  }

  //loadForms();

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void loadForms() {
  PImage ori = loadImage("forms.png");

  int cc = 16;
  int des = ori.width/cc;
  forms = new PImage[cc*2];
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < cc; i++) {
      forms[i+cc*j] = ori.get(i*des, j*des, des, des);
    }
  }
  ori = null;
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

  rectMode(CENTER);
  imageMode(CENTER);

  for (int i = 0; i < 100; i++) {

    tint(lerpColor(color(0), rcol(), random(0.18)));
    pushMatrix();
    translate(random(width), random(height));
    rotate(random(TAU));
    float sca = width*random(0.5, 1.2);
    PImage aux = brushes[int(random(brushes.length))];
    image(aux, 0, 0, sca, sca);
    popMatrix();
  }

  float detAng = random(0.008);
  float desAng = random(10000);

  float detAmp = random(0.002);

  float detCol1 = random(0.0008, 0.002)*0.5;
  float detCol2 = random(0.0008, 0.002)*0.5;

  noStroke();

  //blendMode(ADD);
  for (int i = 0; i < 200000; i++) {
    float xx = random(-0.2, 1.2)*width;
    float yy = random(-0.2, 1.2)*height;
    float ww = random(4, 12)*random(1)*0.2;
    float hh = ww*random(0.4, random(0.5, 1.2))*random(0.4, 1.2);
    xx -= (noise(xx*0.01, yy*0.01, 100)*2-1)*20;
    yy -= (noise(yy*0.01, 100, xx*0.01)*2-1)*20;

    float amp = (float) SimplexNoise.noise(xx*detAmp, yy*detAmp, seed*detAmp)*0.5+0.5;//0.5+pow(abs(sin((yy*TAU)/height)), 0.7)*0.5;


    float cn1 = (float)SimplexNoise.noise(xx*detCol1, yy*detCol1, seed*0.01*detCol1)*0.5+0.5;
    float cn2 = (float)SimplexNoise.noise(xx*detCol2, yy*detCol2, 20+seed*0.01*detCol2)*0.5+0.5;
    tint(getColor(random(2)*random(1)+(cn1+cn2)*colors.length*(2*pow(1-amp, 3))), random(255)*random(1));
    pushMatrix();
    translate(xx+random(-2, 2), yy+random(-2, 2));
    rotate(HALF_PI+(noise(desAng+xx*detAng, desAng+yy*detAng)*2-1)*TAU*0.2);
    //rect(0, 0, ww, hh);
    float sca = 3+random(1);
    sca *= random(16, 24)*1.4;
    sca *= amp;
    //hh *= amp;
    PImage aux = (random(1) < 1)? brushes[int(random(brushes.length))] : forms[int(random(forms.length))];
    image(aux, 0, 0, ww*sca, hh*sca);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#08070A, #0F6489, #96C4CB, #EBD15B, #F28A0E, #DD2404, #4E1706};
int colors[] = {#25564F, #4D7AAC, #AAC1B9, #FCCD02, #100E14};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
