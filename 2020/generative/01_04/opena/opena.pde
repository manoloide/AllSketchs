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
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  noiseDetail(4);

  background(255);

  detAng = random(0.001);
  detDes = random(0.02);
  detAng2 = random(0.001);
  detDes2 = random(0.01);


  int sub = int(random(60, 90))*2;
  float ss = width*1./sub;

  fill(0);
  for (int i = -20; i < sub+20; i++) {
    fill(((i+200)%2)*255);
    //stroke(((i+201)%2)*255);
    beginShape(QUAD_STRIP);
    for (float j = -100; j < height+100; j+=2) {
      float x1 = i*ss;
      float x2 = x1+ss;
      PVector p1 = def(x1, j);
      PVector p2 = def(x2, j);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
    }
    endShape(CLOSE);
  }
}


float detAng = random(0.001);
float detDes = random(0.02);
float detAng2 = random(0.001);
float detDes2 = random(0.01);

PVector def(float x, float y) {

  float ang = noise(x*detAng, y*detAng)*TAU*3;
  float des = constrain((noise(x*detDes, y*detDes)-0.6)*4, 0, 1)*40;
  x += cos(ang)*des;
  y += sin(ang)*des;
  ang = noise(x*detAng2, y*detAng2)*TAU*3;
  des = constrain((noise(x*detDes2, y*detDes2)-0.2)*3, 0, 1)*160;
  x += cos(ang)*des;
  y += sin(ang)*des;

  float dd = dist(x, y, width*0.5, height*0.5)*220./width;
  float aa = atan2(height*0.5-y, width*0.5-x);
  x += cos(aa)*dd;
  y += sin(aa)*dd;

  return new PVector(x, y);

  //x = lerp(x, ox, abs(vx*2-1));
  //y = lerp(y, oy, abs(vy*2-1));
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#F4EFA1, #E8E165, #DC4827, #5779A2, #031A01};
//int colors[] = {#D9BCBC, #CAB4B0, #3E87B2, #1E4F42, #F37C0A};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};

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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
