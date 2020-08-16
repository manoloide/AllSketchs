int seed = int(random(999999));
PImage[] images;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  loadForms();

  generate();
}

void loadForms() {
  PImage ori = loadImage("../forms.png");

  int cc = 16;
  int des = ori.width/cc;
  images = new PImage[cc*2];
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < cc; i++) {
      images[i+cc*j] = ori.get(i*des, j*des, des, des);
    }
  }
  ori = null;
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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  translate(+width*0.5, +height*0.5);
  scale(random(0.7, 0.8));
  translate(-width*0.5, -height*0.5);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));
  int sub = int(random(120));
  sub = 0;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    rectPaint(r.x, r.y, r.z, r.z);
  }
  //rect(width*0.5, height*0.5, width*0.5, height*0.5);
}

void rectPaint(float x, float y, float w, float h) {
  noiseDetail(2);
  
  float des = random(10000);
  float det = random(0.06, 0.012)*0.8;
  float des2 = random(10000);
  float det2 = random(0.06, 0.012)*0.2;
  float des3 = random(10000);
  float det3 = random(0.06, 0.012)*0.2;
  float des4 = random(10000);
  float det4 = random(0.06, 0.012)*0.2;
  
  int cc = int(w*h)/26;
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    float xx = x+random(w);
    float yy = y+random(h*pow(random(0, 1), 0.9));
    float md = noise(des2+xx*det2, des2+yy*det2)*0.8+0.2;
    float s = noise(des+xx*det, des+yy*det)*120*noise(des2+xx+det2, des2+yy+det2);//*map(y, 0, height, 0.6, 1)*md;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(xx, yy, p.x, p.y) < (s+p.z)*0.01) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(xx, yy, s));
  }

  int cw = 20;
  int ch = 20;
  float xx, yy, ss;
  ss = width*1./cw;
  noTint();
  fill(255, 90);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      xx = i*ss;
      yy = j*ss;
      ss = noise(des+xx*det, des+y*det);
      arc(xx, yy, ss, ss, HALF_PI*0.0, HALF_PI*1.0);
      ss = noise(des2+xx*det2, des2+y*det2);
      arc(xx, yy, ss, ss, HALF_PI*1.0, HALF_PI*2.0);
      ss = noise(des3+xx*det3, des3+y*det3);
      arc(xx, yy, ss, ss, HALF_PI*2.0, HALF_PI*3.0);
      ss = noise(des4+xx*det4, des4+y*det4);
      arc(xx, yy, ss, ss, HALF_PI*3.0, HALF_PI*4.0);
    }
  }
/*
  imageMode(CENTER);
  int c1 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c2 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c3 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c4 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    PImage img = images[int(random(images.length))];
    xx = p.x;
    yy = p.y;
    float s = p.z*0.18;

    int col = c1;
    if (random(1) < 0.5) {
      if (random(1) < 0.5) col = c1;
      else col = c2;
    } else {
      if (random(1) < 0.5) col = c3;
      else col = c4;
    }
    tint(col, 180);
    pushMatrix();
    translate(xx, yy);
    rotate(random(TAU));
    image(img, 0, 0, s*0.4, s*8);
    popMatrix();
  }
  */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
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
