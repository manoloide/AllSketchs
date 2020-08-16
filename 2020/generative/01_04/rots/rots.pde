import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

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

  background(230);
  rectMode(CENTER);
  noStroke();
  float cc = 80;
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    x = lerp(x, width*0.5, random(0.5));
    y = lerp(y, height*0.5, random(0.5));
    float w = width*random(0.1, 0.8)*2;
    if (random(1) < 0.8) w *= 0.1;
    float h = height*random(0.1, 0.8)*2;
    if (random(1) < 0.8) h *= 0.1;
    float sca = random(1)*pow((1-(i*1./cc)), 0.2);
    w *= sca;
    h *= sca;
    pushMatrix();
    translate(x, y);
    rotate(int(random(16))*(HALF_PI*0.25));
    fill(rcol());
    rect(0, 0, w, h);
    beginShape();
    fill(rcol(), random(120, 260));
    vertex(w*0.5, -h*0.5);
    vertex(w*0.5, +h*0.5);
    fill(rcol(), 0);
    float amp = random(4, random(6, 10));
    vertex(w*(0.5+amp), +h*0.5);
    vertex(w*(0.5+amp), -h*0.5);
    endShape();
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
int colors[] = {#293473, #eb302a, #ffade0, #FCFAEF, #fcbf26};
//int colors[] = {#021CAA, #A686F0, #FAA0DD, #F83A7A, #FFF14D, #03AB85 };
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
