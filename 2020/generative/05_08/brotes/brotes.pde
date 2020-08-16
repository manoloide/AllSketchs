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
  background(252, 250, 245);
  
  noStroke();
  fill(getColor());
  ellipse(width*0.5, height*0.5, width*0.6, height*0.6);

  noStroke();
  for (int j = 0; j < 1; j++) {
    float aa = random(-0.2, 0.2)*random(1);
    rama(width*random(0.48, 0.52), height*1.9, width*random(0.02, 0.04), height*0.9, PI*1.5+aa, 9-j);
  }
}

void rama(float x, float y, float w, float h, float a, int ite) {
  ite--;
  float ax = x; 
  float ay = y; 
  float nx = x+cos(a)*h;
  float ny = y+sin(a)*h;
  if (ite > 0) {

    float mw1 = w*0.6;
    float mw2 = w*0.1;

    textureMode(NORMAL);
    noStroke();

    fill(0, 50);
    beginShape(QUAD);
    vertex(lerp(ax+cos(a-HALF_PI)*mw1, width*0.2, 0.6), lerp(ay+sin(a-HALF_PI)*mw1, height*1.0, 0.6), 0, 0);
    vertex(lerp(ax+cos(a+HALF_PI)*mw1, width*0.2, 0.6), lerp(ay+sin(a+HALF_PI)*mw1, height*1.0, 0.6), 1, 0);
    vertex(lerp(nx+cos(a+HALF_PI)*mw2, width*0.2, 0.6), lerp(ny+sin(a+HALF_PI)*mw2, height*1.0, 0.6), 1, 1);
    vertex(lerp(nx+cos(a-HALF_PI)*mw2, width*0.2, 0.6), lerp(ny+sin(a-HALF_PI)*mw2, height*1.0, 0.6), 0, 1);

    endShape(CLOSE);

    fill(getColor(ite));
    beginShape(QUAD);
    vertex(ax+cos(a-HALF_PI)*mw1, ay+sin(a-HALF_PI)*mw1, 0, 0);
    vertex(ax+cos(a+HALF_PI)*mw1, ay+sin(a+HALF_PI)*mw1, 1, 0);
    vertex(nx+cos(a+HALF_PI)*mw2, ny+sin(a+HALF_PI)*mw2, 1, 1);
    vertex(nx+cos(a-HALF_PI)*mw2, ny+sin(a-HALF_PI)*mw2, 0, 1);

    endShape(CLOSE);

    fill(0);
    ellipse(ax, ay, mw1*0.5, mw1*0.5);
    ellipse(nx, ny, mw2*0.5, mw2*0.5);

    int cc = int(random(2, random(2, 4.6)*random(1)));
    for (int k = 0; k < cc; k++) {
      float v = random(random(0.3, 0.5), 1);
      float aa = a+(random(-1, 1)*random(0.8, 4.2)+random(-0.4, 0.4))*random(random(1), 1)*random(1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
      rama(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.9, h*random(0.6, 0.8)*0.9, aa, ite-int(random(1.1)));
    }
    cc = int(random(-20, 2));
    for (int k = 0; k < cc; k++) {
      float hh = dist(ax, ay, nx, ny)*random(0.2, 0.6)*10;
      //fill(rcol());
      stroke(rcol());
      noFill();
      //curve(ax, ay-hh, ax, ay, nx, ny, nx, ny-hh);
    }
  } else {
    if (random(1) < 0.002) {
      fill(rcol());
      float s = w*random(20);
      //ellipse(ax, ay, s, s);
    }

    /*
    if (random(1) < 0.1) {
     for (int k = 0; k < 3; k++) {
     float hh = abs(ny-ax)*random(-0.2, 0.2);
     fill(rcol());
     curve(ax, ay-hh, ax, ay, nx, ny, nx, ny-hh);
     }
     */
    /*
      fill(rcol());
     float s = w*random(10);
     float da = PI*random(0.1);
     for (int k = 0; k < 10; k++) {
     arc(ax, ay, s, s, a+da*k, a+da*k+PI);
     }
     */
  }

  /*
    fill(rcol(), 100);
   float s = w*random(20)*random(1)*2*random(1)*random(1);
   ellipse(ax, ay, s, s);
   */
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
