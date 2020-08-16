import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

  generate();
}

void draw() {
  if(frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


ArrayList<Rect> rects;

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void rect1(float x, float y, float w, float h, float dx, float dy, int ite) {
  stroke(0, 180);
  noStroke();
  fill(rcol());
  modulo(x, y, w, h);

  if (ite <= 0) return;

  float mw = w*0.5;
  float mh = h*0.5;
  rect1(x+mw*(dx+0.5), y+mh*(dy+0.5), mw, mh, dx, dy, ite-1);
  /*
  rect1(x+w*mw, y, mw, mh, dx, dy, ite-1);
   rect1(x+w*mw, y+h*mh, mw, mh, dx, dy, ite-1);
   rect1(x, y+h*mh, mw, mh, dx, dy, ite-1);
   */
}


void modulo(float x, float y, float w, float h) {

  w *= 0.5;
  h *= 0.5;
  x += w*0.5;
  y += h*0.5;
  int c1 = 1;
  int c2 = 0;
  int c3 = 3;
  int c4 = 2;

  int des = 0;
  if (x < width*0.5 && y < height*0.5) des = 0;
  if (x > width*0.5 && y < height*0.5) des = 2;
  if (x > width*0.5 && y > height*0.5) des = 4;
  if (x < width*0.5 && y > height*0.5) des = 6;

  
  fill(colors[(c1+des)%4]);
  rect(x, y, w, h);
  shadow(x, y, w, h, rcol());
  fill(colors[(c2+des)%4]);
  rect(x+w, y, w, h);
  shadow(x+w, y, w, h, rcol());
  fill(colors[(c3+des)%4]);
  rect(x+w, y+h, w, h);
  shadow(x+w, y+h, w, h, rcol());
  fill(colors[(c4+des)%4]);
  rect(x, y+h, w, h);
  shadow(x, y+h, w, h, rcol());
  

  fill(colors[(des/2+1)%4]);
  ellipse(x+w*0.5, y+h*0.5, w, h);
}





void generate() { 

  randomSeed(seed);
  background(230);

  rectMode(CENTER);

  float des = 0.5;
  rect1(width*0.5, height*0.5, width*0.5, height*0.5, +des, +des, 8);
  rect1(width*0.0, height*0.5, width*0.5, height*0.5, -des, +des, 8);
  rect1(width*0.0, height*0.0, width*0.5, height*0.5, -des, -des, 8);
  rect1(width*0.5, height*0.0, width*0.5, height*0.5, +des, -des, 8);


  //post = loadShader("post.glsl");
  //post.set("time", millis()*0.001);
  //filter(post);
}

void shadow(float x, float y, float w, float h, int col) {
  x -= w*0.5;
  y -= h*0.5;
  boolean des = random(1) < 0.5;
  beginShape();
  fill(col, 180);
  vertex(x, y);
  fill(col, 180);
  if (des) fill(col, 0);
  vertex(x+w, y);
  fill(col, 0);
  vertex(x+w, y+h);
  fill(col, 0);
  if (des) fill(col, 180);
  vertex(x, y+h);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
  return lerpColor(c1, c2, v%1);
}
