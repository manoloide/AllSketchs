int seed = int(random(999999));
PShader repeat;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  repeat = loadShader("repeat.glsl");
  repeat.set("resolution", float(width*2), float(height*2));

  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  seed = int(random(99999999));

  randomSeed(seed);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  background(255);

  stroke(0);
  strokeWeight(2);
  noFill();
  int sub = 120;//int(random(40, 80));
  int minDiv = int(random(3, random(3, 20)));
  int maxDiv = int(random(minDiv, 100));
  for (int i = 0; i < sub; i++) {
    PVector rect = rects.get(i);
    int div = int(random(minDiv, random(minDiv, maxDiv)));
    float ss = rect.z/div;
    rombo(rect.x, rect.y, ss, ss);
    int rnd = int(random(4));
    for (int k = 1; k < div/2+1; k++) {
      if (rnd == 0) {
        rect(rect.x+k*ss, rect.y, ss, ss);
        rect(rect.x, rect.y+k*ss, ss, ss);
        ellipse(rect.x+ss*(k+0.5), rect.y+ss*(0.5), ss*0.8, ss*0.8);
        ellipse(rect.x+ss*(0.5), rect.y+ss*(k+0.5), ss*0.8, ss*0.8);
      } else if (rnd == 1) {
        form1(rect.x+k*ss, rect.y, ss, ss);
        form1(rect.x, rect.y+k*ss, ss, ss);
      } else if (rnd == 2) {
        form2 (rect.x+k*ss, rect.y, ss, ss);
        form2 (rect.x, rect.y+k*ss, ss, ss);
      } else if (rnd == 3) {
        form3 (rect.x+k*ss, rect.y, ss, ss);
        form3 (rect.x, rect.y+k*ss, ss, ss);
      }
    }
    rects.add(new PVector(rect.x+ss, rect.y+ss, rect.z-ss*2.0));
  }

  filter(repeat);
}

void form1(float x, float y, float w, float h) {
  float amp = 0.5; 
  beginShape();
  vertex(x, y);
  vertex(x+w*amp, y);
  vertex(x+w, y+h-h*amp);
  vertex(x+w, y+h);
  vertex(x+w-w*amp, y+h);
  vertex(x, y+h*amp);
  endShape(CLOSE);
}

void form2(float x, float y, float w, float h) {
  float amp = 0.25; 
  beginShape();
  vertex(x, y+h*amp);
  vertex(x, y);
  vertex(x+w*amp, y);

  vertex(x+w*0.5, y+h*amp);

  vertex(x+w-w*amp, y);
  vertex(x+w, y);
  vertex(x+w, y+h*amp);

  vertex(x+w-w*amp, y+h*0.5);

  vertex(x+w, y+h-h*amp);
  vertex(x+w, y+h);
  vertex(x+w-w*amp, y+h);

  vertex(x+w*0.5, y+h-h*amp);

  vertex(x+w*amp, y+h);
  vertex(x, y+h);
  vertex(x, y+h-h*amp);

  vertex(x+w*amp, y+h*0.5);

  endShape(CLOSE);
}


void form3(float x, float y, float w, float h) {
  float amp = 0.3333;
  beginShape();
  vertex(x, y+h);
  vertex(x, y);
  vertex(x+w, y);
  vertex(x+w, y+h*amp);
  vertex(x+w*amp, y+h*amp);
  vertex(x+w*amp, y+h);
  endShape(CLOSE);
  beginShape();
  vertex(x+w*(1-amp), y+h*(1-amp));
  vertex(x+w, y+h*(1-amp));
  vertex(x+w, y+h);
  vertex(x+w*(1-amp), y+h);
  endShape(CLOSE);
}

void rombo(float x, float y, float w, float h) {
  beginShape();
  vertex(x+w*0.5, y);
  vertex(x+w, y+h*0.5);
  vertex(x+w*0.5, y+h);
  vertex(x, y+h*0.5);
  vertex(x, y+h*0.5);
  endShape(CLOSE);
}