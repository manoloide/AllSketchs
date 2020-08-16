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

  stroke(240); 
  noFill();

  translate(width/2, height/2);
  rotate(random(TWO_PI));

  float diag = dist(0, 0, width, height);

  int c1 = int(random(40, random(40, 800)));
  float amp1 = random(1, random(1, random(1, 90)));
  float amp2 = random(1, random(1, random(1, 90)));
  float sh = diag/c1;
  for (int i = 0; i < c1; i++) {
    float yy1 = sh*i-diag*0.5;
    float yy2 = sh*(i+1)-diag*0.5;

    int c2 = int(random(8, random(8, 100)));
    float sw = diag*0.5/c2;
    //stroke(255);
    //line(0, yy, -diag*0.5, yy*amp1);
    //line(0, yy, +diag*0.5, yy*amp2);

    //stroke(255, 0, 0);
    noStroke();
    float ic = random(1, random(100));
    float dc = random(colors.length)*random(1)*random(1);

    for (int j = 0; j < c2; j++) {
      float y1 = map(j, 0, c2, yy1*amp1, yy1);
      float y2 = map(j+1, 0, c2, yy1*amp1, yy1);
      float y3 = map(j+1, 0, c2, yy2*amp1, yy2);
      float y4 = map(j, 0, c2, yy2*amp1, yy2);
      float x1 = sw*j-diag*0.5;
      float x2 = sw*(j+1)-diag*0.5;
      fill(getColor(ic+dc*j));
      beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(x2, y3);
      vertex(x1, y4);
      endShape(CLOSE);
    }
    for (int j = 0; j < c2; j++) {
      float y1 = map(j, 0, c2, yy1*amp2, yy1);
      float y2 = map(j+1, 0, c2, yy1*amp2, yy1);
      float y3 = map(j+1, 0, c2, yy2*amp2, yy2);
      float y4 = map(j, 0, c2, yy2*amp2, yy2);
      float x1 = diag*0.5-sw*j;
      float x2 = diag*0.5-sw*(j+1);
      fill(getColor(ic+dc*j+c2));
      beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(x2, y3);
      vertex(x1, y4);
      endShape(CLOSE);
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