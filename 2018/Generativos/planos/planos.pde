int seed = int(random(999999));
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  post = loadShader("post.glsl");

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
  background(240);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  float bb = 4;

  int sub = int (random(80));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    int div = int(random(2, 4));
    float ms = r.z/div;
    if(ms < 5) continue;
    for (int dy = 0; dy < div; dy++) {
      for (int dx = 0; dx < div; dx++) {
        rects.add(new PVector(r.x+dx*ms, r.y+dy*ms, ms));
      }
    }
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float xx = r.x+bb*0.5;
    float yy = r.y+bb*0.5;
    float ww =  r.z-bb;
    float hh =  r.z-bb;
    stroke(color(0), 6);
    fill((random(1) < 0.5)?248:0, 220);
    rect(xx, yy, ww, hh);
  }

  post = loadShader("post.glsl");
  //filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
