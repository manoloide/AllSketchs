import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth = 960; 
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
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());
  //background(0);

  desAng = random(1000);
  detAng = random(0.002, 0.003)*2;
  desDes = random(1000);
  detDes = random(0.002, 0.003)*1;


  for (int i = 0; i < 20; i++) {
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);


    x1 = lerp(x1, width*0.5, random(0.5, 1.2));
    y1 = lerp(y1, height*0.5, random(0.5, 1.2));
    x2 = lerp(x2, width*0.5, random(0.5, 1.2));
    y2 = lerp(y2, height*0.5, random(0.5, 1.2));

    float cx = lerp(x1, x2, 0.5);
    float cy = lerp(y1, y2, 0.5);

    float mul = random(0.1, 1);
    mul = 0.9;
    mul = random(0.1, 0.4);
    x1 = lerp(x1, cx, mul);
    x2 = lerp(x2, cx, mul);
    y1 = lerp(y1, cy, mul);
    y2 = lerp(y2, cy, mul);

    float det1 = random(0.002)*random(1);
    float des1 = random(1000);
    float det2 = random(0.002)*random(1);
    float des2 = random(1000);

    float ic1 = random(colors.length);
    float dc1 = random(0.01)*random(1);
    float va1 = random(0.1)*random(0.2, 1);

    float ic2 = random(colors.length);
    float dc2 = random(0.01)*random(1);
    float va2 = random(0.1)*random(0.2, 1);

    float vel = random(random(1, 2), 2);

    //if (random(1) < 0.5) vel *= random(0.1, 1);

    noFill();

    float md1 = random(1, random(1, 1.005));
    float md2 = random(1, random(1, 1.005));

    PVector p1, p2;

    float lar = random(300, 500)*0.5;

    float a1 = random(TAU);
    float a2 = random(TAU);

    a1 = a2;

    for (int k = 0; k < lar; k++) {

      dc1 *= md1;
      dc2 *= md2;

      //p1 = def(x1, y1);
      //p2 = def(x2, y2);
      p1 = new PVector(x1, y1);
      p2 = new PVector(x2, y2);


      beginShape(LINES);
      stroke(getColor(ic1+dc1*k), cos(k*va1)*128+100); 
      vertex(p1.x, p1.y);
      stroke(getColor(ic2+dc2*k), cos(k*va2)*128+100); 
      vertex(p2.x, p2.y);
      endShape();

      a1 = noise(des1+x1*det1, des1+y1*det1)*TAU*10;
      a2 = noise(des2+x2*det2, des2+y2*det2)*TAU*10;

      x1 += cos(a1)*vel;
      y1 += sin(a1)*vel;
      x2 += cos(a2)*vel;
      y2 += sin(a2)*vel;

      /*
      if(random(1) < 0.01) ellipse(x1, y1, 20, 20);
       if(random(1) < 0.01) ellipse(x2, y2, 20, 20);
       */
    }
  }
}

float desAng = random(0.0001, 0.0003);
float detAng = random(0.0001, 0.0003);
float desDes = random(0.0001, 0.0003);
float detDes = random(0.0001, 0.0003);

PVector def(float x, float y) {
  float ang = (float)SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng);
  float des = (float)SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*50;
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#F94F00, #F9BD18, #4646EA, #1E1E1E, #EDEDED};
//int colors[] = {#0C4BDB, #B673F6, #FA4638, #FDE216};
int colors[] = {#0C4BDB, #B673F6, #36F98E, #FCF52A, #FF89D2};
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
  return lerpColor(c1, c2, pow(v%1, 1.8));
}
