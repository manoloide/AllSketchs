int seed = int(random(9999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}


void draw() {
  //if (frameCount%120 == 0) seed = int(random(9999999));
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(rcol());

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  for (int i = 0; i < 0; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    rects.add(new PVector(r.x, r.y, r.z*0.5));
    rects.add(new PVector(r.x+r.z*0.5, r.y, r.z*0.5));
    rects.add(new PVector(r.x, r.y+r.z*0.5, r.z*0.5));
    rects.add(new PVector(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.5));
    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    fill(rcol());
    int cc = int(r.z*random(0.1, 1)*random(1)+1);
    float ic = random(colors.length);
    float dc = random(colors.length*2)*random(1)*random(1);
    float rt = random(-0.02, 0.02);
    float ang = random(TWO_PI);
    float da = random(-0.1, 0.1);
    float dd = random(1);
    rectMode(CENTER);
    float xx = r.x+r.z*0.5;
    float yy = r.y+r.z*0.5;
    for (int j = 0; j < cc; j++) {
      float ss = map(j, 0, cc, r.z, 0);
      float smo = map(j, 0, cc, 0, 0.5)*r.z;
      fill(getColor(ic+dc*j));
      pushMatrix();
      translate(xx, yy);
      rotate(rt*j);
      rect(0, 0, ss, ss, smo);
      popMatrix();
      xx += cos(ang+da*j)*dd;
      yy += sin(ang+da*j)*dd;
    }
  }
}

//https://coolors.co/12baa3-f7df0c-f4f4f4-154fef-eba5ff
int colors[] = {#12baa3, #f7df0c, #f4f4f4, #154fef, #eba5ff};
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