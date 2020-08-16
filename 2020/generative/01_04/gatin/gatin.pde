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

  int cw = int(random(12, 18)*0.3)*22;
  float sw = width*1./(cw);
  int ch = int(random(12, 18)*0.3)*22;
  float sh = height*1./(ch);

  float detCol = random(0.001);

  noStroke();
  float ic = random(colors.length);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float xx = (i)*sw;
      float yy = (j)*sh;

      float vw = i*(1./cw);
      float vh = j*(1./ch);

      float triw = abs((vw*4)%2-1)*0.5;
      float trih = abs((vh*4)%2-1)*0.5;

      float desCol = (i+j)%2;
      float noi = (float) noise(200+xx*detCol, 100+yy*detCol, seed*detCol);
      fill(getColor((i+j)%2 +(noi)*colors.length*4));

      beginShape();
      vertex(xx-sw*0.5, yy);
      vertex(xx, yy-sh*0.5);
      vertex(xx+sw*0.5, yy);
      vertex(xx, yy+sh*0.5);
      endShape();

      /*
      if (random(1) < 0.5) {
       fill(rcol());
       ellipse(xx+ss*0.5, yy+ss*0.5, ss, ss);
       }
       
       if (random(1) < 0.5) {
       fill(rcol());
       ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.5, ss*0.5);
       }
       
       
       float noi = noise(xx*det, yy*det)*8;
       //noi = 0;
       int rnd = int(noi+i%2+j*2)%4;//int(random(4));
       if (random(1) < 0.25) rnd = -1;
       if (rnd == 3) {    
       fill(rcol());
       arc(xx, yy, ss*2, ss*2, 0, HALF_PI);
       fill(rcol());
       arc(xx, yy, ss*1, ss*1, 0, HALF_PI);
       fill(rcol());
       arc(xx, yy, ss*0.5, ss*0.5, 0, HALF_PI);
       fill(rcol());
       arc(xx, yy, ss*0.25, ss*0.25, 0, HALF_PI);
       }
       if (rnd == 2) {
       fill(rcol());
       arc(xx+ss, yy, ss*2, ss*2, HALF_PI, PI);
       fill(rcol());
       arc(xx+ss, yy, ss*1, ss*1, HALF_PI, PI);
       fill(rcol());
       arc(xx+ss, yy, ss*0.5, ss*0.5, HALF_PI, PI);
       fill(rcol());
       arc(xx+ss, yy, ss*0.25, ss*0.25, HALF_PI, PI);
       }
       if (rnd == 1) {
       fill(rcol());
       arc(xx, yy+ss, ss*2, ss*2, PI*1.5, TAU);
       fill(rcol());
       arc(xx, yy+ss, ss*1, ss*1, PI*1.5, TAU);
       fill(rcol());
       arc(xx, yy+ss, ss*0.5, ss*0.5, PI*1.5, TAU);
       fill(rcol());
       arc(xx, yy+ss, ss*0.25, ss*0.25, PI*1.5, TAU);
       }
       if (rnd == 0) {
       fill(rcol());
       arc(xx+ss, yy+ss, ss*2, ss*2, PI, PI*1.5);
       fill(rcol());
       arc(xx+ss, yy+ss, ss*1, ss*1, PI, PI*1.5);
       fill(rcol());
       arc(xx+ss, yy+ss, ss*0.5, ss*0.5, PI, PI*1.5);
       fill(rcol());
       arc(xx+ss, yy+ss, ss*0.25, ss*0.25, PI, PI*1.5);
       }
       */
    }
  }

  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float xx = (i)*cw;
      float yy = (j)*ch;
      ellipse(xx, yy, cw*0.1, ch*0.1);
    }
    //}
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#284E34, #BCA978, #896F3D, #38271D, #BF0624};

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
  return lerpColor(c1, c2, v%1);
}
