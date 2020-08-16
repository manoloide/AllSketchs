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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
}

ArrayList<Rect> rects = new ArrayList<Rect>();

void generate() {

  float fov = PI/random(1.8, 2.1);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  randomSeed(seed);
  noiseSeed(seed);

  lights();
  background(rcol());//#000000);

  translate(width*0.5, height*0.5);
  scale(4);
  translate(-width*0.5, -height*0.5);

  //rotateY(PI*random(-0.05, 0.05));
  rotateX(PI*random(0.19, 0.23));
  translate(0, -100, -200);

  float bb = -40;
  rects.clear();
  rects.add(new Rect(bb, bb-height-bb*2, width-bb*2, height-bb*2));
  rects.add(new Rect(bb-width-bb*2, bb-height-bb*2, width-bb*2, height-bb*2));
  rects.add(new Rect(bb+width-bb*2, bb-height-bb*2, width-bb*2, height-bb*2));
  rects.add(new Rect(bb, bb, width-bb*2, height-bb*2));

  detCol = random(0.01);
  int sub = int(random(400, 600)*30);//60);
  noStroke();
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size())*random(random(0.5), 1));
    Rect r = rects.get(ind);
    boolean hor = true;
    if (r.w/2 > r.h) hor = true;
    if (r.h/2 > r.w) hor = false;
    if (hor) {
      float w = r.w*random(0.4, 0.6);
      rects.add(new Rect(r.x, r.y, w, r.h));
      rects.add(new Rect(r.x+w, r.y, r.w-w, r.h));
    } else {
      float h = r.h*random(0.4, 0.6);
      rects.add(new Rect(r.x, r.y, r.w, h));
      rects.add(new Rect(r.x, r.y+h, r.w, r.h-h));
    }
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.w -= 0.4;
    r.h -= 0.4;
    pushMatrix();
    build(r, false);
    for (int j = 0; j < 4; j++) {
      if (random(1) < 0.2) {
        float mw = random(random(0.2, 0.7), 1);
        float mh = random(random(0.2, 0.7), 1);
        r.x += r.w*(1-mw)*random(1);
        r.y += r.h*(1-mh)*random(1);
        r.w *= mw;
        r.h *= mh;
        build(r, true);
      }
    }
    popMatrix();
  }
}

float detCol; 
void build(Rect r, boolean neon) {
  float hh = min(r.w, r.h)*random(random(0.6, 1));
  pushMatrix();
  float xx = r.x+r.w*0.5;
  float yy = r.y+r.h*0.5;
  translate(xx, yy, hh*0.5);
  //noFill();
  float noi = noise(xx*detCol, yy*detCol);
  int col = getColor(colors.length*noi*2);
  if (neon) col = #222C4B; 
  cube(r.w, r.h, hh, col);
  pushMatrix();
  rotateX(HALF_PI);
  translate(0, 0, -r.h*0.5);
  grid(r.w, hh, 10, 10);
  popMatrix();

  pushMatrix();
  rotateX(HALF_PI);
  rotateY(HALF_PI);
  translate(0, 0, -r.w*0.5-0.01);
  grid(r.h, hh, 10, 10);
  translate(0, 0, +r.w*1.0+0.02);
  grid(r.h, hh, 10, 10);
  popMatrix();

  popMatrix();
  translate(0, 0, hh);
  //rect(r.x, r.y, r.w, r.h);
}

void cube(float w, float h, float d, int col) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;

  int c1 = color(lerpColor(#222C4B, color(0), 0.3));
  int c2 = col;

  beginShape(QUAD);
  fill(c1);
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);

  fill(c1);
  vertex(+mw, -mh, +md);
  vertex(-mw, -mh, +md);
  fill(c2);
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh, -md);
  endShape();

  fill(c1);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  fill(c2);
  vertex(-mw, +mh, -md);
  vertex(+mw, +mh, -md);
  endShape();

  fill(c1);
  vertex(+mw, +mh, +md);
  vertex(+mw, -mh, +md);
  fill(c2);
  vertex(+mw, -mh, -md);
  vertex(+mw, +mh, -md);
  endShape();

  fill(c1);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  fill(c2);
  vertex(-mw, -mh, -md);
  vertex(-mw, +mh, -md);
  endShape();
}

void grid(float w, float h, int cw, int ch) {
  float ww = w/cw;
  float hh = h/ch;
  float mw = min(1, random(0.75, 1));
  float mh = min(1, random(0.75, 1));
  float detCol = random(0.01);
  float desCol = random(1000);

  boolean des = random(1) < 0.5;
  blendMode(ADD);
  for (int j = 0; j < ch; j++) {
    int cc = cw;
    float desx = 0;
    if (des) {
      desx = (j%2);
      cc = cw-int(desx);
      desx *= 0.5;
    }
    for (int i = 0; i < cc; i++) {
      float xx = ww*(desx+i-cw*0.5+(1-mw)*0.5);
      float yy = hh*(j-ch*0.5)+(1-mh)*0.5;
      pushMatrix();
      translate(xx, yy);
      int col = getColor(noise(desCol+xx*detCol, desCol+yy*detCol)*colors.length*2);
      fill(col, random(255));
      rect(0, 0, ww*mw, hh*mh);
      popMatrix();
    }
  }
  blendMode(NORMAL);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #0c1cad};
//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #062FAA};
//int colors[] = {#ED4715, #FFA3EC, #B0A8FF, #0D110F, #FFB951};
int colors[] = {#00FF6F, #FF002C, #FFE74A, #ff6eec};
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
  return lerpColor(c1, c2, pow(v%1, 0.4));
}
