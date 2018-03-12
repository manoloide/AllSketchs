void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
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
  background(10);//getColor(random(colors.length)));

  float fov = PI/random(1.01, random(1, 2.6));
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width/2, height/2, 0);

  float hh = width*random(3, 6);
  float radius = width*random(1., 1.8);
  int hr = 128;
  int res = 128;
  float da = TWO_PI/res;

  //for (int k = 0; k < 3; k++) {
  rotateZ(random(TWO_PI));
  rotateX(random(TWO_PI));
  rotateY(random(TWO_PI));

  FloatList hs = new FloatList();
  hs.append(hr*2);
  int div = int(random(80));
  for (int i = 0; i < div; i++) {
    int ind = int(random(hs.size()*random(1)));
    float val = hs.get(ind)/2;
    if (val >= 1) {
      hs.remove(ind);
      hs.append(val);
      hs.append(val);
    }
  }

  stroke(255, 10);
  //noStroke();
  float h1 = -hr/2;
  for (int j = 0; j < hs.size(); j++) {
    float h2 = h1+hs.get(j);
    float ic = random(colors.length);
    float dc = 3+(colors.length*1./res)*(int(random(7)));//random(100)*random(1)*random(1);
    if (random(1) < 0.5) {
      //dc = 3+random(0.03);
    }
    for (int i = 0; i < res; i++) {
      float x1 = cos(da*i)*radius;
      float y1 = sin(da*i)*radius;
      float x2 = cos(da*i+da)*radius;
      float y2 = sin(da*i+da)*radius;
      float hh1 = hh*map(h1, 0, hr, -0.5, 0.5);
      float hh2 = hh*map(h2, 0, hr, -0.5, 0.5);

      //fill(getColor(random(colors.length)));
      noStroke();
      fill(getColor(dc*i+ic));
      beginShape();
      vertex(x1, y1, hh1);
      vertex(x1, y1, hh2);
      vertex(x2, y2, hh2);
      vertex(x2, y2, hh1);
      endShape();

      float s1 = 0;
      float s2 = 20;
      if (i%2 == 0) {
        s1 = s2;
        s2 = 0;
      }
      stroke(255, 40);
      beginShape();
      fill(0, s1);
      vertex(x2, y2, hh1);
      vertex(x1, y1, hh1);
      fill(0, s2);
      vertex(x1, y1, hh2);
      vertex(x2, y2, hh2);
      endShape();
    }
    h1 = h2;
  }
  //}
}

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}