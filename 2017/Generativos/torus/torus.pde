import peasy.*;

PeasyCam cam;

int seed = int(random(9999999));

void setup() {
  size(720, 720, P3D);
  cam = new PeasyCam(this, 1200);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2000);

  smooth(8);
  pixelDensity(2);
  generate();
}


void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  randomSeed(seed);

  background(20);
  //translate(width/2, height/2, 500);

  float radius = width*random(0.3, 0.44);
  int res = 1024; 
  float da = TWO_PI/res;

  stroke(255);
  noFill();
  /*
  beginShape();
   for (int i = 0; i <= res; i++) {
   float rr = radius;
   float xx = cos(da*i)*rr;
   float yy = sin(da*i)*rr;
   vertex(xx, yy);
   }
   endShape();
   */


  float ite = int(random(1, random(31))); 
  float di = (TWO_PI*ite)/res;
  float r2 = radius*random(0.1, 0.4);
  float amp = random(20);
  noStroke();
  int cc = int(random(2, random(21)));
  for (int j = 0; j < cc; j++) {
    float dd = j*res*1.0/cc;
    //strokeWeight(j*0.2+1);
    float ic = millis()*random(0.01);
    float dc = random(1)*random(1)*random(1);
    for (int i = 0; i <= res; i++) {
      float a1 = da*i;
      float a2 = di*i+dd;
      float rr = radius+sin(a2)*r2;
      float xx1 = cos(a1)*rr;
      float yy1 = sin(a1)*rr;
      float zz1 = cos(a2)*r2;
      float dx1 = cos(a1+HALF_PI)*amp;
      float dy1 = sin(a1+HALF_PI)*amp;
      float xx2 = cos(a1+da)*rr;
      float yy2 = sin(a1+da)*rr;
      float zz2 = cos(a2+di)*r2;
      float dx2 = cos(a1+da+HALF_PI)*amp;
      float dy2 = sin(a1+da+HALF_PI)*amp;
      //line(xx-dx, yy-dy, zz, xx+dx, yy+dy, zz);
      beginShape();
      fill(getColor(ic+dc*i), 200);
      vertex(xx1-dx1, yy1-dy1, zz1);
      vertex(xx1+dx1, yy1+dy1, zz1);
      fill(getColor(ic+dc*(i+1)), 200);
      vertex(xx2+dx2, yy2+dy2, zz2);
      vertex(xx2-dx2, yy2-dy2, zz2);
      endShape();
    }
  }
  strokeWeight(1);
}

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}