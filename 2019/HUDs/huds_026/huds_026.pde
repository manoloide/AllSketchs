import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;
PImage texture;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  int w = 120;
  int h = 120;
  PGraphics render = createGraphics(w, h);
  render.beginDraw();
  render.noStroke();
  //render.fill(255, 180);
  render.fill(255, 0);
  render.rect(0, 0, width, height);
  for (int i = 0; i < 100; i+=2) {
    render.fill(255, i*0.2);
    render.ellipse(w*0.5, h*0.5, i*0.4, i*0.4);
  }
  //render.ellipse(w*0.5, h*0.5, 100, 100);
  render.endDraw();
  texture = render.get();

  generate();

  background(5, 0, 40);

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
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

  hint(DISABLE_DEPTH_MASK);
  blendMode(ADD);

  background(lerpColor(rcol(), color(0), 0.92));

  randomSeed(seed);
  noiseSeed(seed);

  int sub = int(random(100));

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(10, 10, width-20));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind); 

    float ms = r.z*0.5;

    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));

    rects.remove(ind);


    noStroke();
  }

  float time = millis()*random(0.001)*0.1;
  float det = random(0.001);

  for (int i = 0; i < rects.size(); i++) {
    rectMode(CORNER);
    PVector r = rects.get(i); 
    noFill();
    stroke(255, 20);
    rect(r.x+1, r.y+1, r.z-2, r.z-2);


    int type = int(random(2));

    if (type == 0) {
      float nw = r.z-4;
      float nh = r.z-4;
      int grill = int(random(4, random(4, 30)));

      float ww = nw/grill;
      float hh = nh/grill;

      float detCol = random(0.001);
      float detAlp = random(0.001);

      float vc = random(10);
      float va = random(10);

      //imageMode(CENTER);
      for (int l = 0; l < grill; l++) {
        for (int k = 0; k < grill; k++) {
          float xx = 2+(k)*ww;
          float yy = 2+(l)*hh;
          float nc = (float) SimplexNoise.noise(xx*detCol, yy*detCol, time*vc);
          float na = (float) SimplexNoise.noise(xx*detAlp, yy*detAlp, time*va);
          na = na*0.5+0.5;//pow(na*0.5+0.5, 0.2);
          fill(getColor(nc*10), na*180);
          tint(getColor(nc*10), na*260);
          image(texture, r.x+xx, r.y+yy, ww*0.8*2, hh*0.8*2);
          //rect(r.x+xx, r.y+yy, ww*0.8, hh*0.8);
          //rect(r.x+xx+ww*0.05, r.y+yy+hh*0.05, ww*0.7, hh*0.7);
          image(texture, r.x+xx+ww*0.05, r.y+yy+hh*0.05, ww*0.7, hh*0.7);
        }
      }
    }

    if (type == 1) {

      float xx = r.x+r.z*0.5;
      float yy = r.y+r.z*0.5;

      float rotX = (float) SimplexNoise.noise(xx*det, yy*det, time*random(1))*TAU*2;
      float rotY = (float) SimplexNoise.noise(xx*det*0.2, yy*det, time*random(1))*TAU*2;
      float rotZ = (float) SimplexNoise.noise(xx*det, yy*det*2, time*random(1))*TAU*2;

      pushMatrix();
      translate(xx, yy);
      rotateX(rotX);
      rotateY(rotY);
      rotateZ(rotZ);
      tint(rcol());
      image(texture, 0, 0, r.z*2, r.z*2);
      noTint();
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#F73B3B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#2C50FE, #FF3E6D, #F9FF5E, #1B7B8B, #CB38F1};
//int colors[] = {#F4F751, #000000, #FAFAFA};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
