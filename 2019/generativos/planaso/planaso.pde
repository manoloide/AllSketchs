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

  background(255);

  //blendMode(ADD);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(10, 10, width-20, height-20));

  for (int i = 0; i < 50; i++) {
    float ss = pow(2, int(random(1, 9)));
    float xx = random(width);
    float yy = random(height);
    xx -= xx%ss;
    yy -= yy%ss;
    fill((random(1) < 0.5)? 0 : 255);
    fill(rcol());
    rect(xx, yy, ss, ss);
  }

  for (int i = 0; i < 50; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);

    float nw = r.w*random(0.2, 0.8);
    float nh = r.h*random(0.2, 0.8);

    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));

    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    if (random(1) < 0.3) {
      fill((random(1) < 0.5)? 0 : 255);
      float ss = min(r.w, r.h)*0.1;
      rect(r.x+r.w*0.5-ss*0.5, r.y+r.h*0.5-ss*0.5, ss, ss);
      fill(0);
      rect(r.x+r.w*0.5-1, r.y+r.h*0.5-1, 2, 2);
      continue;
    }
    fill(rcol());
    //fill((random(1) < 0.5)? 0 : 255);
    rect(r.x+1, r.y+1, r.w-2, r.h-2);
    float ss = min(r.w, r.h)*0.2;
    fill(rcol());
    //ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss, ss);

    fill(0);
    rect(r.x+1, r.y+1, r.w-2, r.h*0.16-2);
    float hh = r.h*random(0.010, 0.014);
    if ((r.x)%(r.w*2) < r.w) rect(r.x+1, r.y+1+r.h*0.19, r.w-2, hh);

    fill((random(1) < 0.5)? 0 : 255);
    //fill(255, 0, 0);
    float h2 = random(r.h*(1-0.28));
    rect(r.x+1, r.y+1+r.h*0.19+hh, r.w-2, h2);

    fill(255);
    hh = r.h*0.28;
    rect(r.x+1, r.y+r.h-hh, r.w-2, hh-2);
  }
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));
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

//int colors[] = {#F33F3E, #0155AD, #277143, #F33F3E, #0155AD, #277143, #F33F3E, #0155AD, #277143, #F1F5F4, #F1F5F4};
int colors[] = {#638995, #6A9796, #FC9371, #CD061A, #470F0E};
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
