int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

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
  background(0);
  stroke(255);
  noFill();
  randomSeed(seed);
  noStroke();
  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));
  int sub = int(random(random(40, 100)));
  for (int k = 0; k < sub; k++) {
    int ind = int(random(quads.size()*random(1)));
    PVector q = quads.get(ind);
    int div = int(random(2, 4));
    float s = q.z/div;
    for (int j = 0; j < div; j++) {
      for (int i = 0; i < div; i++) {
        quads.add(new PVector(q.x+s*i, q.y+s*j, s));
      }
    }
    quads.remove(ind);
  }

  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    int div = int(pow(2, int(2+random(4))))*2;
    float da = TWO_PI/div;
    beginShape();
    fill(rcol());
    vertex(q.x, q.y);
    vertex(q.x+q.z, q.y);
    fill(rcol());
    vertex(q.x+q.z, q.y+q.z);
    vertex(q.x, q.y+q.z);
    endShape();
    float xx = q.x+q.z*0.5;
    float yy = q.y+q.z*0.5;
    float r = q.z*random(0.2, 0.9);

    ArrayList<PVector> p1 = getRect(xx, yy, q.z, div);
    ArrayList<PVector> p2 = getCircle(xx, yy, r, div);

    for (int j = 0; j < p1.size(); j++) {
      int i1 = j;
      int i2 = (j+1)%p1.size();
      fill(rcol());
      beginShape();
      fill(rcol());
      vertex(p1.get(i1).x, p1.get(i1).y);
      vertex(p1.get(i2).x, p1.get(i2).y);
      fill(rcol());
      vertex(p2.get(i2).x, p2.get(i2).y);
      vertex(p2.get(i1).x, p2.get(i1).y);
      endShape(CLOSE);
    }
  }
}

ArrayList<PVector> getRect(float x, float y, float s, int sub) {
  ArrayList<PVector> aux = new ArrayList<PVector>();
  float r2 = s*0.5*sqrt(2);
  for (int i = 0; i < 4; i++) {
    float x1 = cos((i+0.5)*HALF_PI)*r2;
    float y1 = sin((i+0.5)*HALF_PI)*r2;
    float x2 = cos((i+1.5)*HALF_PI)*r2;
    float y2 = sin((i+1.5)*HALF_PI)*r2;
    for (int j = 0; j < sub/4; j++) {
      float xx = x+map(j, 0, sub/4, x1, x2);
      float yy = y+map(j, 0, sub/4, y1, y2);
      aux.add(new PVector(xx, yy));
    }
  }

  return aux;
}


ArrayList<PVector> getCircle(float x, float y, float s, int sub) {
  float r = s*0.5;
  ArrayList<PVector> aux = new ArrayList<PVector>();
  float da = TWO_PI/sub;
  for (int j = 0; j < sub; j++) {
    aux.add(new PVector(x+cos(da*j+HALF_PI*0.5)*r, y+sin(da*j+HALF_PI*0.5)*r));
  }
  return aux;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#2B3F3E, #312A3B, #F25532, #43251B, #C81961, #373868, #FFF8DC};

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