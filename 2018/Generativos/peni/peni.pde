int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(2);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(#E3DADB);

  int gg = int(random(40, 100));
  float gs = width*1./gg;
  noStroke();
  for (int j = 0; j < gg; j++) {
    for (int i = 0; i < gg; i++) {
      fill(0, 5);
      rect(i*gs+1, j*gs+1, 4, 4);
      fill(255, 50);
      rect(i*gs, j*gs, 4, 4);
    }
  }

  //nodos();

  int cc = int(random(2, 8));
  float ss = width/(cc+1);

  float ds = ss*0.25;
  for (int j = 0; j < cc*4+2; j++) {
    for (int i = 0; i < cc*4+2; i++) {
      fill(rcol(colors), 8);
      ellipse(i*ds, j*ds, ds, ds);
      fill(rcol(colors), 12);
      ellipse(i*ds, j*ds, ds*0.5, ds*0.5);
    }
  }

  float bb = 9;
  float des = 2;
  float s = ss-bb;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+0.5)*ss+bb*0.5;
      float yy = (j+0.5)*ss+bb*0.5;
      noStroke();
      fill(rcol(backs), 200);
      rect(xx+des, yy+des, ss-bb, ss-bb, 3);
      stroke(0, 240);
      fill(0, 2);
      rect(xx, yy, ss-bb, ss-bb, 4);

      int rnd = int(random(4));
      float cx = xx+(ss-bb)*0.5;
      float cy = yy+(ss-bb)*0.5;

      noStroke();
      if (rnd == 0) {
        fill(0, 15);
        ellipse(cx+2, cy+2, ss*0.5, ss*0.5);
        fill(rcol(colors));
        ellipse(cx, cy, ss*0.5, ss*0.5);
      }
      if (rnd == 1) {
        fill(0, 15);
        diamont(cx+2, cy+2, ss*0.8);
        fill(rcol(colors));
        diamont(cx, cy, ss*0.8);
      }

      if (rnd == 2) {
        float sss = ss*0.4;
        fill(0, 15);
        rect(cx-sss*0.5+2, cy-sss*0.5+2, sss, sss);
        fill(rcol(colors));
        rect(cx-sss*0.5, cy-sss*0.5, sss, sss);
      }

      if (rnd == 3) {
        int div = int(pow(2, int(random(1, 4))));
        float sss = s/div;
        float ns = sss*random(0.6, 0.8);
        float dd = (sss-ns)*0.5+des;
        for (int jj = 0; jj < div; jj++) {
          for (int ii = 0; ii < div; ii++) {
            fill(rcol(colors));
            rect(xx+sss*ii+dd, yy+sss*jj+dd, ns, ns, ns*0.1);
          }
        }
      }

      fill(rcol(colors), 20);
      ellipse(cx, cy, ss*0.1, ss*0.1);
      fill(rcol(colors));
      diamont(cx, cy, ss*0.08);
      fill(rcol(colors));
      diamont(cx, cy, ss*0.04);
    }
  }

  noFill();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float r = width*random(0.012);
    float a1 = random(TAU);
    float a2 = a1+random(HALF_PI); 
    stroke(random(255), random(255)*random(1));
    arc(x, y, r, r, a1, a2);
  }

  fill(rcol(colors));
  circle(width/2, height/2, width*random(0.3, 0.5));
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int res = int(max(8, r*PI));
  float da = TWO_PI/res;

  beginShape();
  for (int i = 0; i < res; i++) {
    float xx = x+cos(da*i);
    float yy = y+sin(da*i);
    float rr = r*map(noise(xx, yy), 0, 1, 0.6, 1);
    vertex(xx*rr, yy*rr);
  }
  endShape(CLOSE);
}

void nodos() {
  ArrayList<PVector> points = new ArrayList<PVector>();
  int cc = int(random(50)*random(0.1, 1));
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(width*random(0.2, 0.8), height*random(0.2, 0.8)));
  }

  stroke(0, 20);
  for (int j = 0; j < points.size(); j++) {
    PVector p1 = points.get(j);
    for (int i = 0; i < points.size(); i++) {
      PVector p2 = points.get(i);
      if (p1.dist(p2) < 140) {
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    int col = rcol(colors);
    fill(col, 220);
    //stroke(col, 4);
    ellipse(p.x, p.y, 140, 140);
    noStroke();
    fill(#010101);
    ellipse(p.x, p.y, 4, 4);
  }
}

void diamont(float x, float y, float s) {
  float r = s*0.5;
  beginShape();
  vertex(x-r, y);
  vertex(x, y-r);
  vertex(x+r, y);
  vertex(x, y+r);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int backs[] = {#00A75B, #42B6F0, #ECABB4};
int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}
int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}