import peasy.*;

PeasyCam cam;


int seed = int(random(99999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}

void draw() {

  float time = millis()*0.001;

  background(0);

  randomSeed(seed);
  noiseSeed(seed);

  //translate(width/2, height/2, 0);

  stroke(255);
  for (int i = 0; i < 800; i++) {
    float vel = random(0.1);
    PVector p1 = p(time*vel, i);
    PVector p2 = p(time*vel+0.003, i);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }

  float ss = 200;
  noFill();
  for (int c = 0; c < 5; c++) {
    pushMatrix();
    rotateX(random(TWO_PI)+time*random(-5, 5)*random(1));
    rotateY(random(TWO_PI)+time*random(-5, 5)*random(1));
    rotateZ(random(TWO_PI)+time*random(-5, 5)*random(1));

    int rnd = 1;//int(random(2));
    if (rnd == 0) ellipse(0, 0, ss, ss);
    if (rnd == 1) {
      int cc = int(random(3, 60));
      float da = TWO_PI/cc;
      float dt = time*random(-0.2, 0.2)*random(1);
      float amp = random(1);
      for (int i = 0; i < cc; i++) {
        arc(0, 0, ss, ss, dt+da*i, dt+da*(i+amp));
      }
    }
    popMatrix();
  }
}

PVector p(float t, float v) {
  float a1 = noise(t, v*343.5)*TWO_PI*2;
  float a2 = noise(4533.+t, v*2343.3)*TWO_PI*2;
  float dd = 120*noise(45.7+t*random(0.01), v*394.7);//random(random(30, 200), 200);
  float xx = cos(a1)*cos(a2)*dd;
  float yy = cos(a1)*sin(a2)*dd;
  float zz = sin(a1)*dd;
  return new PVector(xx, yy, zz);
}

void keyPressed() {
  seed = int(random(99999999));
}