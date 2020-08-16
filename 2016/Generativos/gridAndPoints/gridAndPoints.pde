void setup() {
  size(960, 960); 
  smooth(8);
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
  background(250);
  for (int k = 0; k < 5; k++) {
    filter(INVERT);
    int count = int(random(10, 200*random(1)));
    float ss = width*1./(count+1);

    float des = ss;
    float det = random(0.1);
    noStroke();
    fill(10);
    for (int j = -2; j < count+2; j++) {
      for (int i = -2; i < count+2; i++) {
        float s = ss*(0.5+noise(i*det+34, j*det+34)*0.5);
        float x = des+i*ss+ss*noise(i*det, j*det)*0.5;
        float y = des+j*ss+ss*noise(i*det+100, j*det+100)*0.5;
        ellipse(x, y, s, s);
      }
    }
  }
}