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
 
  int sub = 240; 
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
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float ss = max(r.w, r.h)*random(1, random(1, 1.8))*0.6;
    arc2(r.x, r.y, ss, ss*3, 0, TAU, rcol(), 30, 0);
    fill(250, 250, 240, 240);
    ellipse(r.x, r.y, ss, ss);
    float amp = random(0.5, 0.8)*0.6;
    if (random(1) < 0.5) {
      fill(rcol(), 250);
      ellipse(r.x, r.y, r.w*amp, r.w*amp);
      //arc2(r.x, r.y, r.w, r.w*2, 0, TAU, rcol(), random(50), 0);
      fill(rcol(), 250);
      ellipse(r.x, r.y, r.h*amp, r.h*amp);
      //arc2(r.x, r.y, r.h, r.h*5, 0, TAU, rcol(), random(50), 0);
    } else {
      fill(rcol(), 250);
      ellipse(r.x, r.y, r.h*amp, r.h*amp); 
      //arc2(r.x, r.y, r.h, r.h*2, 0, TAU, rcol(), random(50), 0);
      fill(rcol(), 250);
      ellipse(r.x, r.y, r.w*amp, r.w*amp);
      //arc2(r.x, r.y, r.w, r.w*5, 0, TAU, rcol(), random(50), 0);
    }
    fill(rcol(), 250);
    ellipse(r.x, r.y, r.w*amp, r.h*amp);
    fill(rcol(), 250);
    ellipse(r.x, r.y, ss*0.02*amp, ss*0.004*amp);
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

int colors[] = {#A19CA0, #A98D8C, #9E6463, #604242, #000000, #B94C4F, #FAED7D, #7A8AD5};
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
