PShader post;
int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

  generate();
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
  background(rcol());
  randomSeed(seed);

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));

  int sub = 20;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind);
    int div = int(random(1, 4))*2+1;
    float xx = q.x;
    float yy = q.y;
    float ss = q.z/div;
    for (int y = 0; y < div; y++) {
      for (int x = 0; x < div; x++) {
        quads.add(new PVector(xx+x*ss, yy+y*ss, ss));
      }
    }
    quads.remove(ind);
  }

  noStroke();
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    float x = q.x+q.z*0.5;
    float y = q.y+q.z*0.5;
    float ss = random(0.2, 0.8)*q.z;
    fill(rcol());
    rect(q.x+1, q.y+1, q.z-2, q.z-2, 2);

    if (random(1) < 0.4) {
      fill(rcol());
      beginShape();
      vertex(q.x+1, q.y+q.z*0.5);
      vertex(q.x+q.z*0.5, q.y+1);
      vertex(q.x+q.z-1, q.y+q.z*0.5);
      vertex(q.x+q.z*0.5, q.y+q.z-1);
      endShape();
    }

    arc2(x, y, ss, ss*1.2, 0, TWO_PI, color(0), 20, 0);
    arc2(x, y, ss, ss*1.4, 0, TWO_PI, color(0), 10, 0);
    fill(rcol());
    ellipse(x, y, ss, ss);
    float s2 = ss*random(0.5);
    float s3 = s2*random(0.4, 0.9);
    float dd = random(ss-s2)*random(0.48);
    float a = random(TWO_PI);
    fill(rcol());
    ellipse(x+cos(a)*dd, y+sin(a)*dd, s2, s2);
    fill(rcol());
    ellipse(x+cos(a)*dd, y+sin(a)*dd, s3, s3);

    int col = rcol();
    arc2(x, y, ss, 0, 0, TWO_PI, col, 60, 0);
    arc2(x, y, ss, ss*0.4, 0, TWO_PI, col, 60, 0);
  }

  /*
  quads = new ArrayList<PVector>();
   quads.add(new PVector(0, 0, width));
   sub = 20;
   for (int i = 0; i < sub; i++) {
   int ind = int(random(quads.size()));
   PVector q = quads.get(ind);
   int div = int(random(1, 4))*2+1;
   float xx = q.x;
   float yy = q.y;
   float ss = q.z/div;
   for (int y = 0; y < div; y++) {
   for (int x = 0; x < div; x++) {
   quads.add(new PVector(xx+x*ss, yy+y*ss, ss));
   }
   }
   quads.remove(ind);
   }
   
   for (int i = 0; i < quads.size(); i++) {
   PVector q = quads.get(i);
   
   if (random(1) < 0.3) {
   fill(rcol(), random(255));
   beginShape();
   vertex(q.x, q.y+q.z*0.5);
   vertex(q.x+q.z*0.5, q.y);
   vertex(q.x+q.z, q.y+q.z*0.5);
   vertex(q.x+q.z*0.5, q.y+q.z);
   endShape();
   }
   }
   */

  ArrayList<PVector> circles = new ArrayList<PVector>();
  int cc = 10000;
  for (int i = 0; i < cc; i++) {
    float x = random(-200, width+200);
    float y = random(-200, height+200); 
    float s = width*random(map(i, 0, cc, 0.8, 0.1));

    boolean add = true;
    for (int j = 0; j < circles.size(); j++) {
      PVector c = circles.get(j);
      if (dist(x, y, c.x, c.y) < (s+c.z)*0.5) {
        add = false;
        break;
      }
    }

    if (add) circles.add(new PVector(x, y, s));
  }


  float det = random(0.01);
  float des = random(10000);
  float amp = width*0.02;
  for (int i = 0; i < circles.size(); i++) {
    if (random(1) < 0.4) continue;
    PVector c = circles.get(i);
    fill(rcol());
    float x = c.x;
    float y = c.y;
    float r = c.z*0.5;
    int res = int(r*PI);
    float da = TWO_PI/res;

    ArrayList<PVector> v1 = new ArrayList<PVector>(); 
    ArrayList<PVector> v2 = new ArrayList<PVector>(); 
    noiseDetail(1);
    for (int j = 0; j < res; j++) {
      float x1 = x+cos(da*j)*r;
      float y1 = y+sin(da*j)*r;
      float ang = noise(des+x1*det, des+y1*det)*TWO_PI*2;
      x1 += cos(ang)*amp;
      y1 += sin(ang)*amp;

      v1.add(new PVector(x1, y1));

      float x2 = x+cos(da*j)*r*1.2;
      float y2 = y+sin(da*j)*r*1.2;
      ang = noise(des+x2*det, des+y2*det)*TWO_PI*2;
      x2 += cos(ang)*amp;
      y2 += sin(ang)*amp;

      v2.add(new PVector(x2, y2));
    }

    float ang = noise(des+x*det, des+y*det)*TWO_PI*2;
    float cx = x+cos(ang)*amp;
    float cy = y+sin(ang)*amp;
    int col = rcol();
    for (int j = 0; j < v1.size(); j++) { 
      PVector b1 = v1.get(j);
      PVector b2 = v1.get((j+1)%v1.size());
      beginShape();
      fill(col, 0);
      vertex(cx, cy);
      fill(col, 255);
      vertex(b1.x, b1.y);
      vertex(b2.x, b2.y);
      endShape(CLOSE);
      PVector s1 = v2.get(j);
      PVector s2 = v2.get((j+1)%v1.size());
      beginShape();
      fill(0, 0);
      vertex(s1.x, s1.y);m
      vertex(s2.x, s2.y);
      fill(0, 30);
      vertex(b2.x, b2.y);
      vertex(b1.x, b1.y);
      endShape(CLOSE);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FE0075, #5731A0, #000063, #213DC3, #85CEFF};
//int colors[] = {#2B3F3E, #312A3B, #F25532, #43251B, #C81961, #373868, #FFF8DC};

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