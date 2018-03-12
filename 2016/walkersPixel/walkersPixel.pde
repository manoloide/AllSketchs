ArrayList<Walker> walkers;
int seed = int(random(999999999));
PShader post;

void setup() {
  size(960, 960, P3D); 
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));

  walkers = new ArrayList<Walker>();
  for (int i = 0; i < 20; i++) {
    walkers.add(new Walker());
  }
}

void draw() {
  post.set("time", millis()/1000.);
  //blendMode(ADD);
  translate(width/2, height/2);
  background(8);
  stroke(30);
  //drawGrid(width, height, 20);

  randomSeed(seed);
  int ss = 20;
  int cw = width/ss;
  int ch = height/ss;
  float dx = ss*cw/2;
  float dy = ss*ch/2;
  noStroke();
  float time = 40+frameCount/60.;
  float det = 0.05;
  rectMode(CORNER);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float des = time*random(0.1, 0.6);
      fill(10+pow(noise(i*det+des, j*det+des), 3)*90);
      rect(-dx+ss*i, -dy+ss*j, ss, ss);
    }
  }

  for (int i = 0; i < walkers.size(); i++) {
    walkers.get(i).update();
  }


  if (frameCount%40 == 0) {
    for (int i = 0; i < walkers.size(); i++) {
      walkers.get(i).move();
    }
  }

  filter(post);
}

void keyPressed() {
  seed = int(random(999999999));
}

void drawGrid(float w, float h, int cc) {
  float mw = w/2;
  float mh = h/2;
  for (int i = 0; i <= w; i+=cc) {
    line(i-mw, -mh, i-mw, mh);
  } 
  for (int i = 0; i <= h; i+=cc) {
    line(-mw, i-mh, mw, i-mh);
  }
}


class Walker {
  PVector p1, p2, tp1, tp2;
  Walker() {
    p1 = new PVector();
    p2 = new PVector();
    tp1 = new PVector();
    tp2 = new PVector();
  }
  void update() {
    PVector v1 = tp1.copy();
    v1.sub(p1);
    v1.mult(0.16);
    p1.add(v1);
    PVector v2 = tp2.copy();
    v2.sub(p2);
    v2.mult(0.16);
    p2.add(v2);


    if (int(p1.x) != int(p2.x) && int(p1.y) != int(p2.y)) {
      show();
    }
  }

  void show() {
    rectMode(CORNERS);
    stroke(#1BF087, 60);
    fill(#1BF087, 20);
    rect(p1.x, p1.y, p2.x, p2.y);
    rectMode(CENTER);
    noStroke();
    fill(#1BF087);
    rect(p1.x, p1.y, 4, 4);
    rect(p2.x, p1.y, 4, 4);
    rect(p1.x, p2.y, 4, 4);
    rect(p2.x, p2.y, 4, 4);
  }

  void move() {  
    float time = 40+frameCount/60.;  
    for (int i = 0; i < int(time*454.504)%200; i++) random(3);
    PVector d1 = new PVector(int(random(3))-1, int(random(3))-1);
    d1.mult(20);
    PVector d2 = new PVector(int(random(3))-1, int(random(3))-1);
    d2.mult(20);
    tp1.add(d1);
    tp2.add(d2);
  }
}