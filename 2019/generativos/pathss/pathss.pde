import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  /*
  PGraphics[] images = new PGraphics[5];
   for (int i = 0; i < 5; i++) {
   PGraphics img = createGraphics(200, 40, P2D); 
   img.beginDraw();
   img.noStroke();
   for (int j = 0; j < 10; j++) {
   float ss = random(40)*random(1)*random(1);
   img.fill(getColor(), random(random(120), 255));
   img.ellipse(random(img.width), random(img.height), ss, ss);
   }
   img.endDraw();
   images[i] = img;
   }
   */

  imageMode(CENTER);

  float ww = 300;
  float hh = 40;

  noStroke();
  for (int k = 0; k < 40; k++) {

    float desAng = random(10000);
    float detAng = random(0.001);

    float x = random(width);
    float y = random(height);

    //PGraphics img = images[int(random(images.length))];

    float rot = 0;//random(-0.1, 0.1)*0.05;
    float vel = random(10);

    int actSeed = int(random(999999));

    for (int j = 0; j < 500; j++) {
      float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      pushMatrix();
      translate(x, y);
      rotate(ang+rot*j);

      randomSeed(actSeed);
      float ic = random(colors.length);
      float dc = random(0.1);
      for (int i = 0; i < 20; i++) {
        float ss = random(80)*random(1)*random(1)*0.1;
        fill(getColor(ic+dc*i), random(random(120), 255));
        ellipse(random(ww), random(hh), ss, ss);
      }

      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
