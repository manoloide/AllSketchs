int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
}


void generate() { 

  println(seed);
  randomSeed(seed);
  scale(scale);

  //blendMode(ADD);

  background(0);

  DoubleNoise dn = new DoubleNoise();
  dn.noiseDetail(2);
  float detAng = random(0.004, 0.006)*0.1;
  float desAng = random(1000);


  float desCol = random(1000);


  float detAmp = random(0.004, 0.006)*0.1;
  float desAmp = random(1000);



  float detDes = random(0.004, 0.006)*0.1;
  float desDes = random(1000);

  int sub = 400;

  noiseDetail(2);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      stroke(rcol(), random( 250)*random(0.5));
      noFill();
      double x = width*lerp(-0.05, 1.05, (i+random(-0.3, 0.3))*1./sub);
      double y = height*lerp(-0.05, 1.05, (j+random(-0.3, 0.3))*1./sub);

      float detCol = map((float)dn.noise(desAmp+x*detAmp, desAmp+x*detAmp), 0, 1, 0.001, 0.002);

      float ic = (float)dn.noise(desCol+x*detCol, desCol+y*detCol)*colors.length*2;
      float dc = random(0.9)*random(0.2);
      strokeWeight(random(0.2, random(0.4, 1.8)));
      float alp = random(40, 250)*random(0.1, 0.9);
      float osc = random(10.1)*random(1)*random(0.5, 1);
      float velX = random(0.4, 1.8)*0.8;
      float velY = random(0.4, 1.8)*0.8;
      beginShape();
      for (int k = 0; k < 40; k++) {
        float des = lerp(0.01, 2, (float)dn.noise(desDes+x*detDes, desDes+x*detDes));
        double a = dn.noise(dn.noise(200+Math.cos(dn.noise(desAng+x*detAng, desAng+y*detAng)*TAU*12)*des))*TAU*20;
        stroke(getColor(ic+dc*k), alp*cos(k*osc));
        vertex((float)x, (float)y);
        x += Math.cos(a)*velX;
        y += Math.sin(a)*velY;//*1.6;
      }
      endShape();
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#B0E7FF, #0c286b, #277a5c, #F98FC0, #f14309};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
int colors[] = {#eaf762, #E5463E, #366A51, #141c82};
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
