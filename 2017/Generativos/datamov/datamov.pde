int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(rcol());

  float diag = dist(0, 0, width, height);
  translate(width*0.5, height*0.5);
  rotate(-PI*0.25);

  rectMode(CENTER);
  //noStroke();
  stroke(0, 70);
  for (int i = 0; i < 600; i++) {
    float x = diag*random(-0.5, 0.5);
    float y = -diag*0.5;//diag*random(-0.5, 0.5); 
    float w = diag*random(0.005, 0.055)*random(1)*random(0.5, 1);
    float h = diag*random(0.005, 0.055)*random(1)*random(0.5, 1);
    h = max(h, 3);
    float dd = random(0.2, 0.95);
    float ic = random(colors.length);
    float dc = random(100)*random(1)*random(1);
    if (random(1) < 0.3) dc = int(random(colors.length))+random(0.02);
    for (float j = 0; j < diag; j+= h) {
      fill(getColor(ic+dc*j));
      rect(x, y+j, w, h*dd);
    }
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#EAA104, #F9BBD1, #51D17C, #47A1BC, #EA2525};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}