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

  background(0);
  beginShape();
  fill(rcol());
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape();

  float det = random(0.005);
  
  float detCol1 = random(0.02);
  float detCol2 = random(0.02);

  int sca = 4;
  noStroke();
  rectMode(CENTER);
  float exp = int(random(6));
  for (int j = 0; j < height; j+=3*sca) {
    for (int i = 0; i < width; i+=3*sca) {
      int cc = int(noise(det*i, det*j)*30-8);
      for (int k = 0; k < cc; k++) {
        fill(rcol());
        int xx = i+int(random(3))*sca;
        int yy = j+int(random(3))*sca; 
        pushMatrix();
        translate(xx, yy);
        rotate(int(random(8))*HALF_PI*0.5);
        beginShape();
        fill(getColor(noise(xx*detCol1, yy*detCol1)*colors.length));
        vertex(-sca*exp, -sca*exp);
        vertex(+sca*exp, -sca*exp);
        fill(getColor(noise(1000+xx*detCol2, yy*detCol2)*colors.length));
        vertex(+sca*exp, +sca*exp);
        vertex(-sca*exp, +sca*exp);
        endShape();
        popMatrix();
        //rect(xx, yy, sca*2, sca*2);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#D84004, #E8E8E8, #411BD6, #242B24, #EFEA53};
int colors[] = {#F0F0F0, #F7C900, #005AA6, #E73C2B};
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
