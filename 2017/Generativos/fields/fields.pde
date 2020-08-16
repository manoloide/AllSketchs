int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

PVector des(PVector pos, float d, float s) {
  pos.x += noise(pos.x*d, pos.y*d)*s; 
  pos.y += noise(pos.x*d, pos.y*d)*s;
  return pos;
}

void generate() {
  seed = int(random(999999));
  noiseSeed(seed);
  randomSeed(seed);

  for (int c = 0; c < 1; c++) {
    noStroke();
    fill(getColor(random(colors.length)), 4);
    rect(width/2, height/2, width, height);
    pushMatrix();
    translate(width/2, height/2);
    rotate(random(TWO_PI));

    ArrayList<PVector> quads = new ArrayList<PVector>();
    quads.add(new PVector(0, 0, width*2));
    int sub = int(random(3, 10));
    sub = 0;
    for (int i = 0; i < sub; i++) {
      int ind = int(random(quads.size()));
      PVector q = quads.get(ind);
      float ms = q.z*0.5;
      quads.add(new PVector(q.x-ms*0.5, q.y-ms*0.5, ms));
      quads.add(new PVector(q.x+ms*0.5, q.y-ms*0.5, ms));
      quads.add(new PVector(q.x+ms*0.5, q.y+ms*0.5, ms));
      quads.add(new PVector(q.x-ms*0.5, q.y+ms*0.5, ms));
      quads.remove(ind);
    }

    for (int i = 0; i < 100; i++) {
      fill(getColor(random(colors.length)));
      float xx = random(width);
      float yy = random(height);
      float ss = width*(random(0.1)-c*0.01);
      ellipse(xx, yy, ss, ss);
    }
    noStroke();
    rectMode(CENTER);
    float det = random(0.01)*random(1);
    for (int i = 0; i < quads.size(); i++) {
      int cc = int(random(6, 200)/quads.size());
      PVector q = quads.get(i);
      float des = q.z*random(0.2);
      rects(q.x, q.y, q.z, q.z, cc, det, des, 1);//random(0.6, 0.9)-c*0.15);
      //rect(q.x, q.y, q.z, q.z);
    }
    popMatrix();
  }
} 

void rects(float x, float y, float w, float h, float c, float det, float des, float prob) {
  float sx = w*1./c;
  float sy = h*1./c;
  pushMatrix();
  translate(-w*0.5+x, -h*0.5+y);
  for (int j = 0; j < c; j++) {
    for (int i = 0; i < c; i++) {
      if (prob < random(1)) continue;
      PVector p1 = des(new PVector(   i*sx, j*sy), det, des);
      PVector p2 = des(new PVector(i*sx+sx, j*sy), det, des);
      PVector p3 = des(new PVector(i*sx+sx, j*sy+sy), det, des);
      PVector p4 = des(new PVector(   i*sx, j*sy+sy), det, des);
      PVector ce = p1.copy();
      ce.add(p2); 
      ce.add(p3); 
      ce.add(p4);
      ce.div(4);

      quad(p1, p2, p3, p4);

      stroke(rcol(), random(256)*random(1));
      line(p1.x, p1.y, ce.x, ce.y);
      line(p2.x, p2.y, ce.x, ce.y);
      line(p3.x, p3.y, ce.x, ce.y);
      line(p4.x, p4.y, ce.x, ce.y);
      noStroke();

      fill(rcol());
      if (random(1) < 0.5) ellipse(ce.x, ce.y, sx*0.08, sy*0.08);
      else {
        pushMatrix();
        rectMode(CENTER);
        translate(ce.x, ce.y);
        rotate(PI*0.5);
        rect(0, 0, sx*0.1, sx*0.08);
        popMatrix();
      }
    }
  }
  popMatrix();
}

void quad(PVector p1, PVector p2, PVector p3, PVector p4) {
  int col = getColor(random(colors.length));
  beginShape();
  fill(col);
  vertex(p1.x, p1.y);
  fill(lerpColor(col, color(255), 0.03));
  vertex(p2.x, p2.y);
  fill(col);
  vertex(p3.x, p3.y);
  fill(lerpColor(col, color(0), 0.03));
  vertex(p4.x, p4.y);
  endShape();
}

int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}