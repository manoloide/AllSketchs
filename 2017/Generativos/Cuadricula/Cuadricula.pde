int seed = int(random(999999));

void setup() {
  size(920, 920, P3D);
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

  int rh = int(random(2, 100));
  int rw = int(random(2, 200));

  float det = random(0.005);
  float des = random(100);

  float dw = width*1./rw;
  float dh = width*1./rh;
  float hh = dw*2.0;

  stroke(0, 90);
  for (int j = 0; j < rh; j++) {
    float ic = random(colors.length);
    float dc = 3+random(0.02);//random(100)*random(1)*random(1);
    for (int i = 0; i < rw; i++) {
      float x1 = i*dw;
      float y1 = j*dh;
      float x2 = (i+1)*dw;
      float y2 = (j+1)*dh;
      fill(getColor(dc*i+ic));
      beginShape();
      vertex(x1, y1, noise(x1*det, y1*det)*hh);
      vertex(x2, y1, noise(x2*det, y1*det)*hh);
      vertex(x2, y2, noise(x2*det, y2*det)*hh);
      vertex(x1, y2, noise(x1*det, y2*det)*hh);
      endShape(CLOSE);
    }
  }
}
//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};

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