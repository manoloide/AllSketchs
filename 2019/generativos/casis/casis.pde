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


  blendMode(NORMAL);
  //background(getColor());
  background(0);

  //blendMode(ADD);
  noFill();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(0.2, 1)*2000*random(0.5, 1)); 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.5, 1)*random(0.2)));
    Rect r = rects.get(ind);

    //r.x += random(-10, 10)*random(1);
    //r.y += random(-10, 10)*random(1);

    if (random(1) < 0.5) {
      float mw = r.w*random(0.2, 0.8);
      rects.add(new Rect(r.x, r.y, mw, r.h));
      rects.add(new Rect(r.x+mw, r.y, r.w-mw, r.h));
    } else {
      float mh = r.h*random(0.2, 0.8);  
      rects.add(new Rect(r.x, r.y, r.w, mh));
      rects.add(new Rect(r.x, r.y+mh, r.w, r.h-mh));
    }

    rects.remove(ind);
  }

  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    
    if(random(1) > 0.92 ) continue;
    fill(0, 40);
    rect(r.x+random(-10, 10)*random(0.5, 1), r.y+random(-10, 10)*random(0.5, 1), r.w, r.h);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);



    int cw = int(random(2, 5));
    int ch = int(random(5, 20));
    float dw = r.w/(cw+2);
    float dh = r.h/(ch+2);
    float ww = r.w*random(0.1, 0.2)*0.4;
    float hh = r.w*random(0.1, 0.2)*0.4;
    float dx = random(-4, 4);
    float dy = random(-4, 4);
    for (int k = 0; k <= ch; k++) {
      for (int j = 0; j <= cw; j++) {
        float xx = r.x+(j+0.5)*dw;
        float yy = r.y+(k+0.5)*dh;
        fill(0, 10);
        rect(xx+dx, yy+dy, ww, hh);

        fill(0);
        rect(xx, yy, ww, hh);
      }
    }

    fill(rcol());
    beginShape();
    float h = r.w*random(0.05, 0.15)*0.1;
    float s = h*random(-1, 1);
    vertex(r.x-r.w*0.5-1, r.y-r.h*0.5);
    vertex(r.x+r.w*0.5+1, r.y-r.h*0.5);
    vertex(r.x+r.w*0.5+s+1, r.y-r.h*0.5+h);
    vertex(r.x-r.w*0.5+s-1, r.y-r.h*0.5+h);
    endShape();
  }
  rectMode(CORNERS);
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.25, 2));
  for (int i = 0; i < cc; i++) {
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

//int colors[] = {#F7A625, #D60606, #E58BA8, #87426D, #1643A3, #2F512C};
int colors[] = {#F7A625, #D60606, #E58BA8, #1643A3};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length), 1);
}
int getColor(float v, float p) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, p));
}
