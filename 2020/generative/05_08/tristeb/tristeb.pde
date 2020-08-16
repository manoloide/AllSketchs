import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 94436;//int(random(999999));

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

  hint(DISABLE_DEPTH_TEST);
  hint(DISABLE_DEPTH_MASK);


  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(#FFB0D0);

  float detH = random(0.0005);

  noStroke();
  strokeWeight(0.6);

  for (int i = 0; i < 1200; i++) {
    float x = random(1);
    x *= width;
    float vy = noise(x*detH)*0.2+random(1.2)*random(1);
    float y = height*vy;
    float s = 24*pow(vy, 2.8)*random(0.8, 1.8);
    noStroke();
    fill(rcol());
    hoja(x, y, 0.5+s);

    if (random(1) < 0.1) {
      float dm = 0.025*0.2;//random(0.02, 0.03)*0.2;
      float ang = -noise(x*dm, y*dm)-HALF_PI*0.7;
      float amp = random(0.3, 2.5)*0.6; 

      float detCol = random(0.02)*0.3;
      float desCol = noise(x*detCol, y*detCol)*10;

      float v = random(0.9, 1)*(0.2+vy*0.8)*0.6;
      int rep = int(random(1000, 2000)*1.4);
      float osc = random(2, 3)*0.6;
      for (int j = 0; j < rep; j++) {
        float noi = noise(x*dm, y*dm);
        ang += (noi*0.1-0.05)*0.08;
        x += cos(ang)*v;
        y += sin(ang)*v;
        fill(getColor(j*v*detCol+desCol+ang+noi*20), 250);
        stroke(255, (cos(j*osc)*40+40+random(8))*0.6);
        pushMatrix();
        translate(x, y);
        rotate(ang+HALF_PI);
        float ss = s*10*(amp+0.5+cos(j*0.03)*0.05);
        ellipse(0, 0, ss, ss*(0.6+vy*0.4));
        popMatrix();
        s *= 0.998;
      }
    }
  } 


  int cc = 10;
  float cx = width*0.5;
  float cy = height*0.5;
  float ss = width*0.3;


  strokeWeight(0.8);
  pushMatrix();
  translate(cx, cy);
  rotate(HALF_PI);
  form(0, 0, ss*3);
  rotate(HALF_PI);
  form(0, 0, ss*2);
  popMatrix();

  for (int i = 0; i < cc; i++) {
    float s = ss*pow(((i-cc)*(1./cc)), 2);
    fill(rcol());
    //ellipse(cx, cy, s, s);
  }
}

void hoja(float x, float y, float s) {
  int res = int(s*PI*2);
  float da = TAU/res;
  float r = s*0.5;
  beginShape();
  for (int i = 0; i <res; i++) {
    float a = da*i;
    if (random(1) < 0.5) continue;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }  
  endShape();
}


void form(float cx, float cy, float size) {

  int count = 24;
  noStroke();
  float amp = random(1, random(1, 2.6));//random(1, 2);
  float ma = random(0.98, 1.02);

  float h1 = 0;//size*random(0.3)*random(1);
  float h2 = 0;//size*random(0.3);

  for (int i = 1; i <= count; i++) {
    float v1 = 1-(i*1.0/count);
    float s = size*pow((1-v1), 0.8);
    stroke(255, random(220)*random(0.6, 1));
    fill(rcol(), random(250, 255));
    float w = s*v1*amp;
    float h = s;
    float ay = lerp(cy+h1, cy-h2, v1);
    ellipse(cx, ay, w, h);


    if (random(1) < 0.5) {
      float ss = min(w, h);
      float ra = random(TAU); 

      float xx = cx+cos(ra)*w*0.5;
      float yy = ay+sin(ra)*h*0.5;
      ellipse(xx, yy, ss, ss);
      fill(rcol());
      noStroke();
      ellipse(xx, yy, ss*0.02, ss*0.02);
      amp *= ma;

      stroke(255, 60);
      float aaa = atan2(yy-cy, xx-cx);
      float sss = ss*0.25;

      float x2 = xx+cos(aaa)*sss;
      float y2 = yy+sin(aaa)*sss;
      line(xx, yy, x2, y2);
      ellipse(x2, y2, ss*0.4, ss*0.4);
      noStroke();
      fill(0);
      ellipse(x2, y2, ss*0.3, ss*0.3);
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#272932, #4D7EA8, #828489, #9E90A2, #B6C2D9, #2FE6DE, #18F2B2, #FFFBFF, #FEFEFF};
//int colors[] = {#272932, #4D7EA8, #828489, #9E90A2, #B6C2D9, #2FE6DE, #18F2B2, #FFFBFF, #FEFEFF};
int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
} 
