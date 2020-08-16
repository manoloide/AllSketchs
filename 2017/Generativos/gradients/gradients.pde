int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
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
  background(0);


  int ch = int(random(3, 10));
  float sh = height*1./ch;

  noStroke();
  for (int j = 0; j < ch; j++) {
    int cw = int(random(30, 100));
    float sw = width*1./cw;
    float ic = random(colors.length);
    float dc = random(colors.length)*random(1)*random(1);
    shuffleArray(colors);
    for (int i = 0; i < cw; i++) {
      fill(getColor(ic+dc*i));
      rect(i*sw, j*sh, sw, sh);
    }
  }
}

//https://coolors.co/ffffff-09080c-d1370c-094c22-c997a7
int colors[] = {#ffffff, #09080c, #d1370c, #094c22, #c997a7};

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

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}