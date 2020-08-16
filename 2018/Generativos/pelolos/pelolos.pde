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

  int cc = int(random(160, 320*20));
  float ss = height*1./cc;

  stroke(0, 12);
  fill(255, 4);
  noFill();
  float det = random(0.006);
  for (int i = 0; i < cc; i++) {

    ArrayList<PVector> mountain = new ArrayList<PVector>();
    float lx = 0;
    float ly = (i+0.5)*ss;
    det *= random(0.98, 1.02);
    float vel = 0.2+noise(lx*det*0.2, ly*det*0.2)*1.2;
    //vel *= random(3, 5);
    vel *= 3;
    for (int j = 0; j <= width*0.4; j++) {
      float amp = pow(map(j, 0, width*0.5, 0, 1), 2.8)*4;
      float ang = map(noise(lx*det, ly*det), 0, 1, PI*(2-amp), PI*(2+amp));
      mountain.add(new PVector(lx, ly)); 
      lx += cos(ang)*vel;
      ly += sin(ang)*vel;
    }
    noFill();
    stroke(rcol(), 255);
    strokeWeight(random(0.5, 1.2));
    fill(rcol());
    beginShape(QUADS);
    float ic = (cos(i*0.0008)*0.5+0.5)*colors.length;//random(colors.length);
    float dc = random(0.099, 0.1)*0.12;
    stroke(0, 8);
    for (int j = 0; j < mountain.size()-1; j++) {
      PVector p1 = mountain.get(j);
      PVector p2 = mountain.get(j+1);
      int col1 = getColor(ic+dc*j);
      int col2 = getColor(ic+dc*j+dc);
      fill(col1, 255);
      vertex(p1.x, p1.y);
      fill(col2, 255);
      vertex(p2.x, p2.y);
      fill(col2, 0);
      vertex(p2.x, p2.y+2);
      fill(col1, 0);
      vertex(p1.x, p1.y+2);
    }
    endShape();
    strokeWeight(1);
    /*
    fill(rcol(), 20);
     beginShape();
     vertex(bb, bb);
     for(int j = 0; j < mountain.size(); j++){
     PVector p = mountain.get(j);
     vertex(p.x, constrain(p.y, bb, width-bb));
     }
     vertex(width-bb, bb);
     endShape();
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
//int colors[] = {#061431, #2E52DF, #F78DF1, #FEFEFE, #EC3063};
int colors[] = {#AFAAA5, #889033, #7CA521, #1296A1, #83CCD7, #EEA902, #F18D02, #783200, #181A19};
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
