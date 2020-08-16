import peasy.*;

int seed = int(random(999999));
PeasyCam cam;

void setup() {
  size(720, 720, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}


void draw() {
  background(20);

  randomSeed(seed);
  noiseSeed(seed);

  int res = 50000;
  float da = TWO_PI/res;
  float r = width*0.24;
  noFill();
  stroke(255);
  beginShape();
  float des1 = random(1000);
  float det1 = random(random(20));
  float time = millis()*0.001;
  //des1 += time*random(0.01);
  float des2 = random(1000);
  float det2 = random(random(20));
  //des2 += time*random(0.01);

  float tt1 = time*random(1);
  float tt2 = time*random(1);

  noiseDetail(2);
  for (int i = 0; i < res; i++) {
    float dx = cos(da*i);
    float dy = sin(da*i);
    float h = noise(dx*det1+des1, dy*det1+des1, tt1)*r;
    float rr = noise(dx*det2+des2, dy*det2+des2, tt2)*r;
    vertex(dx*rr, h, dy*rr);
  }
  endShape(CLOSE);
}


void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}