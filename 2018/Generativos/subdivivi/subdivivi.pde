int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(32);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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
  background(255);
  randomSeed(seed);

  float fov = PI/random(1.1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2, -400);
  float ma = PI*0.1;
  rotateX(random(-ma, ma));
  rotateY(random(-ma, ma));
  rotateZ(random(-ma, ma));

  float size = 5;
  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(-width*size*0.5, -height*size*0.5, width*size));
  int sub = int(random(20, 1000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float md = r.z*0.5;
    rects.add(new PVector(r.x, r.y, md));
    rects.add(new PVector(r.x+md, r.y, md));
    rects.add(new PVector(r.x+md, r.y+md, md));
    rects.add(new PVector(r.x, r.y+md, md));
    rects.remove(ind);
  }


  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float hh = r.z;
    float cx = r.x+r.z*0.5;
    float cy = r.y+r.z*0.5;
    int div = int(r.z/8);//int(random(2, 12));

    float xs[] = {r.x, r.x+r.z, r.x+r.z, r.x};
    float ys[] = {r.y, r.y, r.y+r.z, r.y+r.z};

    fill(255);
    stroke(0);

    for (int j = 0; j < div; j++) {
      float v1 = map(j, 0, div, 0, 1);
      float v2 = map(j+1, 0, div, 0, 1);

      for (int k = 0; k < 4; k++) {
        float x1 = lerp(xs[k], xs[(k+1)%4], v1);
        float y1 = lerp(ys[k], ys[(k+1)%4], v1);
        float x2 = lerp(xs[k], xs[(k+1)%4], v2);
        float y2 = lerp(ys[k], ys[(k+1)%4], v2);

        beginShape();        
        vertex(cx, cy, hh*0.5);
        vertex(x1, y1, hh);
        vertex(x2, y2, hh);
        endShape();

        beginShape();
        vertex(x1, y1, 0);
        vertex(x2, y2, 0);
        vertex(x2, y2, hh);
        vertex(x1, y1, hh);
        endShape();
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D5E486, #24C0F2, #E3BBE4, #06F8F7, #1B1A36, #E5244D, #1412CE, #FEBD9F, #A861AD, #969ECC, #EB6156, #E94A6A};
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