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

  blendMode(ADD);

  background(8);
  float det = random(0.004);
  float detWei = random(0.01);

  float detAng = random(0.001);
  float detDes = random(0.02);
  float detAng2 = random(0.001);
  float detDes2 = random(0.01);
  float bb = 20;
  for (int i = 0; i < 180000*40; i++) {
    float vx = random(1);
    float vy = random(1);
    float x = lerp(bb, width-bb, vx);
    float y = lerp(bb, height-bb, vy);
    float ox = x;
    float oy = y;
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

    x = lerp(x, ox, abs(vx*2-1));
    y = lerp(y, oy, abs(vy*2-1));

    float colVal = random(random(1))+noise(x*det, y*det)*colors.length*2;
    int col = getColor(colVal+ang*1.2);    
    col = color(255-ang);
    col = lerpColor(col, color(0), random(0.58, 0.68)+0.0);
    stroke(col, random(180, 240)*0.5);
    strokeWeight(noise(x*detWei, y*detWei)*1.2+0.5);
    point(x, y);
    if (random(1) < 0.02) point(x, y);
  }
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
