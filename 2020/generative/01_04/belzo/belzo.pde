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

ArrayList<PVector> points;

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  background(0);//0);//rcol());

  //blendMode(ADD);

  //blendMode(ADD);
  //hint(DISABLE_DEPTH_TEST);

  /*
  float fov = PI/random(1.4, 3);
   float cameraZ = (height/2.0) / tan(fov/2.0);
   perspective(fov, float(width)/float(height), 
   cameraZ/10.0, cameraZ*10.0);
   */


  points = new ArrayList<PVector>();
  for (int i = 0; i < 20; i++) {
    float xx = random(width);//random(random(0, random(0.5)), random(random(0.5, 1), 1))*width;
    float yy = random(height);//random(random(0, random(0.5)), random(random(0.5, 1), 1))*height;
    float ss = random(60, 380);
    points.add(new PVector(xx, yy, ss));
  }

  for (int i = 0; i < 40; i++) {
    flower(width*random(1), height*random(1), width*random(0.4));
  }
}

void flower(float x, float y, float s) {

  x -= s*0.5;
  y -= s*0.5;

  float detStr = random(0.001);
  float sep = 10; 
  int cc = int(s/sep);
  //strokeWeight(1.4);
  noStroke();
  float strr = random(0.6, 0.8);
  float ampD = 0.1;
  float oscZ = 1./(s/cc);

  //fill(#000acf, 150);
  //stroke(255, 80);
  noFill();
  //fill(rcol());
  fill(255);

  float ic = random(colors.length);
  float dc = random(0.003)*random(1)*random(1);
  for (int i = 0; i <= cc; i++) {

    int div = int(s*8);
    float dd = s/div; 
    beginShape(QUAD_STRIP);
    for (int j = 0; j < div; j++) {
      float yy = y+j*dd;
      float xx = x+i*sep;
      float vv = 1-min(abs((i*1./cc)*2-1), abs((j*1./div)*2-1));
      float noi = (float) SimplexNoise.noise(xx*detStr, yy*detStr);
      float str = (0.6+0.4*noi)*strr;
      PVector p1 = def(xx-str, yy, vv);
      PVector p2 = def(xx+str, yy, vv);
      float z = sin((yy*oscZ-HALF_PI)*PI+((i+1)%2)*PI)*ampD;
      //fill(getColor(ic+j*dc));
      fill(getColor(ic+j*dc+(i/2)%2), 250);//,((j/2)%2)*160);
      //fill(((i/5)%2)*255);
      vertex(p1.x, p1.y, z);
      vertex(p2.x, p2.y, z);
    }
    endShape();

    beginShape(QUAD_STRIP);
    for (int j = 0; j <= div; j++) {
      float xx = x+j*dd;
      float yy = y+i*sep;
      float vv = 1-min(abs((i*1./cc)*2-1), abs((j*1./div)*2-1));
      float noi = (float) SimplexNoise.noise(xx*detStr, yy*detStr);
      float str = (0.6+0.4*noi)*strr;
      PVector p1 = def(xx, yy-str, vv);
      PVector p2 = def(xx, yy+str, vv);
      float z = sin((xx*oscZ-HALF_PI)*PI+(i%2)*PI)*ampD;
      //fill(getColor(ic+j*dc));
      fill(getColor(ic+j*dc+(i/2)%2), 250);//,((j/2)%2)*160);
      //fill(((i/3+1)%2)*255);
      vertex(p1.x, p1.y, z);
      vertex(p2.x, p2.y, z);
    }
    endShape();
  }
}

PVector def(float x, float y, float v) {
  PVector des = new PVector();
  for (int k = 0; k < points.size(); k++) {
    PVector other = points.get(k);
    float dis = dist(x, y, other.x, other.y);
    if (dis < other.z) {
      float vv = dis/other.z;
      float ang = atan2(y-other.y, x-other.x);
      x += cos(ang)*dis*pow((1-vv), 1.3)*v*1.4;
      y += sin(ang)*dis*pow((1-vv), 1.3)*v*1.4;
    }
  }
  return new PVector(x+des.x, y+des.y);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #0c1cad};
//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #062FAA};
//int colors[] = {#ED4715, #FFA3EC, #B0A8FF, #0D110F, #FFB951};
int colors[] = {#8A8DE2, #F9C827, #F2DEE4, #0A1835};
//int colors[] = {#00FF6F, #FF002C, #FFE74A, #ff6eec};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
