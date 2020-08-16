int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
    seed = int(random(999999));
  }
}

void generate() {

  randomSeed(seed);

  background(#141414);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(1000)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    if (ms <= 15) continue;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    noFill();
    stroke(255, 10);
    rect(r.x, r.y, r.z, r.z);
    if (random(1) < 0.4) gridPoint(r.x, r.y, r.z, r.z, 5);
    if (random(1) < 0.4) gridPoint(r.x, r.y, r.z, r.z, 2.5);
    if (random(1) < 0.4) gridLine(r.x, r.y, r.z, r.z, 15);
    if (random(1) < 0.4) gridTri(r.x, r.y, r.z, r.z, 4, 15);

    noStroke();
    fill(255, 80);
    rectTri(r.x+0.5, r.y+0.5, r.z, r.z, 3);

    int rnd = int(random(1));

    if (rnd == 0) {
      float bb = r.z*0.08;
      int div = int(random(4, 13));
      float hh = (r.z-bb*2)/div;
      for (int j = 0; j < div; j++) {
        fill(255, noise(frameCount*0.1+j)*256);
        rect(r.x+bb, r.y+bb+hh*j, r.z-bb*2, hh*0.3);
        rect(r.x+bb, r.y+bb+hh*j, r.z-bb*2, hh*0.3);
      }
    }
  }
}

void gridPoint(float x, float y, float w, float h, float sep) {
  int cw = int(w/sep); 
  int ch = int(h/sep); 
  for (int j = 1; j < ch; j++) {
    for (int i = 1; i < cw; i++) {
      point(x+i*sep+0.5, y+j*sep+0.5);
    }
  }
}

void gridTri(float x, float y, float w, float h, float s, int sep) {
  int cw = int(w/sep); 
  int ch = int(h/sep); 
  pushStyle();
  rectMode(CENTER);
  for (int j = 1; j < ch; j++) {
    for (int i = 1; i < cw; i++) {
      float xx = x+i*sep+0.5;
      float yy = y+j*sep+0.5;
      pushMatrix();
      translate(xx, yy);
      rotate(HALF_PI*0.5);
      rect(0, 0, s, s);
      popMatrix();
    }
  }
  popStyle();
}

void gridLine(float x, float y, float w, float h, int sep) {
  for (int i = 0; i <= w; i+=sep) {
    line(x+i, y, x+i, y+h);
  }
  for (int i = 0; i <= h; i+=sep) {
    line(x, y+i, x+w, y+i);
  }
}

void rectTri(float x, float y, float w, float h, float b) {
  beginShape();
  vertex(x, y);
  vertex(x+b, y);
  vertex(x, y+b);
  endShape(CLOSE);
  beginShape();
  vertex(x+w, y);
  vertex(x+w-b, y);
  vertex(x+w, y+b);
  endShape(CLOSE);
  beginShape();
  vertex(x+w, y+h);
  vertex(x+w-b, y+h);
  vertex(x+w, y+h-b);
  endShape(CLOSE);
  beginShape();
  vertex(x, y+h);
  vertex(x+b, y+h);
  vertex(x, y+h-b);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#7FD1E2, #4D2F53, #E22570, #30C09D, #EAB300};
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