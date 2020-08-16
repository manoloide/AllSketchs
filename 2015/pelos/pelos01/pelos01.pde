float time;
int seed;
PGraphics mask;

void setup() {
  size(960, 960);
  generate();
  //println(seed);
  seed = 766541440;
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.textAlign(CENTER, CENTER);
  mask.fill(255);
  mask.textSize(120);
  mask.text("Kierbel", width/2, height/2);
  mask.endDraw();
}

void draw() {
  time += 1./120;
  background(250);
  randomSeed(seed);
  noiseSeed(seed);
  float det = 0.006;
  stroke(0, 40);
  for (int i = 0; i < 420000; i++) {
    float x = random(-40, width+40);
    float y = random(-40, height+40);
    float n = noise(x*det, y*det);
    float a = n*TWO_PI+TWO_PI*time;
    float md = map(brightness(mask.get(int(x), int(y))), 0, 255, 0.2, 1.4);
    if (md <= 0.201) continue;
    float d = map(n, 0, 1, 2, 32*md+cos(time*TWO_PI+x+y)*10); 
    line(x, y, x+cos(a)*d, y+sin(a)*d);
  }
  //image(mask, 0, 0);
  //saveFrame("####.png");

  if (time > 1) {
    exit();
  }
} 

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999999));
}

