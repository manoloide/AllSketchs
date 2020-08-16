import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brush;
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

  brush = loadImage("diente.png");

  //loadForms();

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
  background(rcol());

  rectMode(CENTER);
  imageMode(CENTER);


  float detSca = random(0.001);


  for (int i = 0; i < 2000; i++) {

    if (random(1) < 0.4) 
      blendMode(ADD);
    else blendMode(NORMAL);
    float x = random(width); 
    float y = random(height);
    pushMatrix();
    translate(x, y);
    rotate(random(TAU));
    float ns = noise(x*detSca, y*detSca);
    float sca = random(0.5, 1.2)*random(1)*random(1)*random(1)*ns*3;
    tint(getColor(sca), random(90)*random(1));//lerpColor(color(0), rcol(), random(0.18)), random(255)*0.1);

    image(brush, 0, 0, brush.width*sca, brush.height*sca);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#EDF67D, #F896D8, #CA7DF9, #724CF9, #564592};
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
