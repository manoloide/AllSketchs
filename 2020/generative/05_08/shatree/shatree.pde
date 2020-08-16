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
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brushes = new PImage[4];
  for (int i = 0; i < 4; i++) {
    brushes[i] = loadImage("brush/brush0"+str(i+1)+".png");
  }

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {

  generate();
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
  background(240);

  rectMode(CENTER);
  imageMode(CENTER);

  for (int i = 0; i < 20; i++) {

    tint(random(210, 250), random(100, 200));
    pushMatrix();
    translate(random(width), random(height));
    rotate(random(TAU));
    float sca = width*random(0.5, 1.2);
    PImage aux = brushes[int(random(brushes.length))];
    image(aux, 0, 0, sca, sca);
    popMatrix();
  }

  for (int i = 0; i < 20; i++) {

    tint(random(210, 250)*0.4, random(100, 200)*0.4);
    pushMatrix();
    translate(random(width), random(height*random(0.6)));
    rotate(random(TAU));
    float sca = width*random(0.5, 1.2)*0.4;
    PImage aux = brushes[int(random(brushes.length))];
    image(aux, 0, 0, sca, sca);
    popMatrix();
  }

  for (int i = 0; i < 200; i++) {

    tint(random(210, 250)*0.05, random(100, 200)*1.4);
    pushMatrix();
    translate(random(width), random(height*random(0.6)));
    rotate(random(TAU));
    float sca = width*random(0.5, 1.2)*0.2*random(0.05);
    PImage aux = brushes[int(random(brushes.length))];
    image(aux, 0, 0, sca, sca);
    image(aux, 0, 0, sca, sca);
    image(aux, 0, 0, sca, sca);
    popMatrix();
  }

  for (int i = 0; i < 200000; i++) {

    tint(random(210, 250)*0.01, random(100, 200)*0.5);
    pushMatrix();
    translate(random(width), height*random(random(0.5, 1), 1));
    rotate(HALF_PI+random(TAU)*random(-0.2, 0.2));
    float sca = width*random(0.5, 1.2)*random(0.05)*0.4;
    PImage aux = brushes[int(random(brushes.length))];
    image(aux, 0, 0, sca, sca*random(0.3));
    popMatrix();
  }

  noStroke();
  float aa = random(-0.2, 0.2)*random(1);
  rama(width*random(0.48, 0.52), height*0.9, width*0.04, height*0.4, PI*1.5+aa, 7);


  /*
  noStroke();
   //stroke(255, 0, 0);
   for (int i = 0; i < 40; i++) {
   fill(0);
   //float aa = random(-0.2, 0.2)*random(1);
   float vy = random(0.6, 0.9);
   float sca = random(0.9, 1)*vy*0.4;
   rama(width*random(0.2, 0.8), height*(vy-0.45)*2, width*0.04*sca, height*0.4*sca, PI*1.5+aa, 7);
   }
   */
}

void rama(float x, float y, float w, float h, float a, int ite) {
  ite--;
  if (ite > 0) {
    float ax = x; 
    float ay = y; 
    float nx = x+cos(a)*h;
    float ny = y+sin(a)*h;


    float mw1 = w*0.8;
    float mw2 = w*0.1;

    textureMode(NORMAL);
    beginShape(QUAD);
    int cc = int(random(1, ite));
    for (int i = 0; i < cc; i++) {
      tint(0);
      PImage tex = brushes[int(random(brushes.length))];
      texture(tex);
      vertex(ax+cos(a-HALF_PI)*mw1, ay+sin(a-HALF_PI)*mw1, 0, 0);
      vertex(ax+cos(a+HALF_PI)*mw1, ay+sin(a+HALF_PI)*mw1, 1, 0);
      vertex(nx+cos(a+HALF_PI)*mw2, ny+sin(a+HALF_PI)*mw2, 1, 1);
      vertex(nx+cos(a-HALF_PI)*mw2, ny+sin(a-HALF_PI)*mw2, 0, 1);
    }
    endShape(CLOSE);

    cc = int(random(2, 4));
    for (int k = 0; k < cc; k++) {
      float v = random(0.3, 1);
      float aa = a+(random(-0.9, 0.9)+random(-0.6, 0.6))*random(random(1), 1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
      rama(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.8, h*random(0.6, 0.8)*0.8, aa, ite-int(random(1.1)));
    }
  } else {
    for (int i = 0; i < 3; i++) {
      pushMatrix();
      translate(x, y); 
      rotate(random(TAU));
      imageMode(CENTER);
      PImage tex = brushes[int(random(brushes.length))];
      //tint(rcol());
      tint(random(256), 200);
      float ang = random(TAU);
      float ddd = random(w*10);
      float sca = random(1, 4)*random(0.4, 1);
      image(tex, cos(ang)*ddd, sin(ang)*ddd, w*16*sca, w*16*sca);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
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
