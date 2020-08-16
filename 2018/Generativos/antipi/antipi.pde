int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(16);
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
  background(0);
  randomSeed(seed);

  float fov = PI/random(1.4, 4);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2, -900);
  float ma = PI*0.3;
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
    rect(r.x, r.y, r.z, r.z);
    float hh = r.z*1;
    float cx = r.x+r.z*0.5;
    float cy = r.y+r.z*0.5;
    int div = int(random(2, 12));

    float xs[] = {r.x, r.x+r.z, r.x+r.z, r.x};
    float ys[] = {r.y, r.y, r.y+r.z, r.y+r.z};

    fill(100);
    stroke(255);

    /*
    fill(rcol());
     beginShape();
     vertex(r.x, r.y, hh);
     vertex(cx, cy, hh*0.5);
     vertex(r.x+r.z, r.y, hh);
     endShape(CLOSE);
     fill(rcol());
     beginShape();
     vertex(r.x, r.y, hh);
     vertex(r.x+r.z, r.y, 0);
     vertex(r.x+r.z, r.y, 0);
     vertex(r.x, r.y, hh);
     endShape(CLOSE);
     
     
     fill(rcol());
     beginShape();
     vertex(r.x+r.z, r.y, hh);
     vertex(cx, cy, hh*0.5);
     vertex(r.x+r.z, r.y+r.z, hh);
     endShape(CLOSE);
     fill(rcol());
     beginShape();
     vertex(r.x+r.z, r.y, hh);
     vertex(r.x+r.z, r.y+r.z, hh);
     vertex(r.x+r.z, r.y+r.z, 0);
     vertex(r.x+r.z, r.y, 0);
     endShape(CLOSE);
     
     fill(rcol());
     beginShape();
     vertex(r.x+r.z, r.y+r.z, hh);
     vertex(cx, cy, hh*0.5);
     vertex(r.x, r.y+r.z, hh);
     endShape(CLOSE);
     fill(rcol());
     beginShape();
     vertex(r.x+r.z, r.y+r.z, hh);
     vertex(r.x, r.y+r.z, hh);
     vertex(r.x, r.y+r.z, 0);
     vertex(r.x+r.z, r.y+r.z, 0);
     endShape(CLOSE);
     
     fill(rcol());
     beginShape();
     vertex(r.x, r.y+r.z, hh);
     vertex(cx, cy, hh*0.5);
     vertex(r.x, r.y, hh);
     endShape(CLOSE);
     fill(rcol());
     beginShape();
     vertex(r.x, r.y+r.z, hh);
     vertex(r.x, r.y, hh);
     vertex(r.x, r.y, 0);
     vertex(r.x, r.y+r.z, 0);
     endShape(CLOSE);
     
     noFill();
     stroke(255);
     */

    noStroke();
    for (int j = 0; j < div; j++) {
      float v1 = map(j, 0, div, 0, 1);
      float v2 = map(j+1, 0, div, 0, 1);

      for (int k = 0; k < 4; k++) {
        float x1 = lerp(xs[k], xs[(k+1)%4], v1);
        float y1 = lerp(ys[k], ys[(k+1)%4], v1);
        float x2 = lerp(xs[k], xs[(k+1)%4], v2);
        float y2 = lerp(ys[k], ys[(k+1)%4], v2);

        beginShape();
        fill(rcol());        
        vertex(cx, cy, hh*0.5);
        fill(rcol());
        vertex(x1, y1, hh);
        vertex(x2, y2, hh);
        endShape();

        beginShape();
        fill(rcol());
        vertex(x1, y1, 0);
        vertex(x2, y2, 0);
        fill(rcol());
        vertex(x2, y2, hh);
        vertex(x1, y1, hh);
        endShape();
        //line(cx, cy, hh*0.5, x1, y1, hh);
        //line(x1, y1, 0, x1, y1, hh);
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