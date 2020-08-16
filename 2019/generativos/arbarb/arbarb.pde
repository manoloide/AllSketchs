import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  background(230);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 40; i++) {
    float xx = random(width);
    float yy = random(random(height), height);

    xx -= xx%5;
    yy -= yy%5;

    float ss = map(yy, 0, height, 90, 200);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j); 
      if (dist(xx, yy, o.x, o.y) < 20) {
        add = false;
        break;
      }
    }

    if (add) points.add(new PVector(xx, yy, ss));
  }

  noStroke();
  fill(0);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, p.z*0.1, p.z*0.02);

    three(p.x, p.y, p.z);
  }
}

void three(float x, float y, float s) {
  stroke(0);
  line(x, y, x, y-s);

  int sub = 10; 
  float pwr = random(0.5, 0.8);
  float values[] = new float[sub];
  for (int i = 0; i < sub; i++) {
    values[i] = pow(map(i, 0, sub-1, 0, 1), pwr);
  }

  for (int i = 0; i < sub; i++) {
    ellipse(x, y-values[i]*s, 2, 2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
