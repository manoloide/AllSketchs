int seed = int(random(999999));

void setup() {
  size(displayWidth, displayHeight, P2D);
  smooth(4);
  pixelDensity(2);
  frameRate(30);
  generate();
}

void draw() {
  
  drawWaves();
  
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
  seed = int(random(999999));
}

void drawWaves() {

  if (frameCount%(20*30) == 0) {
    seed = int(random(999999));
  }


  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(int(random(1, 8)));

  background(rcol());
  float time = millis()*0.00001;
  if (random(1) < 0.1) time *= random(300);
  float ani = time*random(0.04, 0.05);



  int cc = 30;
  float ts = width;
  float ss = ts/cc;

  float amplitud = random(8*random(0.25, 1));

  float res = random(1);

  int cor = 0;
  float det = random(0.01);
  ArrayList[] mountains = new ArrayList[cc+cor];
  for (int i = -cor/2; i < cc+cor/2; i++) {

    ArrayList<PVector> mountain = new ArrayList<PVector>();
    float lx = 0;
    float ly = (i+0.5)*ss;
    det *= random(0.99, 1.01);
    int iter = 0;
    while (iter < width*res) {//lx < width-bb) {
      mountain.add(new PVector(lx, ly));
      float ang = map(noise(lx*det, ly*det, ani), 0, 1, PI*1.5, PI*2.5);
      lx += cos(ang)*2;
      ly += sin(ang)*2;
      iter++;
    }

    PVector fp = mountain.get(0);
    PVector lp = mountain.get(mountain.size()-1);
    float dis = fp.dist(lp);
    float ang = atan2(lp.y-fp.y, lp.x-fp.x);
    for (int j = 0; j < mountain.size(); j++) {
      PVector ap = mountain.get(j).copy();
      ap.sub(fp);
      ap.rotate(-ang);
      ap.y *= amplitud;
      ap.mult(ts/dis);
      ap.add(fp);
      mountain.get(j).set(ap);
    }

    mountains[i+cor/2] = mountain;
  }

  for (int i = 0; i < mountains.length-1; i++) {
    ArrayList<PVector> mountain1 = mountains[i];
    ArrayList<PVector> mountain2 = mountains[i+1];

    float ic = random(colors.length)+time*random(2);
    float vc = random(1)*random(400)*random(1)*random(1)*random(1)*pow(random(1), 2);
    if (random(1) < 0.1) vc *= random(10);
    if (random(1) < 0.1) vc *= random(1000);

    stroke(0, 180);
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
//int colors[] = {#ffffff, #000000, #ffffff, #ffffff, #000000, #000000};
int colors[] = {#00171A, #003B4F, #FE766E, #FF4142, #FD072C, #FD7A42, #FEA1B1, #E70976, #001D37};
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
