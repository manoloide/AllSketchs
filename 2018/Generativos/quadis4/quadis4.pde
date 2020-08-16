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
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  noStroke();
  for (int i = 0; i < 10000; i++) {
    float ss = width/pow(2, int(random(4, 11)));
    float x = random(width+ss);
    float y = random(height+ss);
    x -= x%ss;
    y -= y%ss;

    float dd = ss*random(1);

    /*
    fill(0, 80);
     beginShape();
     vertex(x, y, ss, ss);
     vertex(x+ss, y, ss, ss);
     fill(0, 0);
     vertex(x+ss+dd, y+dd, ss, ss);
     */

    beginShape();
    fill(0, 100);
    vertex(x+ss, y, ss, ss);
    vertex(x+ss, y+ss, ss, ss);
    fill(0, 0);
    vertex(x+ss+dd, y+ss+dd, ss, ss);
    vertex(x+ss+dd, y+dd, ss, ss);
    endShape(CLOSE);

    beginShape();
    fill(0, 100);
    vertex(x, y+ss, ss, ss);
    vertex(x+ss, y+ss, ss, ss);
    fill(0, 0);
    vertex(x+ss+dd, y+ss+dd, ss, ss);
    vertex(x+dd, y+ss+dd, ss, ss);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    vertex(x, y, ss, ss);
    vertex(x+ss, y, ss, ss);
    vertex(x+ss, y+ss, ss, ss);
    vertex(x, y+ss, ss, ss);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};
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