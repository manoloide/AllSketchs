int seed = int(random(999999));


void setup() {
  size(960, 960, P2D);
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
  background(rcol());
  background(0);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(1, 8));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    int div = int(random(2, 6));
    float ss = r.z*1./div;
    for (int y = 0; y < div; y++) {
      for (int x = 0; x < div; x++) {
        rects.add(new PVector(r.x+x*ss, r.y+y*ss, ss));
      }
    }
    rects.remove(ind);
  }


  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float x = r.x;
    float y = r.y;
    float s = r.z;
    color col = getColor();
    if (random(1) < 0.5) {
      beginShape();
      fill(lerpColor(col, getColor(), random(0.5)));
      vertex(x, y);
      vertex(x+s, y);
      fill(lerpColor(col, getColor(), random(0.5)));
      vertex(x+s, y+s);
      vertex(x, y+s);
      endShape(CLOSE);
    } else { 
      beginShape();
      fill(lerpColor(col, getColor(), random(0.5)));
      vertex(x, y+s);
      vertex(x, y);
      fill(lerpColor(col, getColor(), random(0.5)));
      vertex(x+s, y);
      vertex(x+s, y+s);
      endShape(CLOSE);
    }
    //rect(x, y, r.z, r.z);
    int div = int(random(2, 16));
    float ss = r.z/div;
    for (int jj = 0; jj < div; jj++) {
      for (int ii = 0; ii < div; ii++) { 
        float xx = x+ii*ss;
        float yy = y+jj*ss;
        fill(getColor(), 90);
        rect(xx, yy, ss, ss);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};

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