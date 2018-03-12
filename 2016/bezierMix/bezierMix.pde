int seed;

void setup() {
  size(960, 960); 
  frameRate(30);
  seed = int(random(999999999));
  //blendMode(ADD);
}

void draw() {
  randomSeed(seed);
  background(#F0E8DA);
  int cc = int(random(3, 30*random(0.2, 1)));
  float da = TWO_PI/cc;
  float r = width*(0.35+cos(frameCount*0.01)*0.061);

  float v1 = int(random(2, 100*random(1)));
  float v2 = int(random(2, 100*random(1)));
  float amp1 = 0.4+random(1);
  float amp2 = 0.4+random(1);
  float vr1 = random(-0.2, 0.2);
  float vr2 = random(-0.2, 0.2);

  noStroke();
  int cc2 = 28;
  for (int j = 0; j < cc2; j++) {

    fill(lerpColor(color(240, 0, 40, 20), color(0, 40, 240, 20), map(j, 0, cc2-1, 0, 1)));
    beginShape();
    for (int i = 0; i < cc; i++) {
      float r1 = r*(cos((i*1./cc)*TWO_PI*v1+frameCount*vr1)*amp1);
      float r2 = r*(cos((i*1./cc)*TWO_PI*v2+frameCount*vr2)*amp2);
      float x1 = width/2+cos(da*i)*r1;
      float y1 = height/2+sin(da*i)*r1;
      float x2 = width/2+cos(da*i)*r2;
      float y2 = height/2+sin(da*i)*r2;
      float x = map(j, 0, cc2-1, x1, x2);
      float y = map(j, 0, cc2-1, y1, y2);
      vertex(x, y);
    }
    endShape();
  }
}

void keyPressed() {

  seed = int(random(999999999));
}