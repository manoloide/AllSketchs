int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
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
  background(rcol());

  randomSeed(seed);

  ambientLight(240, 240, 240);
  directionalLight(20, 20, 20, 0, 1, 0);
  directionalLight(10, 10, 20, -1, 0, 0);
  noStroke();
  ortho();
  translate(width/2, height/2, -1000);
  rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateZ(-HALF_PI*random(0.5));


  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(-width*1.0, -height*1.0, width*2));
  for (int i = 0; i < 100; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    if (ms < 30) continue;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);

    pushMatrix();
    translate(r.x, r.y);

    int rnd = int(random(1));
    if (rnd == 0) {
      int sub = int(random(3, 13));
      float sss = r.z/sub;
      float hh = sss*random(0.1, 2.5);
      float dd = sss*random(0.1, 0.8);
      boolean hor = random(1) < 0.5;
      for (int j = 0; j < sub; j++) {
        int col = rcol();
        pushMatrix();
        if (hor) {
          pushMatrix();
          float hhh = hh*random(1);
          translate((j+0.5)*sss, r.z*0.5, hhh*0.5);
          noStroke();
          fill(col);
          box(dd, r.z, hhh);
          popMatrix();
          pushMatrix();
          translate((j+0.5)*sss, r.z*0.5, hh*0.5);
          stroke(col);
          noFill();
          box(dd, r.z, hh);
          popMatrix();
        } else {
          float hhh = hh*random(1);
          pushMatrix();
          translate(r.z*0.5, (j+0.5)*sss, hhh*0.5);
          noStroke();
          fill(col);
          box(r.z, dd, hhh);
          popMatrix();
          pushMatrix();
          translate(r.z*0.5, (j+0.5)*sss, hh*0.5);
          stroke(col);
          noFill();
          box(r.z, dd, hh);
          popMatrix();
        }
        popMatrix();
      }
    }
    popMatrix();
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

int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};
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