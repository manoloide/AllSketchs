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

  int cc = 30;
  int cg = 10;
  float gs = width*1./(cc*cg);

  float bb = 0;//int(random(40, 70));
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
  float det = random(0.01);
  for (int i = 0; i < cc; i++) {
    stroke(0, 40);
    fill(255, random(8));
    rect(bb, bb+ss*i, ts, ss);
    strokeWeight(1);
    line(bb, bb+(i+0.5)*ss, width-bb, bb+(i+0.5)*ss);
    
    
    ArrayList<PVector> mountain = new ArrayList<PVector>();

    float lx = bb;
    float ly = bb+(i+0.5)*ss;
    det *= random(0.99, 1.01);
    while (lx < width-bb) {
      float ang = map(noise(lx*det, ly*det), 0, 1, PI*1.5, PI*2.5);
      lx += cos(ang);
      ly += sin(ang);
      mountain.add(new PVector(lx, ly)); 
    }
    stroke(0, 180);
    noStroke();
    fill(rcol(), 220);
    beginShape();
    vertex(bb, height-bb);
    for(int j = 0; j < mountain.size(); j++){
      PVector p = mountain.get(j);
      vertex(p.x, constrain(p.y, bb, width-bb));
    }
    vertex(width-bb, height-bb);
    endShape();
    fill(rcol(), 20);
    beginShape();
    vertex(bb, bb);
    for(int j = 0; j < mountain.size(); j++){
      PVector p = mountain.get(j);
      vertex(p.x, constrain(p.y, bb, width-bb));
    }
    vertex(width-bb, bb);
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
