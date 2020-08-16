import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(0);

  int sub = 1000;

  for (int k = 0; k < 4; k++) {
    float ic1 = random(colors.length);
    float dc1 = random(0.01)*random(0.4, 1);  
    float ic2 = random(colors.length);
    float dc2 = random(0.01)*random(0.4, 1);

    float pwr = random(1, 3);

    noStroke();
    //stroke(#152425, 20);
    for (int i = 0; i < sub; i++) {
      float v1 = pow(map(i, 0, sub, 0, 1), pwr);
      float v2 = pow(map(i+1, 0, sub, 0, 1), pwr);
      float y1 = v1*height;
      float y2 = v2*height;

      beginShape();
      fill(getColor(ic1+dc1*(i+1)), 180);
      vertex(0, y2);
      fill(getColor(ic1+dc1*(i)), 180);
      vertex(0, y1);
      fill(getColor(ic2+dc2*(i)), 180);
      vertex(width, y1);
      fill(getColor(ic2+dc2*(i+1)), 180);
      vertex(width, y2);
      endShape(CLOSE);
    }
  }


  float bb = 20;

  for (int i = 0; i < 500; i++) {
    float w = int(random(12, 30)*random(0.5, 1))*10;
    float h = int(random(9, 20)*random(0.7, 1))*10;
    w -= w%40;
    h -= h%40;
    float x = random(bb, width-bb-w);
    float y = random(bb, height-bb-h);
    //w -= w%40;
    y += h;
    y -= y%80;

    y -= h-80+bb;

    build(x, y, w, h, int(random(8, 30)*0.5), int(random(8, 30)*0.5), int(random(8, 30)*0.5));
  }
}

void build(float x, float y, float w, float h, int c1, int c2, int c3) {

  noStroke();
  //blendMode(ADD);
  int col = int(random(colors.length));
  beginShape();
  fill(getColor(col), 200);
  vertex(x, y);
  vertex(x+w, y);
  fill(getColor(col+0.1), 200);
  vertex(x+w, y+h);
  vertex(x, y+h);
  endShape();

  float hh = h/(c1+1);

  float col1 = random(colors.length);
  float col2 = random(colors.length);
  float val = random(1);

  boolean rndCol = random(1) < 0.8;

  blendMode(NORMAL);
  for (int i = 0; i < c1; i++) {
    float xx = x+1;
    float yy = y+1+hh*(i+0.5);

    int cc = (i%2 == 0)? c2 : c3;
    float ww = w/cc;

    float ric = random(colors.length);
    float acd = random(colors.length)*random(0.5, 1);
    for (int j = 0; j < cc; j++) {

      float coco = (random(1) < val)? col1 : col2;
      float xxx = xx+ww*j;
      float yyy = yy;
      float www = ww-2;
      float hhh = hh-2;
      beginShape();
      if (rndCol) fill(getColor(ric+random(acd)));
      else fill(getColor(coco));
      vertex(xxx, yyy);
      vertex(xxx+www, yyy);
      if (rndCol) fill(getColor(ric+random(acd)));
      else fill(getColor(coco+0.2));
      vertex(xxx+www, yyy+hhh);
      vertex(xxx, yyy+hhh);
      endShape(CLOSE);
      //rect(xxx, yyy, ww-2, hh-2);
      fill(0, 180);
      rect(xx+ww*j, yy, ww-2, hh*0.4-2);
    }
  }

  col = int(random(colors.length));
  col = colors.length-1;
  float d = w*0.5;
  float shd = random(random(160, 250), 250);
  beginShape(QUAD);
  fill(getColor(col), shd);
  vertex(x, y+h);
  vertex(x+w, y+h);
  fill(getColor(col-0.1), 0);
  vertex(x+w+d, y+h+d);
  vertex(x+d, y+h+d);

  fill(getColor(col), shd);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(getColor(col+0.1), 0);
  vertex(x+w+d, y+h+d);
  vertex(x+w+d, y+d);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
int colors[] = {#A32219, #C6882A, #E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #034937, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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
  return lerpColor(c1, c2, pow(v%1, 3.8));
}
