int seed = int(random(9999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}


void draw() {
  //if (frameCount%120 == 0) seed = int(random(9999999));
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  shuffleArray(colors);

  background(rcol());

  float det1 = random(0.01)*random(1);
  float det2 = random(0.01)*random(1);
  float det3 = random(0.01)*random(1);

  float amp = random(800)*random(1);
  float dc = random(4, 20)*random(1);

  //noiseDetail(int(random(16)), random(1));
  for (int j = 0; j < height*2; j++) {
    for (int i = 0; i < width*2; i++) {
      float ang = fbm(i*det2, j*det2)*TWO_PI*2;
      float des = fbm(i*det3, j*det3)*amp;
      float xx = i+cos(ang)*des;
      float yy = j+sin(ang)*des;
      int col = getColor(fbm(xx*det1, yy*det1)*colors.length*dc);
      set(i, j, col);
    }
  }
}

float fbm(float x, float y) {   
  float z=2.;
  float rz = 0.;
  float xx = x;
  float yy = y;
  for (float i= 1.; i < 8.; i++)
  {
    rz+= abs((noise(xx, yy)-0.5)*2.)/z;
    z = z*2.;
    xx = xx*2.;
    yy = yy*2.;
  }
  return rz;
}

//https://coolors.co/280f04-e2dcd0-bf1a2b-417f5c-6898c1
//int colors[] = {#280f04, #e2dcd0, #bf1a2b, #417f5c, #6898c1};
int colors[] = {#000000, #FFFFFF, #FF7700, #000000, #15FF4A, #000000, #000000, #BBBBFF};

int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}

import java.util.Random;
import java.util.Arrays;
void shuffleArray(int[] array) {

  // with code from WikiPedia; Fisher–Yates shuffle 
  //@ <a href="http://en.wikipedia.org/wiki/Fisher" target="_blank" rel="nofollow">http://en.wikipedia.org/wiki/Fisher</a>–Yates_shuffle

  Random rng = new Random();

  // i is the number of items remaining to be shuffled.
  for (int i = array.length; i > 1; i--) {

    // Pick a random element to swap with the i-th element.
    int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)

    // Swap array elements.
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}