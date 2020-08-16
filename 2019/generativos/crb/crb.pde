import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage image;

void settings() {
  image = loadImage("quique.jpg");

  scale = 1;//nwidth/swidth;
  size(int(image.width*scale), int(image.height*scale), P2D);
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
  background(#faf9f7);

  float detSca = 0.01;

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1400000; i++) {
    float x = random(width);
    float y = random(height);
    float s = pow(noise(x*detSca, y*detSca), 2.2)*40+40;


    color col = image.get((int)x, (int)y);
    float bri = brightness(col)/255.;

    s *= map(bri, 0, 1, 0.07, 0.12);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < (s+o.z)*0.5) {
        add = false;
        break;
      }
    }

    if (add) points.add(new PVector(x, y, s));
  }

  float detAng = 0.002;


  float detAng1 = 0.002;
  float desAng1 = random(1000);
  float detAng2 = 0.002;
  float desAng2 = random(1000);
  float detAng3 = 0.002;
  float desAng3 = random(1000);


  float detSep = 0.002;
  float desSep = random(1000);

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x;//random(width); 
    float y = p.y;//random(height);
    float s = p.z;//random(20, 250);
    color col = image.get((int)x, (int)y);
    float sep = 0;//0.5+noise(desSep+x*detSep, desSep+y*detSep)*3;
    float bri = brightness(col);
    sep = 0.6+pow(bri*1./256, 1.7)*4.5;
    int c = int(s/sep);//int(random(3, 6));
    float a = noise(x*detAng, y*detAng)*TAU*2;

    //stroke(col, 140);
    stroke(0, 140);
    float ss = s*1.8;
    float er1 = 0.5;
    float er2 = 0.5;
    //if (red(col)/256. < 0.8) 
    //if (noise(desAng1+x*detAng1, desAng1+y*detAng1) < 0.8) 
    if (bri < 250)
      lines(x+random(-er1, er1), y+random(-er1, er1), ss, c, a);
    //if (green(col)/256. < 0.8) 
    //if (noise(desAng2+x*detAng2, desAng2+y*detAng2) < 0.8) 
    if (bri < 240)
      lines(x+random(-er1, er1), y+random(-er1, er1), ss, c, a-TAU*(2.0/3)+random(-er2, er2));
    //if (blue(col)/256. < 0.8) 
    //if (noise(desAng3+x*detAng3, desAng3+y*detAng3) < 0.8) 
    if (bri < 230)
      lines(x+random(-er1, er1), y+random(-er1, er1), ss, c, a+TAU*(2.0/3)+random(-er2, er2));
  }
}

void lines(float x, float y, float s, int c, float a) {
  float r = s*0.5;
  float a2 = a+HALF_PI;
  //noFill();
  //noStroke();
  //fill(0);
  //ellipse(x, y, s*0.6, s*0.6);

  float er = r*0.08;
  float dd = 0.5*((c+1)%2);
  float bri = brightness(image.get((int)x, (int)y));

  r = map(bri, 0, 255, r*1.1, r*0.8);
  for (int i = 0; i < c; i++) {
    float r1 = r;
    float x1 = x; 
    float y1 = y;
    do {
      r1 *= random(0.5, 0.9);
      x1 = x+cos(a+PI)*r1+random(-er, er);
      y1 = y+sin(a+PI)*r1+random(-er, er);
    } while (abs(bri-brightness(image.get((int)x1, (int)y1))) > 30);
    float r2 = r;
    float x2 = x; 
    float y2 = y;
    do {
      r2 *= random(0.5, 0.9);
      x2 = x+cos(a)*r2+random(-er, er);
      y2 = y+sin(a)*r2+random(-er, er);
    } while (abs(bri-brightness(image.get((int)x2, (int)y2))) > 30);
    float dx = cos(a2)*s*(i*1.-c/2+dd)/c;
    float dy = sin(a2)*s*(i*1.-c/2+dd)*1./c;
    line(dx+x1, dy+y1, dx+x2, dy+y2);
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
int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
