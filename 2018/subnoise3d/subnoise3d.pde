import peasy.PeasyCam;

int seed = int(random(999999));
PeasyCam cam;

void setup() {
  size(960, 960, P3D);
  pixelDensity(2);
  smooth(8);
  cam = new PeasyCam(this, 400);
  generate();
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }

  void show() {
    if(w < 2 || h < 2) return;
    /*
    rectMode(CENTER);
    stroke(255);
    rect(x, y, w, h);
    */
    fill(255);
    pushMatrix();
    translate(x, y, 0);
    box(w-2, h-2, 4);
    popMatrix();
  }
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    this.w = w; 
    this.h = h;
    this.d = d;
  }

  void show() {
    float b = 0;
    if(w < b || h < b || d < b) return;
    /*
    rectMode(CENTER);
    stroke(255);
    rect(x, y, w, h);
    */
    //fill(255);
    stroke(255);
    noFill();
    pushMatrix();
    translate(x, y, z);
    box(w-b, h-b, d-b);
    box(2, 2, 2);
    popMatrix();
  }
}

void draw() {

  background(0);
  
  ortho();
  
  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  ArrayList<Box> boxes = new ArrayList<Box>();
  boxes.add(new Box(0, 0, 0, height-100, height-100, height-100));

  int sub = int(random(10, 30));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(boxes.size()));
    Box b = boxes.get(ind);
    float desNoise = random(100);
    float dt = time*random(0.05, 0.1)*2;
    float mw = b.w*0.5;
    float mh = b.h*0.5;
    float md = b.d*0.5;
    float w1 = b.w*(0.4+noise(desNoise+dt)*0.2);
    float w2 = b.w-w1;
    float h1 = b.h*(0.4+noise(desNoise+dt)*0.2);
    float h2 = b.h-h1;
    float d1 = b.d*(0.4+noise(desNoise+dt)*0.2);
    float d2 = b.d-d1;
    boxes.add(new Box(b.x-mw+w1*0.5, b.y-mh+h1*0.5, b.z-md+d1*0.5, w1, h1, d1));
    boxes.add(new Box(b.x+mw-w2*0.5, b.y-mh+h1*0.5, b.z-md+d1*0.5, w2, h1, d1));
    boxes.add(new Box(b.x+mw-w2*0.5, b.y+mh-h2*0.5, b.z-md+d1*0.5, w2, h2, d1));
    boxes.add(new Box(b.x-mw+w1*0.5, b.y+mh-h2*0.5, b.z-md+d1*0.5, w1, h2, d1));
    
    boxes.add(new Box(b.x-mw+w1*0.5, b.y-mh+h1*0.5, b.z+md-d2*0.5, w1, h1, d2));
    boxes.add(new Box(b.x+mw-w2*0.5, b.y-mh+h1*0.5, b.z+md-d2*0.5, w2, h1, d2));
    boxes.add(new Box(b.x+mw-w2*0.5, b.y+mh-h2*0.5, b.z+md-d2*0.5, w2, h2, d2));
    boxes.add(new Box(b.x-mw+w1*0.5, b.y+mh-h2*0.5, b.z+md-d2*0.5, w1, h2, d2));
    boxes.remove(ind);
  }

  noFill();
  for (int i = 0; i < boxes.size(); i++) {
    Box b = boxes.get(i);
    b.show();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key==' ') generate();
}

void generate() {
  seed = int(random(999999));
}
