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
  PGraphics render = createGraphics(w, h, P2D);
  render.beginDraw();
  for (int i = 0; i < 100; i+=2) {
    render.fill(255, 100-i);
    render.ellipse(w*0.5, h*0.5, i, i);
  }
  render.endDraw();
  texture = render.get();

  generate();

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

  randomSeed(seed);
  noiseSeed(seed);

  background(2, 0, 6);

  int cc = int(random(40, 120)*0.5);
  float dd = width*1./(cc+2);

  /*
  fill(#F4F751);
   noStroke();
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   float xx = dd*(i+1.5);
   float yy = dd*(j+1.5);
   float ss = dd*0.12*2;
   if (random(1) < 0.5) continue;
   if (random(1) < 0.08) ss *= 4;
   ellipse(xx, yy, ss, ss);
   }
   }
   
   stroke(#F4F751);
   for (int i = 0; i < cc; i++) {
   float x1 = dd*(int(random(cc))+1.5);
   float y1 = dd*(int(random(cc))+1.5);
   float x2 = dd*(int(random(cc))+1.5);
   float y2 = dd*(int(random(cc))+1.5);
   if (random(1) < 0.4) x1 = x2;
   else y1 = y2;
   line(x1, y1, x2, y2);
   }
   */
  float time = millis()*random(0.001);
  time += cos(time*random(1.))*random(0.001)*random(1);

  rectMode(CENTER);
  fill(255, 160);
  float det = random(0.001);

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = dd*(i+1.5);
      float yy = dd*(j+1.5);

      float rotX = (float) SimplexNoise.noise(xx*det, yy*det, time)*TAU*2;
      float rotY = (float) SimplexNoise.noise(xx*det*0.2, yy*det, time)*TAU*2;
      float rotZ = (float) SimplexNoise.noise(xx*det, yy*det*2, time)*TAU*2;

      pushMatrix();
      translate(xx, yy);
      rotateX(rotX);
      rotateY(rotY);
      rotateZ(rotZ);
      rect(00, 00, dd*0.6, dd*0.6);
      ellipse(00, 00, dd*0.6, dd*0.6);
      //image(texture, dd*0.6, dd*0.6);
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
int colors[] = {#F4F751, #000000, #FAFAFA};
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
