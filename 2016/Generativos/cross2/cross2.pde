PImage img;

void setup() {
  img = loadImage("kevin.png");

  size(img.width, img.height);
  generate();
}


void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}  

void generate() {
  PGraphics mask = createGraphics(width, height);
  float diag = dist(0, height, width, 0);
  mask.beginDraw();
  mask.background(255);
  mask.noStroke();
  /*
  for (int j = 0; j < 100; j++) {
   int c = int(random(4, 100));
   float s = random(width)*random(1);
   float x = random(width);
   float y = random(height);
   float vr = random(1);
   for (int i = 0; i < c; i++) {
   if (i%2 == 0) fill(252);
   else fill(0);
   cross(mask, x, y, map(i, 0, c, s, s*0.1), 0.1, i*vr);
   }
   }
   */
  /*
  boolean inv = false;
   for (float i = diag+20; i > 80; i-=80) {
   inv = !inv;
   if (inv) mask.fill(0);
   else mask.fill(255);
   //mask.ellipse(width/2, height/2, i, i);
   }
   */
  //cross(mask, width/2, height/2, width*0.8, 0.28, PI/4);
  /*
  mask.textFont(createFont("Helvetica Neue Bold", 420, true));
   mask.textAlign(CENTER, CENTER);
   mask.text("+1", width/2, height/2);
   */
  /*
  int cc = 1; 
   float d = diag/cc;
   mask.fill(0);
   mask.rectMode(CENTER);
   mask.rotate(PI/4);
   for (int i = 0; i < cc; i++) {
   mask.rect(i*d+d/2, 0, d*tan(map(i, 0, cc, 0.2, PI/4)), diag);
   }
   mask.endDraw();
   */
  /*
  mask.fill(0);
   mask.textAlign(CENTER, CENTER);
   mask.textSize(820);
   mask.text("♥", width/2, height/2-60);
   */
  /*
  int c = 8; 
   float d = 180; 
   float t = 120;
   mask.fill(0);
   mask.translate(width/2, height/2);
   mask.rotate(PI/4);
   for (int j = -c; j <= c; j++) {
   for (int i = -c; i <= c; i++) {
   mask.ellipse(i*d, j*d, t, t);
   }
   }
   */
  boolean inv = false;
  float sep = 160;
  mask.rectMode(CENTER);
  mask.translate(width/2, height/2);
  mask.rotate(PI/4);
  for (float i = diag; i > 0; i-=sep) {
    inv = !inv;
    if (inv) mask.fill(0);
    else mask.fill(255);
    mask.rect(0, 0, i, i);
  } 


  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    boolean b = (brightness(img.get(int(x), int(y))) < 150);
    float s = random(5, 18)*((b)? 1.4 : 1);
    float a = random(TWO_PI);
    float gro = (b)? 0.1 : 0.3;
    gro *= map(dist(x, y, width/2, height/2), 0, diag/2, 0.3, 0.9);
    cross(g, x, y, s, gro, a);
  }
}

void cross(PGraphics gra, float x, float y, float s, float g, float a) {
  s *= 0.5;
  float da = TWO_PI/4;
  float dd = s*g; 
  float diag = dist(dd, 0, 0, dd);
  gra.beginShape();
  for (int i = 0; i < 4; i++) {
    float aa = a+da*i;
    float xx = x+cos(aa)*s; 
    float yy = y+sin(aa)*s;
    float dx = cos(aa+HALF_PI)*dd;
    float dy = sin(aa+HALF_PI)*dd;
    gra.vertex(xx-dx, yy-dy);
    gra.vertex(xx+dx, yy+dy);
    gra.vertex(x+cos(aa+da/2)*diag, y+sin(aa+da/2)*diag);
  }
  gra.endShape(CLOSE);
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}

