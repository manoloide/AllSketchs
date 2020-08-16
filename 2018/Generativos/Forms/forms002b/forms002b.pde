int seed = int(random(999999));
PImage[] images;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  loadForms();

  generate();
}

void loadForms() {
  PImage ori = loadImage("../forms.png");

  int cc = 16;
  int des = ori.width/cc;
  images = new PImage[cc*2];
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < cc; i++) {
      images[i+cc*j] = ori.get(i*des, j*des, des, des);
    }
  }
  ori = null;
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

  background(0);

  float des = random(10000);
  float det = random(0.06, 0.012)*0.8;
  float des2 = random(10000);
  float det2 = random(0.06, 0.012)*0.2;
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 30000; i++) {
    float x = random(width);
    float y = random(height*pow(random(0, 1), 0.8));
    float md = noise(des2+x*det2, des2+y*det2)*0.8+0.2;
    float s = noise(des+x*det, des+y*det)*120*map(y, 0, height, 0.6, 1)*md;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.01) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  imageMode(CENTER);
  noiseDetail(2);
  int c1 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c2 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c3 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  int c4 = lerpColor(rcol(), color(random(256)), random(1)*random(0.5, 1));
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    PImage img = images[int(random(images.length))];
    float x = p.x;
    float y = p.y;
    float s = p.z*0.18;

    int col = c1;
    if (random(1) < 0.5) {
      if (random(1) < 0.5) col = c1;
      else col = c2;
    } else {
      if (random(1) < 0.5) col = c3;
      else col = c4;
    }
    tint(col, 180);
    pushMatrix();
    translate(x, y);
    rotate(random(TAU));
    image(img, 0, 0, s*0.4, s*8);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
