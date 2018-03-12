int seed = int(random(999999));

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
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
  seed = int(random(999999));

  render();
}

void render() {

  noiseSeed(seed);
  randomSeed(seed);

  background(10);

  float fov = PI/random(1.1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width/2, height/2, 0);
  float size = random(600, 2400);
  float a1 = random(TWO_PI);
  float a2 = random(TWO_PI);
  float dd = size*random(0.5);
  translate(cos(a1)*cos(a2)*dd, cos(a1)*sin(a2)*dd, sin(a2)*dd);
  float dy = frameCount*random(-0.1, 0.1);
  //rotateX(dy);
  rotateX(PI);
  rotateZ(random(TWO_PI)*random(1));

  stroke(240);
  strokeWeight(0.6);
  if (random(1) < 0.5) noStroke();
  noStroke();
  int res = int(random(10, random(80, 800)));
  meshSphere(res*2, res, size);
} 

int colors[] = {#303841, #2E4750, #F6C90E, #F7F7F7};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  return lerpColor(c1, c2, m);
}


void meshSphere(int M, int N, float s) {

  float det = random(1)*random(1);
  float des = random(1000);
  float time = frameCount*random(1);
  for (int n = 0; n < N; n++) {
    float an1 = map(n, 0, N, 0, PI);
    float an2 = map(n+1, 0, N, 0, PI);
    for (int m = 0; m < M; m++) {
      float am1 = map(m, 0, M, 0, TWO_PI);
      float am2 = map(m+1, 0, M, 0, TWO_PI);

      float x1 = sin(am1)*cos(an1)*s;
      float z1 = sin(am1)*sin(an1)*s;
      float y1 = cos(am1)*s;

      float x2 = sin(am2)*cos(an1)*s;
      float z2 = sin(am2)*sin(an1)*s;
      float y2 = cos(am2)*s;

      float x3 = sin(am2)*cos(an2)*s;
      float z3 = sin(am2)*sin(an2)*s;
      float y3 = cos(am2)*s;

      float x4 = sin(am1)*cos(an2)*s;
      float z4 = sin(am1)*sin(an2)*s;
      float y4 = cos(am1)*s;


      fill(pow(noise(x1*det+des, y1*det+des, z1*det+des+time), 1.8)*500-100);
      fill(getColor(noise((x1+x3)*det+des, (y1+y3)*det+des, (z1+z3)*det+des)*9));
      beginShape();
      vertex(x1, y1, z1);
      vertex(x2, y2, z2);
      vertex(x3, y3, z3);
      vertex(x4, y4, z4);
      endShape(CLOSE);


      //point(x1, y1, z1);
    }
  }
}