int seed = int(random(999999));

void setup() {
  size(6500, 6500, P2D);
  //smooth(8);
  //pixelDensity(2);

  generate();
  saveImage();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(25);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(100));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    if (ms > 5) {
      rects.add(new PVector(r.x, r.y, ms));
      rects.add(new PVector(r.x+ms, r.y, ms));
      rects.add(new PVector(r.x+ms, r.y+ms, ms));
      rects.add(new PVector(r.x, r.y+ms, ms));
      rects.remove(ind);
    }
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    noFill();
    stroke(255, 10);
    rect(r.x, r.y, r.z, r.z);

    beginShape();
    fill(rcol(), 10);
    vertex(r.x, r.y);
    vertex(r.x+r.z, r.y);
    fill(rcol(), 10);
    vertex(r.x+r.z, r.y+r.z);
    vertex(r.x, r.y+r.z);
    endShape(CLOSE);

    noFill();
    stroke(255, 4);
    int div = int(random(2, 6))*2;
    float ss = r.z*1./div;
    for (int yy = 0; yy < div; yy++) {
      for (int xx = 0; xx < div; xx++) {
        rect(r.x+xx*ss, r.y+yy*ss, ss, ss);
        if (ss > 8) rect(r.x+(xx+0.5)*ss-1, r.y+(yy+0.5)*ss-1, 2, 2);
      }
    }
    ellipse(r.x+r.z*0.5, r.y+r.z*0.5, r.z, r.z);
    line(r.x, r.y, r.x+r.z, r.y+r.z);
    line(r.x+r.z, r.y, r.x, r.y+r.z);

    int rnd = int(random(2));

    if (rnd == 0) {
      poly(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.6, int(random(3, 7)), random(TWO_PI), rcol());
    }
    if (rnd == 1) {
      noStroke();
      int c1 = rcol();
      int c2 = rcol();
      float a = random(TWO_PI);
      while (c1 == c2) c2 = rcol();
      cgrad(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.5, r.z*0.8, c1, c2, a+0);
      cgrad(r.x+r.z*0.5, r.y+r.z*0.5, r.z*0.2, r.z*0.5, c1, c2, a+0.5);
    }
    if (rnd == 2) {
      int caps = int(random(4, 19));
      float hhh = r.z/caps;
      for (int j = 0; j < caps; j++) {
        float h1 = hhh*j;
        float h2 = hhh*(j+1);
        noStroke();
        beginShape();
        fill(rcol(), 20);
        vertex(r.x+r.z*0.0, r.y+h1);
        vertex(r.x+r.z*1.0, r.y+h1);
        fill(rcol(), 20);
        vertex(r.x+r.z*1.0, r.y+h2);
        vertex(r.x+r.z*0.0, r.y+h2);
        endShape(CLOSE);
      }
    }

    stroke(255, 10);
    line(r.x+r.z*0.5, r.y, r.x+r.z*0.5, r.y+r.z);
    line(r.x, r.y+r.z*0.5, r.x+r.z, r.y+r.z*0.5);
  }

  noFill();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.01)*random(1);
    float a1 = random(TWO_PI);
    float a2 = a1+random(HALF_PI);
    stroke(255, random(12));
    arc(x, y, s, s, a1, a2);
  }
}

void poly(float x, float y, float s, int seg, float a, int c1) {
  float r = s*0.5;
  float da = TWO_PI/seg; 
  for (int i = 0; i < seg; i++) {
    float a1 = da*i+a;
    float a2 = a1+da;
    beginShape();
    fill(rcol());
    vertex(x+cos(a1)*r, y+sin(a1)*r);
    fill(rcol());
    vertex(x+cos(a2)*r, y+sin(a2)*r);
    fill(c1);
    vertex(x, y);
    endShape(CLOSE);
  }
}

void cgrad(float x, float y, float s1, float s2, int c1, int c2, float a) {
  float r1 = s1*0.5; 
  float r2 = s2*0.5;

  int seg = max(8, int(s2*PI));
  float da = TWO_PI/seg;
  for (int i = 0; i < seg; i++) {
    float a1 = da*i;
    float a2 = a1+da;

    float v1 = cos(map(i, 0, seg, 0, TAU)+TAU*a)*0.5+0.5;
    float v2 = cos(map(i+1, 0, seg, 0, TAU)+TAU*a)*0.5+0.5;

    int col1 = lerpColor(c1, c2, v1);
    int col2 = lerpColor(c1, c2, v2);

    beginShape();
    fill(col1);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    fill(col2);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    endShape();
  }
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#F8C43D, #023390, #6AA6E2, #F35076, #F6F6F6};
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