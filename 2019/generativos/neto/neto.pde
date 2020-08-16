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

  randomSeed(seed);
  noiseSeed(seed);

  int back = lerpColor(color(#E1E8E0), getColor(), random(0.05));

  background(back);

  noStroke();
  for (int i = 0; i < 0; i++) {
    float x = random(width);
    x -= x%20;
    float y = random(width);
    y -= y%20;
    float s = random(20)*random(0.4);
    fill(rcol(), random(180)*random(0.4, 1));
    ellipse(x, y, s, s);
  }

  noStroke();
  for (int i = 0; i < 4; i++) {
    float xx = random(width);
    float yy = random(height);
    
    xx -= xx%20;
    yy -= yy%20;
    
    float ss = random(width)*random(0.1, 1);
    fill(rcol(), random(10, 200));
    ellipse(xx, yy, ss, ss);
    
    noStroke();
    //arc2(xx, yy, ss, ss*0.96, 0, TAU, color(60), random(8, 20), 0);
    arc2(xx, yy, ss, ss*0.8, 0, TAU, color(40), random(8, 20), 0);
    arc2(xx, yy, ss, ss*1.4, 0, TAU, color(240), random(30, 60), 0);
  }

  stroke(255, 100);
  for (int j = 0; j <= height; j+=10) {
    for (int i = 0; i <= width; i+=10) {
      point(i, j);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2){
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.25, 2));
  for(int i = 0; i < cc; i++){
     float ang1 = map(i+0, 0, cc, a1, a2); 
     float ang2 = map(i+1, 0, cc, a1, a2);
     
     beginShape();
     fill(col, alp1);
     vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
     vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
     fill(col, alp2);
     vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
     vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
     endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
