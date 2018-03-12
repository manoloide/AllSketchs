import peasy.*;

PeasyCam cam;

void setup() {
  size(960, 540, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(400);
  pixelDensity(2);
}

void draw() {

  int seed = 0;
  randomSeed(seed);
  noiseSeed(seed);

  float time = millis()*0.001;
  background(getColor(time*0.1));
  //lights();
  noStroke();

  //translate(width*0.5, height*0.5);
  rotateX(PI*0.3);
  rotateZ(time*0.1);

  int cc = 32;
  noFill();
  stroke(0);

  float det = 0.03;
  float des = time;
  for (int i = 0; i < cc; i++) {
    float r = map(i, 0, cc, width*0.2, 0);
    int sub = int(max(16, (r*TWO_PI)*0.1));
    float da = TWO_PI/sub;
    float c1 = random(colors.length*2);
    float c2 = random(colors.length*2);
    float hh = r*map(i, 0, cc, 0.6, 1.4);
    fill(0);
    beginShape(QUADS);
    for (int j = 0; j < sub; j++) {
      float x1 = cos(da*j)*r;
      float y1 = sin(da*j)*r;
      float h1 = noise(x1*det+des, y1*det+des, time*0.003)*hh;
      float x2 = cos(da*j+da)*r;
      float y2 = sin(da*j+da)*r;
      float h2 = noise(x2*det+des, y2*det+des, time*0.003)*hh;
      int col1, col2;
      if (j*1./sub < 0.9) {
        col1 = getColor(map(j, 0, sub, c1, c2));
        col2 = getColor(map(j+1, 0, sub, c1, c2));
      } else {
        col1 = lerpColor(getColor(map(0.9, 0, 1, c1, c2)), getColor(c1), map(j*1./sub, 0.9, 1.0, 0.0, 1.0));
        col2 = lerpColor(getColor(map(0.9, 0, 1, c1, c2)), getColor(c1), map((j+1)*1./sub, 0.9, 1.0, 0.0, 1.0));
      }
      fill(col1);
      vertex(x1, y1, h1);
      vertex(x1*0.7, y1*0.7, -h1);
      fill(col2);
      vertex(x2*0.7, y2*0.7, -h2);
      vertex(x2, y2, h2);
    }
    endShape(CLOSE);
  }
}

int colors[] = {#230D51, #95E03A, #F9CD04, #F2EDED, #FF82D7};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}