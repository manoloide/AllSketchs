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

  background(180);


  translate(width*0.5, height*0.5);

  ArrayList<PVector> points = new ArrayList<PVector>();
  noStroke();
  for (int i = 0; i < 800; i++) {
    float ss = 16*(i%8+1);
    float xx = random(ss, width-ss)-width*0.5;
    float yy = random(ss, height-ss)-height*0.5;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(xx, yy, o.x, o.y) < (ss+o.z)*1.1) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(xx, yy, ss));
      circle(xx, yy, ss);
    }
  }

  noStroke();
  circle(0, 0, width*0.42);
}

void circle(float xx, float yy, float radius) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float det = random(0.0003);
  float det2 = random(0.0008);
  float ic = random(colors.length);
  float dc = random(100);
  int res = int(PI*radius*radius*0.1);
  int col = rcol();
  for (int i = 0; i < res; i++) {
    float a = random(TAU);
    float d = sqrt(random(random(random(0.5, 1)), 1));
    float x = xx+cos(a)*d*radius;
    float y = yy+sin(a)*d*radius;
    float s = random(2, 6)*radius*0.12*pow((1-d*0.999), 0.9)*lerp(0.2, 1, pow(noise(x*det2, y*det2), 0.8));
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j); 
      if (dist(x, y, p.x, p.y) < (s+p.z)*(0.56)) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
      float dt = det*s*0.1;
      float dd = s*random(0.05);
      fill(0, 40);
      ellipse(x+dd*0.2, y+dd, s, s);
      float alp = 240;
      fill(getColor((ic+noise(dc+x*dt, dc+y*dt, dc+s*dt))*colors.length*3), alp);
      ellipse(x, y, s, s);
      //fill(rcol());
      //arc(x, y, s*0.96, s*0.96, random(TAU), random(TAU));
      //fill(getColor((ic+noise(dc+x*dt, dc+y*dt, dc+s*dt))*colors.length*3));
      //arc(x, y, s*0.2, s*0.2, random(TAU), random(TAU));
    }
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x;
    float y = p.y;
    float s = p.z;
    float dd = s*random(0.05);
    if (random(1) < 0.2) {
      fill(0, 80);
      ellipse(x+dd*0.2, y+dd, s*0.2, s*0.2);
      fill(col);
      ellipse(x, y, s*0.2, s*0.2);
      stroke(col, 140);
      float aa = atan2(y, x);
      line(x, y, x+cos(aa)*s*4, y+sin(aa)*s*4);
      noStroke();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 0.2));
}
