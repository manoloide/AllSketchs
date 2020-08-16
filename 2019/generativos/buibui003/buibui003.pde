int seed = int(random(999999));


float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  background(0);

  
  hint(DISABLE_DEPTH_TEST);
  //ambientLight(60, 40, 30);
  // directionalLight(255, 255, 255, 0, -1, -1);
  //directionalLight(255, 255, 255, 0.3, 0, -1);
  
  

  float fov = PI/2;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width*0.5, height*0.5, 200);


  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*2.8, height*2.8));

  for (int i = 0; i < 16; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    rects.add(new Rect(r.x, r.y-r.h*0.25, r.w, r.h*0.5));
    rects.add(new Rect(r.x, r.y+r.h*0.25, r.w, r.h*0.5));
    rects.remove(ind);
  }


  for (int i = 0; i < 320; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float m1 = random(0.2, 0.8);
    float m2 = 1-m1;
    rects.add(new Rect(r.x-r.w*0.5+r.w*m1*0.5, r.y, r.w*m1, r.h));
    rects.add(new Rect(r.x+r.w*0.5-r.w*m2*0.5, r.y, r.w*m2, r.h));
    //rects.add(new Rect(r.x+r.w*0.25, r.y, r.w*0.5, r.h));
    rects.remove(ind);
  }



  for (int i = 0; i < 40000; i++) {
    int ind = int(random(rects.size()*random(0.6, 1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.remove(ind);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  strokeWeight(0.8);
  rectMode(CENTER);
  noStroke();
  float dc = random(colors.length);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    //stroke(rcol());
    float area = log(1+r.w*r.h*0.0082);
    fill(getColor(dc+area+random(1.4)));
    rect(r.x, r.y, r.w-2, r.h-2);
    noStroke();
    float bb = min(r.w, r.h)*0.1;
    dricula(r.x, r.y, r.w-bb, r.h-bb, int(random(8, 20)), rcol(), rcol());
  }


  /*
  rectMode(CENTER);
   for (int i = 0; i < rects.size(); i++) {
   Rect r = rects.get(i);
   stroke(0, 50);
   //noStroke();
   //noFill();
   pushMatrix();
   translate(r.x, r.y);
   
   rotateY(random(TAU));
   //rect(0, 0, r.w, r.h);
   //rect(0, 0, r.w*0.1, r.h*0.1);
   float aw = 0.4+int(random(2))*0.6;
   float ah = 0.4+int(random(2))*0.6;
   float d = min(min(r.w, r.h)*0.2, 100+int(random(1.4))*50);
   noFill();
   //box(r.w, r.h, d);
   fill(rcol());
   //piras(r.w, r.h, d, aw, ah);
   box(r.w*random(0.01, 0.02), r.h*0.98, d*0.98);
   //box(r.w*0.98, r.h*random(0.01, 0.02), d*0.98);
   //translate(0, 0, d+d*0.02);
   float bb = min(r.w, r.h)*0.08;
   box(r.w*aw-bb, r.h*ah-bb, d*0.04);
   //translate(0, 0, d*0.12);
   //box(d*0.04, d*0.04, d*0.2);
   popMatrix();
   }
   */

  /*
  for (int i = 0; i < rects.size(); i++) {
   Rect r = rects.get(i);
   stroke(rcol(), 120);
   float d = min(min(r.w, r.h)*0.2, 100+int(random(1.4))*50);
   pushMatrix();
   translate(r.x, r.y, d*1.14);
   grid(d*10.8, d*10.8, 20);
   line(0, 0, 0, 0, 0, 40);
   
   translate(0, 0, 40);
   fill(0);
   box(1);
   
   line(-4, 0, 4, 0);
   line(0, -4, 0, 4);
   
   float mm = min(min(r.w, r.h)*0.5, 8);
   noFill();
   rect(0, 0, mm, mm);
   rect(0, 0, mm*1.8, mm*1.8);
   
   translate(0, 0, 0);
   
   popMatrix();
   }
   */
   
   //tentas();
}

void tentas(){
  noStroke();
  for (int i = 0; i < 90; i++) {
    float x = width*random(-0.2, 1.2);
    float y = height*random(-0.2, 1.2);
    float scale = random(0.6, 1);
    float minSize = width*random(0.04, 0.2)*scale;
    float maxSize = width*random(0.04, 0.2)*scale;
    float des1 = random(10000);
    float det1 = random(0.001);
    float des2 = random(10000);
    float det2 = random(0.001);
    float ic = random(100);
    float dc = random(0.004)*random(1);
    float da = random(-1, 1)*random(0.012, 0.02);

    int cc = 1200;
    int ccc = int(random(2, 10));
    float dd = TAU/ccc;
    float ia = random(TAU);

    float rrr = random(0.2);
    for (int j = 0; j < cc; j++) {
      float a = noise(des1+x*det1, des1+y*det1)*2*TAU;
      float amp = 0.5+pow(sin(j*PI/cc), 2)*0.5;
      float s = 0.1*lerp(minSize, maxSize, noise(des2+x*det2, des2+y*det2))*amp;
      int col = getColor(ic+dc*j);
      fill(col, 220);
      ellipse(x, y, s, s);
      x += cos(a)*0.8*scale;
      y += sin(a)*0.8*scale;

      if (random(1) < 0.1) {
        float a2 = random(TAU);
        float xx = x+cos(a2)*s;
        float yy = y+sin(a2)*s;
        stroke(col, 120);
        line(xx, yy, x, y);
        noStroke();
        ellipse(xx, yy, s*0.16, s*0.16);
      }

      fill(getColor(ic+dc*j+2), 120);
      for (int k = 0; k < ccc; k++) {
        float aa = ia+dd*k+da*j;
        float r = s*(1-rrr*0.5)*2;
        ellipse(x+cos(aa)*r, y+sin(aa)*r, s*rrr, s*rrr);
      }
    }
  }
}

void dricula(float x, float y, float w, float h, float s, int c1, int c2) {
  int cw = int(w/s+1);
  int ch = int(h/s+1);
  float ww = w*1./cw;
  float hh = h*1./ch;
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      //stroke(0);
      noFill();
      rect(x+ww*i-w*0.5, y+hh*j-h*0.5, ww, hh);
      fill(c1);
      if ((i+j)%2 == 0) fill(c2);
      rect(x+ww*i-w*0.5, y+hh*j-h*0.5, ww*0.2, hh*0.2);
    }
  }
}

void grid(float w, float h, int cc) {
  for (int i = 0; i <= cc; i++) {
    float v = (i*1.)/cc-0.5;
    line(-w*0.5, h*v, w*0.5, h*v);
    line(w*v, -h*0.5, w*v, h*0.5);
  }
}

void piras(float w, float h, float d, float aw, float ah) {
  float mw = w*0.5;
  float mh = h*0.5;
  beginShape();
  vertex(-mw, -mh, 0);
  vertex(+mw, -mh, 0);
  vertex(+mw, +mh, 0);
  vertex(-mw, +mh, 0);
  endShape(CLOSE);


  beginShape();
  vertex(-mw, -mh, 0);
  vertex(+mw, -mh, 0);
  vertex(+mw*aw, -mh*ah, d);
  vertex(-mw*aw, -mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(+mw, -mh, 0);
  vertex(+mw, +mh, 0);
  vertex(+mw*aw, +mh*ah, d);
  vertex(+mw*aw, -mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(+mw, +mh, 0);
  vertex(-mw, +mh, 0);
  vertex(-mw*aw, +mh*ah, d);
  vertex(+mw*aw, +mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(-mw, +mh, 0);
  vertex(-mw, -mh, 0);
  vertex(-mw*aw, -mh*ah, d);
  vertex(-mw*aw, +mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(-mw*aw, -mh*ah, d);
  vertex(+mw*aw, -mh*ah, d);
  vertex(+mw*aw, +mh*ah, d);
  vertex(-mw*aw, +mh*ah, d);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
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
