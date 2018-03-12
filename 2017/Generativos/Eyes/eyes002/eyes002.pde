int seed = int(random(999999));

PImage eye;

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  eye = loadImage("eye.png");
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
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
  //background(rcol());
  //background(100, 0, 255);
  noStroke();
  imageMode(CENTER);

  for (int i = 0; i < 300; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(0.1, 0.9)*random(1);
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));
    image(eye, 0, 0, eye.width*s, eye.height*s);
    popMatrix();
  }

  for (int i = 0; i < 120; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(0.0, 0.9)*random(1);
    float dir = random(TWO_PI);
    float vel = random(4);
    float ss = random(0.94, 0.99);
    float ma = random(-0.03, 0.03);
    float tam = random(20, 300);
    int cc = int(random(20, 300));
    for (int j = 0; j < cc; j++) {
      dir += ma;
      x += cos(dir)*vel;
      y += sin(dir)*vel;
      s *= ss;
      tint(255, map(j, 0, cc, 40, 240));
      pushMatrix();
      translate(x, y);
      rotate(dir);
      image(eye, 0, 0, eye.width*s, eye.height*s);
      popMatrix();
    }
  }


  noTint();
  for (int i = 0; i < 10; i++) {
    float s = random(0.0, 0.9)*random(1);
    int cc = int(random(3, 13));
    float da = TWO_PI/cc;
    float dis = random(0.1, 0.6)*width;
    float rot = random(HALF_PI, HALF_PI);

    for (int j = 0; j < cc; j++) {
      float xx = width/2+cos(da*j)*dis;
      float yy = width/2+sin(da*j)*dis;
      pushMatrix();
      translate(xx, yy);
      rotate(j*da+rot);
      image(eye, 0, 0, eye.width*s, eye.height*s);
      popMatrix();
    }
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#0795D0, #019C54, #F5230D, #DF5A48, #F1BF16, #F0C016, #F4850C, #E13E33, #746891, #623E86, #00A2C6, #EBD417, #EADBC6
};
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