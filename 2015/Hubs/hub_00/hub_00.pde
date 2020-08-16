int seed;
PFont font;
PShader post;

void setup() {
  size(1280, 720, P2D);
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));

  font = createFont("Stockholm Mono", 12, true);
}

void draw() {
  post.set("time", millis()/1000.);
  randomSeed(seed);

  background(10);
  noStroke();
  fill(40);
  gridCircle(35, 2);

  stroke(60, 60);
  strokeWeight(1);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  float sep = random(5, 16);
  stroke(60, 200);
  strokeWeight(1);
  line(width/2-sep, height/2, width/2+sep, height/2);
  line(width/2, height/2-sep, width/2, height/2+sep); 

  stroke(80, 200);
  circleLine(width/2, height/2, height*random(0.18, 0.4), int(4*int(random(1, 5))), random(4, 20), 0);
  noFill();
  arcMeter(width/2, height/2, 320, PI*1.5, PI*(1.5+int(random(1, 8))*0.25), 22); 

  noStroke();
  fill(255, 10, 30);
  circleDot(width/2+1, height/2, height*random(0.18, 0.4), int(4*int(random(1, 3))), 5, 0);
  circleTri(width/2, height/2, height*random(0.18, 0.4), int(random(3, 26)), 5, frameCount*random(-0.01, 0.01));


  textRect("process...", width/2, 100);

  float ss = width/34;
  float dx = (width-ss*34)/2+frameCount%ss;
  float dy = (height-ss*20)/2+frameCount%ss;
  for (int j = -1; j < 20+1; j++) {
    for (int i = -1; i < 34+1; i++) { 
      fill(250);
      rect(dx+i*ss-2, dy+j*ss-2, 5, 5);
      fill(0);
      rect(dx+i*ss, dy+j*ss, 1, 1);
    }
  }

  filter(post);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(99999999));
}


void gridCircle(float sep, float tt) {
  int cw = int(width/sep);
  int ch = int(height/sep);
  float dx = (width-sep*(cw-1))/2;
  float dy = (height-sep*(ch-1))/2;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      ellipse(i*sep+dx, j*sep+dy, tt, tt);
    }
  }
}

void arcMeter(float x, float y, float d, float r1, float r2, float s) {
  float r = d*0.5;
  strokeWeight(3);
  strokeCap(ROUND);
  arc(x, y, d, d, r1, r2);
  strokeCap(SQUARE);
  line(x+cos(r1)*r, y+sin(r1)*r, x+cos(r1)*(r+s), y+sin(r1)*(r+s));
  line(x+cos(r2)*r, y+sin(r2)*r, x+cos(r2)*(r+s), y+sin(r2)*(r+s));
  int cc = int((r2-r1)/TWO_PI*128);
  float da = TWO_PI/128;
  strokeWeight(1);
  for (int i = 0; i < cc; i++) {
    float a = da*i-PI/2;
    float rr = 0.4;
    if (i%2 == 1) rr = 0.8;
    line(x+cos(a)*(r+s*rr), y+sin(a)*(r+s*rr), x+cos(a)*(r+s), y+sin(a)*(r+s));
  }
}

void circleDot(float x, float y, float d, int c, float s, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  for (int i = 0; i < c; i++) {
    float ang = da*i+a;
    ellipse(x+cos(ang)*r, y+sin(ang)*r, s, s);
  }
} 

void circleTri(float x, float y, float d, int c, float s, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  for (int i = 0; i < c; i++) {
    pushMatrix();
    float ang = da*i+a;
    translate(x+cos(ang)*r, y+sin(ang)*r);
    rotate(ang);
    triangle(5, 0, 0, 3, 0, -3);
    popMatrix();
  }
} 

void circleLine(float x, float y, float d, int c, float s, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  for (int i = 0; i < c; i++) {
    float ang = da*i+a;
    line(x+cos(ang)*r, y+sin(ang)*r, x+cos(ang)*(r-s), y+sin(ang)*(r-s));
  }
}

void textRect(String txt, float x, float y) {
  pushStyle();
  rectMode(CENTER);
  textFont(font);
  textAlign(CENTER, CENTER);  
  float w = 32+textWidth(txt);
  float h = 24+16;
  stroke(30);
  noFill();
  strokeWeight(1);
  rect(x, y, w-1, h-1);
  noStroke();
  fill(30);
  rect(x, y, w-12, h-12);
  fill(220);
  text(txt, x, y);
  popStyle();
}

