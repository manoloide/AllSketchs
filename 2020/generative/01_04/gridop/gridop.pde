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
  background(#80ff00);

  int cc = 64;//int(random(30, 50)*0.8);
  float ss = width*(1./cc);

  float det1 = random(1);
  float det2 = random(0.01);
  
  float amp1 = random(2);
  float amp2 = random(2);
  float amp3 = random(2);

  noStroke();
  fill(0);
  for (int j = 0; j < cc; j++) {
    float v1 = noise(j*det1)*amp1;//j*1./cc;//noise(j*det);;//cos(j*2)*0.5+0.5;


    beginShape(QUAD_STRIP);
    fill(0);
    for (int i = 0; i <= width; i+=1) {
      float v2 = noise(i*det2)*amp2;//i*(1./width);
      float y1 = ss*(j);
      float y2 = ss*(j+v1*v2);
      vertex(i, y1);
      vertex(i, y2);
    }
    endShape();

    beginShape(QUAD_STRIP);
    fill(255);
    for (int i = 0; i <= width; i+=1) {
      float v2 = noise(i*det2)*amp3;// 1-i*(1./width);
      float y1 = ss*(j);
      float y2 = ss*(j+v1*v2);
      vertex(y1, i);
      vertex(y2, i);
    }
    endShape();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#ff0000, #00ff00, #0000ff};
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
  return lerpColor(c1, c2, pow(v%1, 0.3));
}
