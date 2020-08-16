import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brushes[];

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

PImage img;
void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(20);


  PGraphics back = createGraphics(width, height);
  int div = 8;
  float ss = width*1./div;
  back.beginDraw();
  back.noStroke();
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      float xx = i*ss;
      float yy = j*ss;
      back.fill(rcol());
      back.rect(xx, yy, ss, ss);
      int cc = 8;
      float s = ss*1./cc;
      back.fill(rcol(), 200+random(55));
      for (int l = 0; l < cc; l++) {
        for (int k = 0; k < cc; k++) {
          if ((l+k+i+j)%2 == 0) continue;
          back.rect(xx+l*s, yy+k*s, s, s);
        }
      }
    }
  }
  back.endDraw();

  img = back.get();

  //image(img, 0, 0);


  float detAng = random(0.02)*random(0.2, 1);
  float desAng = random(10000);

  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  int ccc = 1000000; //1000000
  for (int i = 0; i < ccc; i++) {
    float xx = random(width);
    float yy = random(height);
    float ww = random(4, 12)*random(1);
    float hh = random(20)*random(1);
    hh = ww*random(0.1, 0.3);

    int col = getCol(xx+ss*random(-0.02, 0.02), yy+ss*random(-0.02, 0.02));
    float brig = brightness(col)/255.;
    tint(col, random(255)*random(1));

    if (random(1) < 0.1) blendMode(ADD);
    else blendMode(NORMAL);
    pushMatrix();
    translate(xx+random(-2, 2), yy+random(-2, 2));
    rotate(noise(desAng+xx*detAng, desAng+yy*detAng)*TAU*10+brig*8+random(-0.2, 0.2));
    //rect(0, 0, ww, hh);
    float sca = 2+brig+random(2);
    sca *= random(0.4, 1);
    image(brushes[int(random(4))], 0, 0, ww*sca, hh*sca);
    popMatrix();
  }
}

color getCol(float x, float y) {
  int xx = int(map(x, 0, width, 0, img.width*2));
  int yy = int(map(y, 0, height, 0, img.height*2));
  return img.get(xx, yy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#F98806, #1E4694, #EAF0F5, #846A6F};
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
