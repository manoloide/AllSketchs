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
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  blendMode(ADD);

  noStroke();
  //beginShape();
  float dc = random(0.003, 0.004)*0.7;
  float ds = random(0.002, 0.004)*2;
  float ds2 = random(0.002, 0.004)*5;
  for (int i = 0; i < 600000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5)*random(1)*(random(1, 1.4)+noise(x*ds, y*ds)*4);
    s *= pow(max(noise(x*ds2, y*ds2)*1.1-0.1, 0), 1.2);
    fill(getColor(noise(x*dc, y*dc)*colors.length*2+random(1)), random(70, 110));
    pushMatrix();
    translate(x, y);
    rotate(PI*random(-0.08, 0.08)*random(1));
    ellipse(x, y, s*0.4, s*random(6)*random(1, random(random(12))));
    popMatrix();
  }


  for (int i = 0; i < 60000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5);//random(2)*random(1)*(random(1, 1.4)+noise(x*ds, y*ds)*4);
    float n = noise(x*ds, y*ds);
    fill(getColor(noise(x*dc, y*dc, 40)*colors.length*2+random(1)+2), random(70, 110)*3.4);
    if (n < 0.4) {
      s *= pow(map(n, 0, 0.4, 1, 0), 0.4);
      ellipse(x, y, s, s*0.9);
    }
  }
  //endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#F71630, #3A6B58, #82B754, #E8DD4C, #CE7B0E};
int colors[] = {#523868, #D11D02, #BC8009, #5496A8};
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
  return lerpColor(c1, c2, pow(v%1, 1.6));
}
