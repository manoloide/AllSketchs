int fps = 30;
float seconds = 3;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
  smooth(8);
  if (!export) pixelDensity(2);
  frameRate(fps);
  stroke(0);
  strokeWeight(2);
  noiseDetail(6);
  generate();
}

void draw() {
  if (export) time = map((frameCount-1), 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  generate();
}

int seed = 7997663;//int(random(9999999));

void render() {

  randomSeed(seed);
  noiseSeed(seed);
  background(255);
  beginShape();
  int def = 2000;
  float ss = 40;
  float vv, tt, xx, yy, s, d, a;
  float ax, ay;
  ax = ay = 0;
  for (int i = 1; i <= def; i++) {
    vv = pow(i*1./def, 0.7);
    tt = (map(i, -def, def, cos(time*PI)*0.5+1, 1-time)+vv*6)%2;
    s = ss*pow(1+vv*.4, 12);

    xx = width/2;
    xx += cos(tt*TWO_PI*2)*s;

    yy = height*0.3;
    yy += pow(vv, 0.8)*width*1;
    yy += sin(tt*TWO_PI*4)*ss*map(pow(vv, 0.1), 0, def, 0.2, 200);

    if (i > 1) {
      d = cnoise(vv-time*0.02, 100, 100)*4-2;
      a = atan2(ay-yy, ax-xx)+HALF_PI;
      xx += cos(a)*d;
      yy += sin(a)*d;
    }
    ax = xx;
    ay = yy;

    vertex(xx, yy);
  }
  endShape();
}

void generate() {
  randomSeed(seed);
}

float cnoise(float v, float det, float des) {
  v %= 1;
  float ang = v*TWO_PI;
  return noise(des+cos(ang)*det, des+sin(ang)*det);
}