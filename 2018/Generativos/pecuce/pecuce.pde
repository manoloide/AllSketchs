int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));

  int div = int(random(10, 120));
  for (int i = 0; i < div; i++) {
    int ind = int(random(quads.size()*random(1)));
    PVector q = quads.get(ind);
    float ms = q.z*0.5;
    quads.add(new PVector(q.x, q.y, ms));
    quads.add(new PVector(q.x+ms, q.y, ms));
    quads.add(new PVector(q.x+ms, q.y+ms, ms));
    quads.add(new PVector(q.x, q.y+ms, ms));
    quads.remove(ind);
  }

  noStroke();
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    int sub = 8;//int(random(3, 13));
    float ss = q.z/sub;
    int sel = int(random(4));
    for (int j = 0; j < sub; j++) {
      fill(rcol());
      float mm = j*ss;
      if (sel == 0) rect(q.x, q.y, q.z-mm, q.z-mm);
      if (sel == 1) rect(q.x+mm, q.y, q.z-mm, q.z-mm);
      if (sel == 2) rect(q.x+mm, q.y+mm, q.z-mm, q.z-mm);
      if (sel == 3) rect(q.x, q.y+mm, q.z-mm, q.z-mm);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#F0C4D1, #EF514A, #373B92, #262046};
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