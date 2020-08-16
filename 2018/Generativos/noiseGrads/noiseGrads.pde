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

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  int cc = 60;
  int cg = 5;
  float gs = width*1./(cc*cg);

  float bb = 0;
  float ts = width-bb*2;
  float ss = ts/cc;
  stroke(0, 120);
  for (float j = 0; j < height; j+=gs) {
    for (float i = 0; i < width; i+=gs) {
      point(i, j);
    }
  }

  stroke(0, 40);
  fill(255, 4);
  rect(bb-2, bb-2, ts+4, ts+4);
  noFill();
  int cor = 16;
  float det = random(0.01);
  ArrayList[] mountains = new ArrayList[cc+cor];
  for (int i = -cor/2; i < cc+cor/2; i++) {
    stroke(0, 40);
    fill(255, random(8));
    rect(bb, bb+ss*i, ts, ss);
    strokeWeight(1);
    line(bb, bb+(i+0.5-2)*ss, width-bb, bb+(i+0.5)*ss);

    ArrayList<PVector> mountain = new ArrayList<PVector>();

    float lx = bb;
    float ly = bb+(i+0.5)*ss;
    det *= random(0.99, 1.01);
    int iter = 0;
    while (iter < 1100) {//lx < width-bb) {
      float ang = map(noise(lx*det, ly*det), 0, 1, PI*1.5, PI*2.5);
      lx += cos(ang);
      ly += sin(ang);
      mountain.add(new PVector(lx, ly));
      iter++;
    }

    PVector fp = mountain.get(0);
    PVector lp = mountain.get(mountain.size()-1);
    float dis = fp.dist(lp);
    float ang = atan2(lp.y-fp.y, lp.x-fp.x);
    println(ang);
    for (int j = 0; j < mountain.size(); j++) {
      PVector ap = mountain.get(j).copy();
      ap.sub(fp);
      ap.rotate(-ang);
      ap.mult(ts/dis);
      ap.add(fp);
      mountain.get(j).set(ap);
    }

    mountains[i+cor/2] = mountain;
  }

  for (int i = 0; i < mountains.length-1; i++) {
    ArrayList<PVector> mountain1 = mountains[i];
    ArrayList<PVector> mountain2 = mountains[i+1];
    
    float ic = random(colors.length);
    float vc = random(1)*random(100);
    if(random(1) < 0.1) vc *= random(10);
    
    stroke(0, 180);
    //noStroke();
    //fill(rcol(), 90);
    noStroke();
    beginShape(QUADS);
    for (int j = 0; j < mountain1.size()-1; j++) {
      PVector p1 = mountain1.get(j);
      PVector p2 = mountain1.get(j+1);
      PVector p3 = mountain2.get(j+1);
      PVector p4 = mountain2.get(j);
      fill(getColor(ic+vc*j));
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(getColor(ic+vc*(j+1)), 180);
      vertex(p3.x, p3.y);
      vertex(p4.x, p4.y);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
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
