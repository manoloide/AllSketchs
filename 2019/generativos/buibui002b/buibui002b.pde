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

  background(0);//rcol());

  //hint(DISABLE_DEPTH_TEST);

  float fov = PI/3;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width*0.5, height*0.5, 200);
  scale(0.4);


  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*1.82, height*1.82));

  for (int i = 0; i < 11; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    rects.add(new Rect(r.x, r.y-r.h*0.25, r.w, r.h*0.5));
    rects.add(new Rect(r.x, r.y+r.h*0.25, r.w, r.h*0.5));
    rects.remove(ind);
  }

  int subs = int(random(50, 90));
  for (int i = 0; i < subs; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float m1 = random(0.2, 0.8);
    float m2 = 1-m1;
    rects.add(new Rect(r.x-r.w*0.5+r.w*m1*0.5, r.y, r.w*m1, r.h));
    rects.add(new Rect(r.x+r.w*0.5-r.w*m2*0.5, r.y, r.w*m2, r.h));
    //rects.add(new Rect(r.x+r.w*0.25, r.y, r.w*0.5, r.h));
    rects.remove(ind);
  }


  for (int i = 0; i < 3000; i++) {
    stroke(255, random(200));
    strokeWeight(random(0.5, 3));
    point(width*random(-1, 1), height*random(-1, 1));
  }

  ArrayList<PVector> cirs = new ArrayList<PVector>();
  for (int i = 0; i < 400; i++) {
    float nx = width*random(-1, 1);
    float ny = height*random(-1, 1);
    float s = random(980)*random(1)*random(1)*random(0.5, 1);
    boolean add = true;
    for (int j = 0; j < cirs.size(); j++) {
      PVector c = cirs.get(j);
      if (dist(nx, ny, c.x, c.y) < (s+c.z)*0.55) {
        add = false;
        break;
      }
    }
    if (add) cirs.add(new PVector(nx, ny, s));
  }

  noStroke();
  for (int i = 0; i < cirs.size(); i++) {
    PVector c = cirs.get(i);
    fill(rcol(), 240);
    ellipse(c.x, c.y, c.z, c.z);
    fill(255);
    ellipse(c.x, c.y, c.z*0.05, c.z*0.05);
  }


  stroke(255, 180);
  strokeWeight(1);
  noFill();
  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    //rect(r.x, r.y, r.w, r.h);
    rect(r.x, r.y, r.w-4, r.h-4);
    //rect(r.x, r.y, 8, 8);
  }



  float amb = 240;
  ambientLight(amb, amb, amb);
  // directionalLight(255, 255, 255, 0, -1, -1);
  //directionalLight(255, 255, 255, 0.3, 0, -1);
  directionalLight(255, 100, 100, -1, 0, 0);
  directionalLight(60, 60, 120, +1, 0, 0);
  directionalLight(220, 120, 120, 0, 1, 0);

  ArrayList<Rect> screens = new ArrayList<Rect>();
  rectMode(CENTER);

  int rem = int(rects.size()*0.8);
  for (int i = 0; i < rem; i++) {
    int ind = int(random(rects.size()));
    screens.add(rects.get(ind));
    rects.remove(ind);
  }


  noStroke();
  for (int i = 0; i < screens.size(); i++) {
    Rect s = screens.get(i);

    if (random(1) < 0.3) continue;

    screen(s.x, s.y, s.w-30, s.h-40);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 50);
    strokeWeight(0.8);
    //noStroke();
    //noFill();
    pushMatrix();
    translate(r.x, r.y);
    //rect(0, 0, r.w, r.h);
    //rect(0, 0, r.w*0.1, r.h*0.1);
    float aw = 0.4+int(random(0.6, 2))*0.6;
    float ah = 0.4+int(random(0.6, 2))*0.6;
    float d = min(min(r.w, r.h)*0.2, 100+int(random(1.4))*50);

    int col = lerpColor(rcol(), color(240), random(0.4));

    if (random(1) < 0.0) {
      pushMatrix();
      noFill();
      box(r.w, r.h, d);
      fill(col);
      piras(r.w, r.h, d, aw, ah);
      box(r.w*random(0.01, 0.02), r.h*0.98, d*0.98);
      //box(r.w*0.98, r.h*random(0.01, 0.02), d*0.98);

      translate(0, 0, d+d*0.02);
      float bb = min(r.w, r.h)*0.08;
      box(r.w*aw-bb, r.h*ah-bb, d*0.04);
      popMatrix();
    } else {
      int cc = int(random(4, 18));
      float ss = r.h/cc;
      float amp = (random(1) < 0.5)? 1 : random(0.4, 1);
      fill(255);
      int c = rcol();
      while(c == col) c = rcol();
      fill(c);
      box(r.w*0.94, r.h*0.94, d*0.94);
      fill(col);
      for (int j = 0; j < cc; j++) {
        pushMatrix();
        translate(0, ss*(j-cc*0.5+0.5), 0);
        box(r.w, ss*amp, d);
        popMatrix();
      }
    }

    translate(0, r.h*0.5, d*0.5);
    //box(d*0.04, d*0.04, d*0.2);
    rotateX(HALF_PI);
    if (random(1) < 0.4) {
      //box(r.w, d, d*0.02);
    } else {
      stroke(0, 200);
      //grid(r.w, d, 30);
    }

    //blendMode(ADD);  
    int ccc = 0;//int(r.w*random(0.2, 0.4));
    strokeWeight(2);
    for (int k = 0; k < ccc; k++) {
      float x = r.w*random(-0.5, 0.5);
      float y = r.h*random(-0.08, 0.08);
      stroke(lerpColor(rcol(), color(0), random(1)), 150);
      float h = r.h*random(0.1, 0.2)*0.24;
      pushMatrix();
      translate(x, y, h*0.5+1);
      fill(rcol());
      box(r.w*0.002, r.h*0.002, h);
      popMatrix();
      //line(x, y, 1, x+random(-0.01, 0.01)*r.h, y, h);
    }
    //blendMode(BLEND);
    popMatrix();
  }

  for (int i = 0; i < rects.size(); i++) {

    if (random(1) < 0.6) continue;
    Rect r = rects.get(i);
    stroke(lerpColor(rcol(), color(0), 0.95), 120);
    float d = min(min(r.w, r.h)*0.2, 100+int(random(1.4))*50);
    pushMatrix();
    translate(r.x, r.y, d*1.14);
    grid(r.h*0.8, r.h*0.9, 20);
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

  hint(DISABLE_DEPTH_MASK);

  noFill();
  noStroke();
  fill(0);
  noFill();
  stroke(0);
  strokeWeight(0.2);
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    translate(width*random(-0.7, 0.7), 0, +300);
    box(2, height*2, 2);

    for (int j = 0; j < 80; j++) {
      pushMatrix();
      translate(0, random(-height, height));
      rotateX(HALF_PI);
      float s = random(2, 5);
      rect(0, 0, s, s);
      popMatrix();
    }
    popMatrix();
  }

  hint(ENABLE_DEPTH_MASK);
}

void screen(float x, float y, float w, float h) {
  float max = random(0.002, 0.005)*random(0.5, 1);
  float pwr = random(20)*random(1);
  float des1 = random(1000);
  float det1 = random(max*0.5, max);
  float des2 = random(1000);
  float det2 = random(max*0.5, max);
  float des3 = random(1000);
  float det3 = random(max*0.5, max);
  float des4 = random(1000);
  float det4 = random(max*0.5, max);  

  blendMode(BLEND);

  noStroke();
  fill(0, 80);
  rect(x, y, w+5, h+5);
  fill(0, 240);
  rect(x, y, w, h);

  blendMode(ADD);
  for (int k = 2; k < h-1; k+=3) {
    for (int j = 2; j < w-1; j+=3) {

      float xx = x+j-w*0.5;
      float yy = y+k-h*0.5;

      float dx = noise(des2+xx*det2, des2+yy*det2);
      float dy = noise(des3+xx*det3, des3+yy*det3);
      float n = noise(des1+xx*det1+dx, des1+yy*det2+dy)*20;
      n = (n-n%1)+pow(n%1, pwr);
      fill(getColor(n), 80);

      rect(xx, yy, 2, 2);
      rect(xx, yy, 2, 2);

      n = noise(des4+xx*det4+dx, des4+yy*det4+dy)*20;
      n = (n-n%1)+pow(n%1, pwr);
      fill(getColor(n), 120);


      rect(xx, yy, 3, 3);
      rect(xx, yy, 3, 3);
    }
  }
  blendMode(BLEND);
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

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#0d1623, #2a2b28, #c3f76f, #a51212, #fe6641};
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
