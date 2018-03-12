int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);


  background(90);
  for (int j = 0; j < 10; j++) {
    ArrayList<PVector> rects = new ArrayList<PVector>();
    rects.add(new PVector(0, 0, width));
    int sub = int(random(200)*random(1));
    for (int i = 0; i < sub; i++) {
      int ind = int(random(rects.size()));
      PVector r = rects.get(ind);
      float ss = r.z*0.5;
      rects.add(new PVector(r.x, r.y, ss));
      rects.add(new PVector(r.x+ss, r.y, ss));
      rects.add(new PVector(r.x+ss, r.y+ss, ss));
      rects.add(new PVector(r.x, r.y+ss, ss));
      rects.remove(ind);
    }

    noStroke();
    float dc = random(1);
    for (int i = 0; i < rects.size(); i++) {
      PVector r = rects.get(i);
      fill(getColor(int(random(colors.length))+dc));
      if (random(1) < 0.0) rect(r.x, r.y, r.z, r.z);
      else if (random(1) < 0.8) {
        float ic = random(colors.length);
        float ddc = random(colors.length)*random(1)*random(1)*random(12)*random(0.1);
        boolean hor = random(1) < 0.5;
        float pr = random(-0.1, 0.2);
        for (int k = 0; k < r.z; k++) {
          fill(getColor(ic+ddc*k));
          if (hor) rect(r.x+k, r.y, 1, r.z);
          else rect(r.x, r.y+k, r.z, 1);
          if (random(1) < pr) hor = !hor;
        }
      }
    }
  }
}
//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
//int colors[] = {#DB1136, #00B0BA, #3B0BE8, #FFE15B, #3D2C2E};
int colors[] = {#EAA104, #F9BBD1, #47A1BC, #EA2525};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}